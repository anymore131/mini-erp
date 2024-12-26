<template>
  <div class="message-list">
    <el-card class="box-card">
      <template #header>
        <div class="card-header">
          <span>消息列表</span>
        </div>
      </template>
      
      <el-table :data="messageList" style="width: 100%" v-loading="loading">
        <el-table-column prop="id" label="ID" width="180" />
        <el-table-column prop="title" label="标题" />
        <el-table-column prop="content" label="内容" />
        <el-table-column prop="createTime" label="创建时间" />
        <el-table-column prop="status" label="状态">
          <template #default="scope">
            <el-tag :type="scope.row.status === 1 ? 'success' : 'info'">
              {{ scope.row.status === 1 ? '已读' : '未读' }}
            </el-tag>
          </template>
        </el-table-column>
      </el-table>

      <div class="pagination">
        <el-pagination
          v-model:current-page="currentPage"
          v-model:page-size="pageSize"
          :page-sizes="[10, 20, 30, 50]"
          layout="total, sizes, prev, pager, next"
          :total="total"
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
        />
      </div>
    </el-card>
  </div>
</template>

<script lang="ts" setup>
import { ref, onMounted } from 'vue'
import { messageApi } from '@/api/message'
import { ElMessage } from 'element-plus'

const messageList = ref([])
const loading = ref(false)
const currentPage = ref(1)
const pageSize = ref(10)
const total = ref(0)

const fetchMessages = async () => {
  loading.value = true
  try {
    const res = await messageApi.getMessageList({
      pageNo: currentPage.value,
      pageSize: pageSize.value
    })
    if (res.code === 200 && res.data) {
      messageList.value = res.data.records || []
      total.value = res.data.total || 0
    } else {
      messageList.value = []
      total.value = 0
      ElMessage.warning(res.msg || '暂无消息数据')
    }
  } catch (error: any) {
    console.error('获取消息列表出错:', error)
    messageList.value = []
    total.value = 0
    ElMessage.error(error?.response?.data?.msg || '获取消息列表失败')
  } finally {
    loading.value = false
  }
}

const handleSizeChange = (val: number) => {
  pageSize.value = val
  fetchMessages()
}

const handleCurrentChange = (val: number) => {
  currentPage.value = val
  fetchMessages()
}

onMounted(() => {
  fetchMessages()
})
</script>

<style scoped>
.message-list {
  padding: 20px;
}
.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
.pagination {
  margin-top: 20px;
  display: flex;
  justify-content: flex-end;
}
</style> 