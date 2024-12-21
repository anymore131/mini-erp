import request from '../utils/request'
import type { LoginForm, UserForm, UserQuery, LoginResponse, UserInfo, PageResponse, PageQuery } from '../types'

export const userApi = {
  // 登录
  login(data: LoginForm): Promise<LoginResponse> {
    return request({
      url: '/user/login',
      method: 'post',
      data
    })
  },

  // 获取用户列表
  getUsers(data: UserQuery): Promise<PageResponse<UserInfo>> {
    return request({
      url: '/user/page',
      method: 'post',
      data: {
        pageNum: data.pageNum,
        pageSize: data.pageSize,
        sortBy: data.sortBy || 'create_time',
        asc: data.asc === undefined ? true : data.asc,
        userName: data.userName || null,
        realName: data.realName || null,
        role: data.role || null
      }
    })
  },

  // 添加用户
  addUser(data: UserForm) {
    return request({
      url: '/user/add',
      method: 'put',
      data
    })
  },

  // 更新用户
  updateUser(data: UserForm) {
    return request({
      url: '/user/update',
      method: 'put',
      data
    })
  },

  // 删除用户
  deleteUser(id: number) {
    return request({
      url: '/user/delete',
      method: 'delete',
      params: { id }
    })
  },

  // 重置密码
  resetPassword(data: { userId: number; newPassword: string }) {
    return request({
      url: '/user/resetPassword',
      method: 'put',
      data
    })
  },

  // 修改密码
  updatePassword(data: { oldPassword: string; newPassword: string }) {
    return request({
      url: '/user/updatePassword',
      method: 'put',
      data
    })
  },

  // 获取用户信息
  getUserInfo() {
    return request({
      url: '/user/info',
      method: 'get'
    })
  },

  // 更新用户信息
  updateUserInfo(data: Partial<UserInfo>) {
    return request({
      url: '/user/info',
      method: 'put',
      data
    })
  },

  // 获取用户详情
  get(id: number) {
    return request({
      url: `/user/get/${id}`,
      method: 'get'
    })
  },

  getUsersName(data: PageQuery): Promise<PageResponse<UserInfo>> {
    return request({
      url: '/user/getUsers',
      method: 'post',
      data
    })
  }
}
