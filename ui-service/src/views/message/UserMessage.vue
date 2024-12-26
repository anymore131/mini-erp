<template>
  <div class="message-container">
    <el-card class="message-card">
      <template #header>
        <div class="card-header">
          <span class="title">我的消息</span>
          <el-button type="primary" @click="markAllRead">全部标记为已读</el-button>
        </div>
      </template>

      <!-- 消息列表 -->
      <el-tabs v-model="activeTab">
        <el-tab-pane label="全部消息" name="all">
          <div class="message-list">
            <div v-for="msg in filteredMessages" :key="msg.userId" class="message-item" :class="{ 'message-unread': msg.type === 0 }">
              <div class="message-content">
                <div class="message-title">
                  <span>{{ msg.content }}</span>
                  <el-tag :type="msg.type === 0 ? 'danger' : 'info'" size="small">
                    {{ msg.type === 0 ? '未读' : '已读' }}
                  </el-tag>
                </div>
                <div class="message-footer">
                  <span class="message-time">{{ msg.sendTime }}</span>
                  <div class="message-actions">
                    <el-button type="text" @click="markRead(msg)" v-if="msg.type === 0">
                      标记已读
                    </el-button>
                    <el-button type="text" @click="deleteMessage(msg)" class="delete-btn">
                      删除
                    </el-button>
                  </div>
                </div>
              </div>
            </div>
            <div v-if="filteredMessages.length === 0" class="no-message">
              暂无消息
            </div>
          </div>
        </el-tab-pane>
        <el-tab-pane label="未读消息" name="unread">
          <div class="message-list">
            <div v-for="msg in unreadMessages" :key="msg.userId" class="message-item message-unread">
              <div class="message-content">
                <div class="message-title">
                  <span>{{ msg.content }}</span>
                  <el-tag type="danger" size="small">未读</el-tag>
                </div>
                <div class="message-footer">
                  <span class="message-time">{{ msg.sendTime }}</span>
                  <div class="message-actions">
                    <el-button type="text" @click="markRead(msg)">
                      标记已读
                    </el-button>
                    <el-button type="text" @click="deleteMessage(msg)" class="delete-btn">
                      删除
                    </el-button>
                  </div>
                </div>
              </div>
            </div>
            <div v-if="unreadMessages.length === 0" class="no-message">
              暂无未读消息
            </div>
          </div>
        </el-tab-pane>
      </el-tabs>
    </el-card>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import { messageApi } from '@/api/message'
import type { MessageInfo } from '@/api/message'
import { ElMessage } from 'element-plus'

const messages = ref<MessageInfo[]>([])
const loading = ref(false)
const currentPage = ref(1)
const pageSize = ref(10)
const total = ref(0)

const fetchMessages = async () => {
  console.log('开始获取消息列表...')
  loading.value = true
  try {
    const res = await messageApi.getMessageList({
      pageNum: currentPage.value,
      pageSize: pageSize.value,
      sortBy: 'send_time',
      asc: false
    })
    console.log('获取消息列表响应:', res)
    console.log('响应数据结构:', {
      code: res.code,
      msg: res.msg,
      data: res.data,
      hasData: !!res.data,
      dataType: res.data ? typeof res.data : 'undefined',
      hasRecords: res.data && 'records' in res.data,
      records: res.data?.records
    })

    if (res.code === 200) {
      // 检查data是否直接就是数组
      if (Array.isArray(res.data)) {
        messages.value = res.data
        total.value = res.data.length
        console.log('使用直接数组数据:', messages.value)
      }
      // 检查data.list是否存在
      else if (res.data && Array.isArray(res.data.list)) {
        messages.value = res.data.list
        total.value = res.data.total || res.data.list.length
        console.log('使用data.list数据:', messages.value)
      }
      // 检查data.records是否存在
      else if (res.data && Array.isArray(res.data.records)) {
        messages.value = res.data.records
        total.value = res.data.total || res.data.records.length
        console.log('使用data.records数据:', messages.value)
      } else {
        console.warn('响应数据格式不正确:', res.data)
        messages.value = []
        total.value = 0
        ElMessage.warning('数据格式不正确')
      }
    } else {
      console.warn('获取消息列表失败:', res.msg)
      messages.value = []
      total.value = 0
      ElMessage.warning(res.msg || '暂无消息数据')
    }
  } catch (error) {
    console.error('获取消息列表出错:', error)
    console.error('错误详情:', {
      name: error.name,
      message: error.message,
      stack: error.stack
    })
    messages.value = []
    total.value = 0
    ElMessage.error('获取消息列表失败')
  } finally {
    loading.value = false
    console.log('消息列表最终状态:', {
      messages: messages.value,
      total: total.value
    })
  }
}

