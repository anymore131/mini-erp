export const formatDateTime = (dateTimeStr: string) => {
  if (!dateTimeStr) return ''
  return dateTimeStr.replace('T', ' ')
}

export const formatFileType = (contentType: string) => {
  if (!contentType) return ''
  
  const typeMap: Record<string, string> = {
    'application/msword': 'Word文档',
    'application/vnd.openxmlformats-officedocument.wordprocessingml.document': 'Word文档',
    'application/vnd.ms-excel': 'Excel表格',
    'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet': 'Excel表格',
    'application/pdf': 'PDF文档',
    'application/vnd.ms-powerpoint': 'PPT',
    'application/vnd.openxmlformats-officedocument.presentationml.presentation': 'PPT',
    'image/jpeg': '图片',
    'image/png': '图片',
    'image/gif': '图片',
    'video/mp4': '视频',
    'audio/mpeg': '音频',
    'text/plain': '文本文件'
  }

  return typeMap[contentType] || contentType.split('/')[1].toUpperCase()
} 