import { UserInfo } from './index'

// 用户模块状态类型
export interface UserState {
  isLoggedIn: boolean
  userInfo: UserInfo | null
  role: string
  token: string | null
}

// 根状态类型
export interface RootState {
  loading: boolean
  theme: 'light' | 'dark'
}

// 完整的状态类型
export interface State extends RootState {
  user: UserState
} 