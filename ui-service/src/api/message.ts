import messageRequest from '@/utils/messageRequest'
import type { PageResponse } from '../types'

export interface MessageQuery {
  pageNum?: number
  pageSize?: number
  sortBy?: string
  asc?: boolean
  userId?: number
}

export interface MessageInfo {
  id: number
  content: string
  type: number
  sendTime: string
  contractId: number
  userId: number
}

export interface SaResult<T> {
  code: number
  msg: string
  data: T
}

export const messageApi = {
  // 获取消息列表
  getMessageList(params: MessageQuery = { pageNum: 1, pageSize: 10 }): Promise<SaResult<PageResponse<MessageInfo>>> {
    console.log('发起获取消息列表请求，参数:', params)
    return messageRequest({
      url: '/list',
      method: 'get',
      params
    })
  },

  // 标记消息为已读
  markRead(id: number): Promise<SaResult<MessageInfo>> {
    console.log('发起标记已读请求，消息ID:', id)
    return messageRequest.put(`/markRead/${id}`)
  },

  // 删除消息
  deleteMessage(id: number) {
    console.log('发起删除消息请求，消息ID:', id)
    return messageRequest.delete(`/delete?id=${id}`)
  }
}