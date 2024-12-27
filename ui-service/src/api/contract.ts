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

export interface ContractProgress {
  id?: number
  contractId: number
  progress: number
  description: string
  createTime?: string
  updateTime?: string
}

export interface ContractLogInfo {
  id: number
  contractId: number
  userId: number
  userName: string
  action: string
  content: string
  createTime: string
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
      url: `/contract/${id}`,
      method: 'get'
    })
  },

  // 创建合同
  createContract(data: ContractForm) {
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
  },

  // 获取合同进度列表
  getProgressList(contractId: number) {
    return request({
      url: '/contract-progress/page',
      method: 'post',
      data: {
        contractId,
        pageNum: 1,
        pageSize: 1000
      }
    })
  },

  // 获取最新进度
  getLatestProgress(contractId: number) {
    return request({
      url: `/contract-progress/latest/${contractId}`,
      method: 'get'
    })
  },

  // 添加进度
  addProgress(data: ContractProgress) {
    return request({
      url: '/contract-progress',
      method: 'post',
      data
    })
  },

  // 更新进度
  updateProgress(id: number, data: ContractProgress) {
    return request({
      url: `/contract-progress/${id}`,
      method: 'put',
      data
    })
  },

  // 删除进度
  deleteProgress(id: number) {
    return request({
      url: `/contract-progress/${id}`,
      method: 'delete'
    })
  },

  // 获取合同日志
  getContractLogs(data: {
    pageNum: number
    pageSize: number
    id?: string
    userName?: string
    action?: string
    sortBy?: string
    asc?: boolean
  }): Promise<PageResponse<ContractLogInfo>> {
    return request({
      url: '/contract/log/page',
      method: 'post',
      data
    })
  }
} 