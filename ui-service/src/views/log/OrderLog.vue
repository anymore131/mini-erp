<template>
  <div class="order-log">
    <page-loading :loading="loading" text="加载日志数据..." />
    
    <!-- 搜索表单 -->
    <el-form :inline="true" class="search-form">
      <el-form-item label="订单编号">
        <el-input
          v-model="searchForm.orderNo"
          placeholder="请输入订单编号"
          clearable
          @clear="handleSearch"
        />
      </el-form-item>
      <el-form-item label="操作人">
        <el-input
          v-model="searchForm.userName"
          placeholder="请输入操作人"
          clearable
          @clear="handleSearch"
        />
      </el-form-item>
      <el-form-item label="操作类型">
        <el-select
          v-model="searchForm.action"
          placeholder="请选择操作类型"
          clearable
          style="width: 150px"
        >
          <el-option label="创建订单" value="CREATE" />
          <el-option label="提交检验" value="SUBMIT" />
          <el-option label="审批" value="APPROVE" />
          <el-option label="添加明细" value="ADD_ITEM" />
          <el-option label="添加文件" value="ADD_FILE" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="handleSearch">查询</el-button>
      </el-form-item>
    </el-form>

    <!-- 日志列表 -->
    <el-table
      :data="logList"
      :loading="loading"
      style="width: 100%; margin-top: 20px"
      @sort-change="handleSortChange"
    >
      <el-table-column prop="orderNo" label="订单编号">
        <template #default="{ row }">
          <el-button 
            link 
            type="primary" 
            @click="handleOrderClick(row.orderId)"
          >
            {{ row.orderNo }}
          </el-button>
        </template>
      </el-table-column>
      <el-table-column prop="userName" label="操作人">
        <template #default="{ row }">
          <el-button 
            link 
            type="primary" 
            @click="handleUserClick(row.userId)"
          >
            {{ row.userName }}
          </el-button>
        </template>
      </el-table-column>
      <el-table-column prop="action" label="操作类型" sortable="custom">
        <template #default="{ row }">
          {{ ACTION_MAP[row.action] || row.action }}
        </template>
      </el-table-column>
      <el-table-column prop="content" label="操作内容" />
      <el-table-column prop="createTime" label="操作时间" sortable="custom">
        <template #default="{ row }">
          {{ formatTime(row.createTime) }}
        </template>
      </el-table-column>
    </el-table>

    <!-- 分页 -->
    <el-pagination
      v-model:current-page="pagination.pageNum"
      v-model:page-size="pagination.pageSize"
      :total="pagination.total"
      :page-sizes="[10, 20, 50, 100]"
      layout="total, sizes, prev, pager, next"
      @size-change="handleSizeChange"
      @current-change="handleCurrentChange"
      class="pagination"
    />
  </div>
</template>

<script lang="ts" setup>
import { ref, reactive } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { orderApi } from '../../api/order'
import { formatDateTime } from '../../utils/format'

const router = useRouter()
const loading = ref(false)
const logList = ref([])

const ACTION_MAP: Record<string, string> = {
  'CREATE': '创建订单',
  'SUBMIT': '提交检验',
  'APPROVE': '审批',
  'ADD_ITEM': '添加明细',
  'ADD_FILE': '添加文件'
}

const pagination = reactive({
  pageNum: 1,
  pageSize: 10,
  total: 0
})

const searchForm = reactive({
  orderNo: undefined as string | undefined,
  userName: undefined as string | undefined,
  action: undefined as string | undefined,
  sortBy: undefined as string | undefined,
  asc: undefined as boolean | undefined
})

const fetchLogList = async () => {
  loading.value = true
  try {
    const res = await orderApi.getOrderLogs({
      ...pagination,
      ...searchForm
    })
    logList.value = res.data.list
    pagination.total = res.data.total
  } catch (error) {
    ElMessage.error('获取日志列表失败')
  } finally {
    loading.value = false
  }
}

const handleSearch = () => {
  pagination.pageNum = 1
  fetchLogList()
}

const handleSortChange = ({ prop, order }: { prop: string, order: string | null }) => {
  searchForm.sortBy = order ? prop.replace(/([A-Z])/g, '_$1').toLowerCase() : undefined
  searchForm.asc = order === 'ascending'
  fetchLogList()
}

const handleCurrentChange = (page: number) => {
  pagination.pageNum = page
  fetchLogList()
}

const handleSizeChange = (size: number) => {
  pagination.pageSize = size
  fetchLogList()
}

const handleOrderClick = (orderId: number) => {
  router.push(`/order/${orderId}`)
}

const handleUserClick = (userId: number) => {
  router.push(`/user/${userId}`)
}

const formatTime = (time: string) => formatDateTime(time)

fetchLogList()
</script>

<style scoped>
.order-log {
  padding: 24px;
}

.search-form {
  margin-bottom: 20px;
}

.pagination {
  margin-top: 20px;
  text-align: right;
}
</style> 