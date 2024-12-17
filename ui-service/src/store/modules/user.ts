import { Module, ActionContext } from 'vuex'
import { userApi } from '../../api/user'
import type { UserState, RootState } from '../../types/store'
import type { LoginForm, UserInfo } from '../../types'

export const userModule: Module<UserState, RootState> = {
  namespaced: true,
  
  state: {
    isLoggedIn: !!localStorage.getItem('token'),
    userInfo: null,
    role: '',
    token: localStorage.getItem('token')
  },

  mutations: {
    SET_TOKEN(state: UserState, token: string) {
      state.token = token
      state.isLoggedIn = true
      localStorage.setItem('token', `Bearer ${token}`)
    },
    SET_USER_INFO(state: UserState, userInfo: UserInfo) {
      state.userInfo = userInfo
      state.role = userInfo.role
    },
    CLEAR_USER_STATE(state: UserState) {
      state.token = null
      state.userInfo = null
      state.isLoggedIn = false
      state.role = ''
      localStorage.removeItem('token')
    }
  },

  actions: {
    // 登录
    async login({ commit }: ActionContext<UserState, RootState>, loginForm: LoginForm) {
      try {
        const res = await userApi.login(loginForm)
        commit('SET_TOKEN', res.token)
        commit('SET_USER_INFO', res.userInfo)
        return res
      } catch (error) {
        throw error
      }
    },

    // 退出登录
    async logout({ commit }: ActionContext<UserState, RootState>) {
      commit('CLEAR_USER_STATE')
    },

    // 获取用户信息
    async getUserInfo({ commit, state }: ActionContext<UserState, RootState>) {
      try {
        if (!state.token) return null
        const res = await userApi.getUserInfo()
        commit('SET_USER_INFO', res)
        return res
      } catch (error) {
        commit('CLEAR_USER_STATE')
        throw error
      }
    },

    // 设置用户信息
    setUserInfo({ commit }: ActionContext<UserState, RootState>, userInfo: UserInfo) {
      commit('SET_USER_INFO', userInfo)
    }
  },

  getters: {
    isAdmin: (state: UserState) => state.role === 'admin',
    username: (state: UserState) => state.userInfo?.username || '',
    userId: (state: UserState) => state.userInfo?.id
  }
} 