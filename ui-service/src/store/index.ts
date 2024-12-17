import { createStore, Commit } from 'vuex'
import { userModule } from './modules/user'
import type { RootState } from '../types/store'

export default createStore<RootState>({
  state: {
    loading: false,
    theme: 'light'
  },
  mutations: {
    SET_LOADING(state: RootState, loading: boolean) {
      state.loading = loading
    },
    SET_THEME(state: RootState, theme: 'light' | 'dark') {
      state.theme = theme
    }
  },
  actions: {
    setLoading({ commit }: { commit: Commit }, loading: boolean) {
      commit('SET_LOADING', loading)
    },
    setTheme({ commit }: { commit: Commit }, theme: 'light' | 'dark') {
      commit('SET_THEME', theme)
      localStorage.setItem('theme', theme)
    }
  },
  modules: {
    user: userModule
  }
}) 