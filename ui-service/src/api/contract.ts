import request from '../utils/request'
import type { PageResponse } from '../types'
import {Ref, UnwrapRef} from "vue";

export interface ContractQuery {
  pageNum: number
  pageSize: number
  sortBy?: string
  asc?: boolean
  userId?: number
  status?: string
}

export interface ContractForm {
  id?: number
  title: string
  content: string
  totalAmount: number
  clientId: number
  userId: number
  status?: string
}

export interface ContractInfo {
  id: number
  title: string
  content: string
  totalAmount: number
  clientId: number
  clientName: string
  userId: number
  userName: string
  status: string
  createTime: string
  updateTime: string
}

export interface ContractApproval {
  id?: number
  contractId: number
  userId: number
  userName?: string
  approvalOpinion: string
  status: number
  createTime?: string
  updateTime?: string
}

export const contractApi = {
  // 获取合同列表
  getContracts(data: ContractQuery): Promise<PageResponse<ContractInfo>> {
    return request({
      url: '/contract/page',
      method: 'post',
      data
    })
  },

  // 获取合同详情
  getContract(id: number) {
    return request({
      url: `/contract/get/${id}`,
      method: 'get'
    })
  },

  // 创建合同
  createContract(data: {
    number: string;
    totalAmount: number;
    clientId: number extends (Builtin | Ref | RefUnwrapBailTypes[keyof RefUnwrapBailTypes] | {
      [RawSymbol]?: true
    }) ? number : (number extends Map<infer K, infer V> ? (Map<K, UnwrapRefSimple<V>> & UnwrapRef<Omit<number, keyof Map<any, any>>>) : (number extends WeakMap<infer K, infer V> ? (WeakMap<K, UnwrapRefSimple<V>> & UnwrapRef<Omit<number, keyof WeakMap<any, any>>>) : (number extends Set<infer V> ? (Set<UnwrapRefSimple<V>> & UnwrapRef<Omit<number, keyof Set<any>>>) : (number extends WeakSet<infer V> ? (WeakSet<UnwrapRefSimple<V>> & UnwrapRef<Omit<number, keyof WeakSet<any>>>) : (number extends ReadonlyArray<any> ? { [K in keyof number]: UnwrapRefSimple<number[K]> } : (number extends (object & {
      [ShallowReactiveMarker]?: never
    }) ? { [P in keyof number]: P extends symbol ? number[P] : UnwrapRef<number[P]> } : number))))));
    userId: any;
    content: string extends (Builtin | Ref | RefUnwrapBailTypes[keyof RefUnwrapBailTypes] | {
      [RawSymbol]?: true
    }) ? string : (string extends Map<infer K, infer V> ? (Map<K, UnwrapRefSimple<V>> & UnwrapRef<Omit<string, keyof Map<any, any>>>) : (string extends WeakMap<infer K, infer V> ? (WeakMap<K, UnwrapRefSimple<V>> & UnwrapRef<Omit<string, keyof WeakMap<any, any>>>) : (string extends Set<infer V> ? (Set<UnwrapRefSimple<V>> & UnwrapRef<Omit<string, keyof Set<any>>>) : (string extends WeakSet<infer V> ? (WeakSet<UnwrapRefSimple<V>> & UnwrapRef<Omit<string, keyof WeakSet<any>>>) : (string extends ReadonlyArray<any> ? { [K in keyof string]: UnwrapRefSimple<string[K]> } : (string extends (object & {
      [ShallowReactiveMarker]?: never
    }) ? { [P in keyof string]: P extends symbol ? string[P] : UnwrapRef<string[P]> } : string))))))
  }) {
    return request({
      url: '/contract/create',
      method: 'post',
      data
    })
  },

  // 删除合同
  deleteContract(id: number) {
    return request({
      url: `/contract/delete/${id}`,
      method: 'delete'
    })
  },

  // 更新合同状态
  updateStatus(id: number, action: 'pending' | 'approve' | 'reject' | 'complete' | 'cancel') {
    return request({
      url: `/contract/${action}/${id}`,
      method: 'post'
    })
  },

  // 获取合同审批记录
  getApprovals(contractId: number) {
    return request({
      url: `/contract-approval/by-contract-id/${contractId}`,
      method: 'get'
    })
  },

  // 创建审批记录
  createApproval(data: ContractApproval) {
    return request({
      url: '/contract-approval',
      method: 'post',
      data
    })
  },

  // 通过审批
  passApproval(id: number, comment: string) {
    return request({
      url: `/contract-approval/pass/${id}`,
      method: 'post',
      params: { comment }
    })
  },

  // 驳回审批
  rejectApproval(id: number, comment: string) {
    return request({
      url: `/contract-approval/reject/${id}`,
      method: 'post',
      params: { comment }
    })
  }
} 