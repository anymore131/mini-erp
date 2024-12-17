import { computed } from 'vue'
import type { Store } from 'vuex'
import store from '../store'
import type { State } from '../types/store'
import type { LoginForm, UserInfo } from '../types'

// 使用类型断言
const baseUseStore = () => store as Store<State>
export function useStore() {
  const store = baseUseStore()

  return {
    store,
    // 用户相关
    isLoggedIn: computed(() => store.state.user.isLoggedIn),
    userInfo: computed(() => store.state.user.userInfo),
    isAdmin: computed(() => store.getters['user/isAdmin']),
    username: computed(() => store.getters['user/username']),
    
    // 全局状态
    loading: computed(() => store.state.loading),
    theme: computed(() => store.state.theme),

    // 方法
    setLoading: (loading: boolean) => store.dispatch('setLoading', loading),
    setTheme: (theme: 'light' | 'dark') => store.dispatch('setTheme', theme),
    login: (form: LoginForm) => store.dispatch('user/login', form),
    logout: () => store.dispatch('user/logout'),
    getUserInfo: () => store.dispatch('user/getUserInfo'),
    setUserInfo: async (userInfo: UserInfo | null) => {
      if (!userInfo) return
      
      store.dispatch('user/setUserInfo', userInfo)
      store.state.user.userInfo = userInfo
      store.state.user.isLoggedIn = true
      store.state.user.isAdmin = userInfo.role === 'admin'
    }
  }
} 