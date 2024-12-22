import request from '../utils/request'
import type { PageResponse, OrderForm, OrderQuery, OrderInfo } from '../types'

export const orderApi = {
  // 获取订单列表
  getOrders(data: OrderQuery): Promise<PageResponse<OrderInfo>> {
    return request({
      url: '/order/order/page',
      method: 'post',
      data
    })
  },

  // 获取订单详情
  getOrderDetail(id: number) {
    return request({
      url: `/order/order/get/${id}`,
      method: 'get'
    })
  },

  // 创建订单
  addOrder(data: OrderForm) {
    return request({
      url: '/order/order/add',
      method: 'post',
      data
    })
  },

  // 获取订单文件列表
  getOrderFiles(orderId: number) {
    return request({
      url: `/order/order-file/list/${orderId}`,
      method: 'get'
    })
  },

  // 上传订单文件
  uploadOrderFile(orderId: number, data: FormData) {
    return request({
      url: `/order/order-file/add/${orderId}`,
      method: 'post',
      headers: {
        'Content-Type': 'multipart/form-data'
      },
      data
    })
  },

  // 删除订单文件
  deleteOrderFile(fileId: number) {
    return request({
      url: `/order/order-file/remove/${fileId}`,
      method: 'delete'
    })
  }
} 