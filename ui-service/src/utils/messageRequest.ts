import axios from 'axios'
import { ElMessage } from 'element-plus'

const messageRequest = axios.create({
  baseURL: '/message',
  timeout: 10000,
  headers: {
    'Content-Type': 'application/json'
  }
})

// 请求拦截器
messageRequest.interceptors.request.use(
  config => {
    console.log('发送请求完整URL:', `${window.location.origin}${config.baseURL}${config.url}`)
    console.log('发送请求配置:', {
      url: config.url,
      method: config.method,
      params: config.params,
      data: config.data,
      baseURL: config.baseURL,
      headers: config.headers,
      fullPath: `${config.baseURL}${config.url}`
    })
    // 从localStorage获取token
    const token = localStorage.getItem('token')
    if (token) {
      config.headers['Authorization'] = `Bearer ${token}`
    }
    return config
  },
  error => {
    console.error('请求拦截器错误:', error)
    return Promise.reject(error)
  }
)

// 响应拦截器
messageRequest.interceptors.response.use(
  response => {
    console.log('收到响应:', {
      status: response.status,
      statusText: response.statusText,
      data: response.data,
      headers: response.headers,
      config: {
        url: response.config.url,
        method: response.config.method,
        baseURL: response.config.baseURL
      }
    })
    return response.data
  },
  error => {
    console.error('响应拦截器错误:', {
      status: error?.response?.status,
      statusText: error?.response?.statusText,
      data: error?.response?.data,
      config: {
        url: error?.config?.url,
        method: error?.config?.method,
        baseURL: error?.config?.baseURL
      },
      message: error?.message
    })
    if (error.response) {
      switch (error.response.status) {
        case 401:
          ElMessage.error('未登录或登录已过期')
          localStorage.removeItem('token')
          window.location.href = '/login'
          break
        case 403:
          ElMessage.error('没有权限访问')
          break
        case 404:
          ElMessage.error(`请求的资源不存在: ${error.config.baseURL}${error.config.url}`)
          break
        default:
          ElMessage.error('请求错误: ' + error.message)
      }
    }
    return Promise.reject(error)
  }
)

export default messageRequest 