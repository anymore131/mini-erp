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
  },

  // 获取订单明细
  getOrderItems(orderId: number) {
    return request({
      url: `/order/order-item/list/${orderId}`,
      method: 'get'
    })
  },

  // 添加订单明细
  addOrderItem(data: any) {
    return request({
      url: '/order/order-item/add',
      method: 'post',
      data
    })
  },

  // 删除订单明细
  deleteOrderItem(id: number) {
    return request({
      url: `/order/order-item/remove/${id}`,
      method: 'delete'
    })
  },

  // 提交检验
  submitCheck(id: number) {
    return request({
      url: `/order/order/pending/${id}`,
      method: 'post'
    })
  },

  // 通过审核
  approveOrder(id: number) {
    return request({
      url: `/order/order/approve/${id}`,
      method: 'post'
    })
  },

  // 拒绝审核
  rejectOrder(id: number) {
    return request({
      url: `/order/order/reject/${id}`,
      method: 'post'
    })
  },

  // 更新订单明细
  updateOrderItem(data: any) {
    return request({
      url: '/order/order-item/update',
      method: 'post',
      data
    })
  },

  // 取消订单
  cancelOrder(id: number) {
    return request({
      url: `/order/order/cancel/${id}`,
      method: 'post'
    })
  },

  // 订单审批记录
  getOrderApprovals(orderId: number) {
    return request.get(`/order/order-approval/list/${orderId}`)
  },

  // 提交审批
  submitApproval(data: {
    orderId: number
    approverId: number
    status: string
    comment: string
  }) {
    return request.post('/order/order-approval/add', data)
  }
} 