import { createRouter, createWebHistory, RouteRecordRaw } from 'vue-router'
import { useStore } from '../hooks/useStore'


declare module 'vue-router' {
  interface RouteMeta {
    requiresAuth: boolean
    roles?: string[]
  }
}

const routes: RouteRecordRaw[] = [
  {
    path: '/login',
    name: 'Login',
    component: () => import('../views/Login.vue'),
    meta: { requiresAuth: false }
  },
  {
    path: '/',
    name: 'Layout',
    component: () => import('../views/Layout.vue'),
    meta: { requiresAuth: true },
    children: [
      {
        path: '',
        redirect: '/dashboard'
      },
      {
        path: 'dashboard',
        name: 'Dashboard',
        component: () => import('../views/Dashboard.vue'),
        meta: { requiresAuth: true }
      },
      {
        path: 'user-manage',
        name: 'UserManage',
        component: () => import('../views/user/UserManage.vue'),
        meta: { requiresAuth: true }
      },
      {
        path: 'client-manage',
        name: 'ClientManage',
        component: () => import('../views/client/ClientManage.vue'),
        meta: { requiresAuth: true }
      },
      {
        path: 'client-manage/:userId',
        name: 'MyClientManage',
        component: () => import('../views/client/ClientManage.vue'),
        meta: { requiresAuth: true }
      },
      {
        path: 'client/:id',
        name: 'ClientDetail',
        component: () => import('../views/client/ClientDetail.vue'),
        meta: { requiresAuth: true }
      },
      {
        path: 'profile',
        name: 'Profile',
        component: () => import('../views/Profile.vue'),
        meta: { requiresAuth: true }
      },
      {
        path: 'user/:id',
        name: 'UserDetail',
        component: () => import('../views/user/UserDetail.vue'),
        meta: { requiresAuth: true }
      }
    ]
  },
  {
    path: '/403',
    name: '403',
    component: () => import('../views/403.vue'),
    meta: { requiresAuth: false }
  },
  {
    path: '/:pathMatch(.*)*',
    name: '404',
    component: () => import('../views/404.vue'),
    meta: { requiresAuth: false }
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

// 路由守卫
router.beforeEach((to, from, next) => {
  const token = localStorage.getItem('token')
  const store = useStore()

  if (to.meta.requiresAuth && !token) {
    next('/login')
    return
  }

  // 已登录用户访问登录页时重定向到首页
  if (to.path === '/login' && token) {
    next('/')
    return
  }

  // 确保用户信息已加载
  if (token && !store.userInfo.value) {
    store.getUserInfo().then(() => {
      next()
    }).catch(() => {
      localStorage.removeItem('token')
      next('/login')
    })
    return
  }

  next()
})

export default router 