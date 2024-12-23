import request from '../utils/request'
import type { PageResponse, FileQuery } from '../types'

export const fileApi = {
  getFiles(data: FileQuery) {
    return request({
      url: '/file/pageAll',
      method: 'post',
      data
    })
  },

  download(id: number) {
    return request({
      url: `/file/download/${id}`,
      method: 'get',
      responseType: 'blob'
    })
  },

  delete(id: number) {
    return request({
      url: `/file/remove/${id}`,
      method: 'delete'
    })
  }
} 