import { createRouter, createWebHistory, RouteRecordRaw } from 'vue-router'
import { useStore } from '../hooks/useStore'
import OrderManage from '../views/order/OrderManage.vue'
import OrderDetail from '../views/order/OrderDetail.vue'
import CreateOrder from '../views/order/CreateOrder.vue'
import OrderApproval from '../views/order/OrderApproval.vue'
import UserManage from '../views/user/UserManage.vue'
import UserDetail from '../views/user/UserDetail.vue'
import OrderLog from '../views/log/OrderLog.vue'

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
        name: 'Home',
        redirect: 'dashboard'
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
      },
      {
        path: 'order-manage',
        name: 'OrderManage',
        component: () => import('../views/order/OrderManage.vue'),
        meta: { requiresAuth: true }
      },
      {
        path: 'order-manage/:userId',
        name: 'MyOrderManage',
        component: () => import('../views/order/OrderManage.vue'),
        meta: { requiresAuth: true }
      },
      {
        path: 'order-manage/pending',
        name: 'PendingOrders',
        component: () => import('../views/order/PendingOrders.vue'),
        meta: { requiresAuth: true }
      },
      {
        path: 'order/create/:clientId',
        name: 'CreateOrder',
        component: () => import('../views/order/CreateOrder.vue'),
        meta: { requiresAuth: true }
      },
      {
        path: 'order/:id',
        name: 'OrderDetail',
        component: () => import('../views/order/OrderDetail.vue'),
        meta: { requiresAuth: true }
      },
      {
        path: 'order',
        children: [
          {
            path: '',
            component: OrderManage
          },
          {
            path: ':id',
            component: OrderDetail
          },
          {
            path: 'create/:clientId?',
            component: CreateOrder
          },
          {
            path: 'approval/:id',
            component: OrderApproval
          }
        ]
      },
      {
        path: 'file-manage',
        name: 'FileManage',
        component: () => import('../views/file/FileManage.vue'),
        meta: { requiresAuth: true }
      },
      {
        path: '/log/order',
        name: 'OrderLog',
        component: OrderLog,
        meta: {
          requiresAuth: true,
          requiresAdmin: true
        }
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
    return next('/login')
  }

  // 已登录用户访问登录页时重定向到首页
  if (to.path === '/login' && token) {
    return next('/')
  }

  // 确保用户信息已加载
  if (token && !store.userInfo.value) {
    store.getUserInfo().then(() => {
      if (to.path === '/') {
        next('/dashboard')
      } else {
        next()
      }
    }).catch(() => {
      localStorage.removeItem('token')
      return next('/login')
    })
    return
  }

  // 根路径重定向到dashboard
  if (to.path === '/') {
    return next('/dashboard')
  }

  next()
})

export default router 