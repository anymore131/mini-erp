import request from '../utils/request'
import type { PageResponse } from '../types'

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
  }
} 