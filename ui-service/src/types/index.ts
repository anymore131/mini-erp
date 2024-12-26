// 登录表单类型
export interface LoginForm {
  userName: string
  password: string
}

// 用户表单类型
export interface UserForm {
  id?: number | null
  userName: string
  realName: string
  email: string
  phone: string
  role: string
  password?: string
}

export interface PageQuery {
  pageNum: number
  pageSize: number
  sortBy?: string
  asc?: boolean
}

// 用户查询参数类型
export interface UserQuery {
  pageNum: number
  pageSize: number
  sortBy?: string
  asc?: boolean
  userName?: string | undefined
  realName?: string | undefined
  role?: string | undefined
}

// 分页响应类型
export interface PageResponse<T> {
  code: number
  msg: string
  data: {
    total: number
    pages: number
    list: T[]
  }
}

// 用户信息类型
export interface UserInfo {
  id: number
  userName: string
  email: string
  realName: string
  phone: string
  role: string
  createTime: string | null
  lastUpdate: string
}

// 登录响应类型
export interface LoginResponse {
  code: number
  message: string
  data: UserInfo
}

// 客户状态枚举映射
export const CLIENT_STATUS_CODE_MAP: Record<string, string> = {
  '已添加': 'START',
  '正在合作': 'COOPERATION',
  '未开展合作': 'WAITING'
}

export const CLIENT_STATUS_MAP: Record<string, string> = {
  'START': '已添加',
  'COOPERATION': '正在合作',
  'WAITING': '未开展合作'
}

export const CLIENT_STATUS_OPTIONS = [
  '已添加',
  '正在合作',
  '未开展合作'
]

export interface ClientInfo {
  id: number
  name: string
  status: string
  sum: number
  userId: number
  userName: string
  lastTime: string
  mobile?: string
  email?: string
  address?: string
  remark?: string
}

export interface ClientForm {
  id?: number
  name: string
  mobile?: string
  email?: string
  address?: string
  userId: number
  status?: string
  remark?: string
}

export interface SimpleUser {
  id: number
  realName: string
}

// 订单状态映射
export const ORDER_STATUS_MAP: Record<string, string> = {
  'DRAFT': '起草',
  'PENDING': '待检验',
  'APPROVED': '检验通过',
  'REJECTED': '未通过',
  'COMPLETED': '完成的',
  'CANCELLED': '取消的'
}

// 订单信息类型
export interface OrderInfo {
  id: number
  orderNo: string
  clientId: number
  clientName: string
  userId: number
  userName: string
  totalAmount: number
  status: string
  remark: string
  createTime: string
  updateTime: string
}

// 订单查询参数
export interface OrderQuery extends PageQuery {
  orderNo?: string
  clientId?: number
  userId?: number
  status?: string
  minAmount?: number
  maxAmount?: number
  startTime?: string
  endTime?: string
}

// 订单表单类型
export interface OrderForm {
  clientId: number
  userId: number
  remark?: string
}

export interface FileQuery {
  pageNum: number
  pageSize: number
  sortBy?: string
  asc?: boolean
}

export interface FileInfo {
  id: number
  fileName: string
  contentType: string
  createTime: string
  url: string
  uuidFileName: string
}

export interface ClientRfm {
  clientId: number
  clientName: string
  userId: number
  userName: string
  lastOrderTime: string
  orderFrequency: number
  totalAmount: number
  rfmScore: number
  customerLevel: string
}

export const CUSTOMER_LEVEL_MAP: Record<string, string> = {
  'A': '高价值客户',
  'B': '重要发展客户',
  'C': '一般价值客户',
  'D': '低价值客户'
}
 