const activeTab = ref('all')

// 计算属性：过滤消息
const filteredMessages = computed(() => {
  return messages.value
})

const unreadMessages = computed(() => {
  return messages.value.filter(msg => msg.type === 0)
})

// 标记消息为已读
const markRead = async (message: MessageInfo) => {
  console.log('开始标记消息已读，消息信息:', message)
  try {
    const res = await messageApi.markRead(message.id)
    console.log('标记已读API响应:', res)
    if (res.code === 200) {
      message.type = 1
      ElMessage.success(res.msg || '已标记为已读')
      // 重新获取消息列表以确保显示正确状态
      await fetchMessages()
    } else {
      console.warn('标记已读失败，错误信息:', res.msg)
      ElMessage.warning(res.msg || '标记已读失败')
    }
  } catch (error) {
    console.error('标记已读失败:', error)
    console.error('错误详情:', {
      name: error.name,
      message: error.message,
      config: error.config,
      response: error.response
    })
    ElMessage.error('标记已读失败')
  }
}

// 标记所有消息为已读
const markAllRead = async () => {
  const unreadMessages = messages.value.filter(msg => msg.type === 0)
  if (unreadMessages.length === 0) {
    ElMessage.info('没有未读消息')
    return
  }

  try {
    const promises = unreadMessages.map(msg => messageApi.markRead(msg.id))
    const results = await Promise.all(promises)
    const allSuccess = results.every(res => res.code === 200)
    
    if (allSuccess) {
      ElMessage.success('已全部标记为已读')
      // 重新获取消息列表以确保显示正确状态
      await fetchMessages()
    } else {
      ElMessage.warning('部分消息标记失败')
      // 重新获取消息列表以确保显示正确状态
      await fetchMessages()
    }
  } catch (error) {
    console.error('批量标记已读失败:', error)
    ElMessage.error('批量标记已读失败')
    // 重新获取消息列表以确保显示正确状态
    await fetchMessages()
  }
}

// 删除消息（暂时保持前端实现）
const deleteMessage = (message: MessageInfo) => {
  const index = messages.value.findIndex(msg => msg.userId === message.userId)
  if (index !== -1) {
    messages.value.splice(index, 1)
    ElMessage.success('删除成功')
  }
}

onMounted(() => {
  fetchMessages()
})
</script>

<style scoped>
.message-container {
  padding: 20px;
}

.message-card {
  margin-bottom: 20px;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.title {
  font-size: 18px;
  font-weight: bold;
}

.message-list {
  margin-top: 20px;
}

.message-item {
  padding: 15px;
  border-bottom: 1px solid #ebeef5;
  transition: background-color 0.3s;
}

.message-item:hover {
  background-color: #f5f7fa;
}

.message-unread {
  background-color: #f0f9eb;
}

.message-title {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 8px;
  font-weight: bold;
}

.message-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  color: #909399;
  font-size: 13px;
}

.message-actions {
  display: flex;
  gap: 10px;
}

.delete-btn {
  color: #f56c6c;
}

.no-message {
  text-align: center;
  color: #909399;
  padding: 30px 0;
}

.message-time {
  font-size: 12px;
  color: #909399;
}
</style> 