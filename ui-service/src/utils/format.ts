export const formatDateTime = (dateTimeStr: string) => {
  if (!dateTimeStr) return ''
  return dateTimeStr.replace('T', ' ')
} 