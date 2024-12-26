import request from '../utils/request'
import type { PageResponse, ClientForm } from '../types'

export interface ClientQuery {
  pageNum: number
  pageSize: number
  sortBy?: string
  asc?: boolean
  name?: string
  status?: string
  sum?: number
  userId?: number
}

export interface ClientInfo {
  id: number
  name: string
  status: string
  sum: number
  userId: number
  userName: string
  lastTime: string
}

export const clientApi = {
  // 获取客户列表
  getClients(data: ClientQuery): Promise<PageResponse<ClientInfo>> {
    const url = data.userId ? `/client/page/${data.userId}` : '/client/pageAll'
    return request({
      url,
      method: 'post',
      data
    })
  },
  getClientCount(userId: number | undefined) {
    return request({
      url: `/client/count`,
      method: 'get',
      params: { userId }
    })
  },
  // 获取客户详情
  getClientDetail(id: number) {
    return request({
      url: `/client/get/${id}`,
      method: 'get'
    })
  },
  updateClient(client: ClientForm) {
    return request({
      url: '/client/update',
      method: 'post',
      data: client
    })
  },
  addClient(client: ClientForm) {
    return request({
      url: '/client/add',
      method: 'post',
      data: client
    })
  },
  changeUser(clientId: number, userId: number, password: string) {
    return request({
      url: '/client/changeUser',
      method: 'post',
      params: { clientId, userId, password }
    })
  },
  getAllClients(userId: number | undefined) {
    return request({
      url: `/client/getAll`,
      method: 'get',
      params: { userId }
    })
  },
  deleteClient(id: number) {
    return request.delete(`/client/remove/${id}`)
  },
  // 获取客户状态分布
  getClientStatusDistribution(userId?: number) {
    return request({
      url: '/client/status-distribution',
      method: 'get',
      params: { userId }
    })
  },
  // 获取客户等级分布
  getCustomerLevelDistribution(userId?: number) {
    return request({
      url: '/client/client-rfm/customer-level',
      method: 'get',
      params: { userId }
    })
  },
  // 更新RFM数据
  updateRfm(userId?: number) {
    return request({
      url: '/client/client-rfm/update',
      method: 'post',
      params: { userId }
    })
  },
  // 获取高价值客户
  getValueCustomers(data: {
    pageNum: number
    pageSize: number
    userId?: number
    customerLevel?: string
  }) {
    return request({
      url: '/client/client-rfm/pageValue',
      method: 'post',
      data
    })
  }
}
