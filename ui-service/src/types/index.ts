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

// 用户查询参数类型
export interface UserQuery {
  pageNum: number
  pageSize: number
  sortBy?: string
  isAsc?: boolean
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
  msg: string
  data: UserInfo
} 