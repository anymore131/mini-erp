<template>
  <div class="client-value">
    <page-loading :loading="loading" text="加载数据..." />
    
    <!-- 高价值客户列表 -->
    <el-card class="value-list">
      <template #header>
        <div class="card-header">
          <span>客户价值列表</span>
          <el-button type="primary" link @click="handleRefresh">
            <el-icon><Refresh /></el-icon>
            刷新
          </el-button>
        </div>
      </template>

      <el-form :inline="true" class="search-form">
        <el-form-item v-if="store.isAdmin.value" label="负责人">
          <el-input
            v-model="selectedUserName"
            placeholder="选择负责人"
            readonly
            @click="showUserDialog = true"
            style="width: 180px"
          >
            <template #append>
              <el-button @click="clearUser">
                <el-icon><Close /></el-icon>
              </el-button>
            </template>
          </el-input>
        </el-form-item>
        <el-form-item label="客户等级">
          <el-select 
            v-model="searchForm.customerLevel" 
            placeholder="请选择客户等级"
            clearable
            style="width: 180px"
          >
            <el-option 
              v-for="(label, value) in CUSTOMER_LEVEL_MAP" 
              :key="value" 
              :label="label" 
              :value="value" 
            />
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleSearch">查询</el-button>
        </el-form-item>
      </el-form>

      <el-table :data="clientList" style="width: 100%">
        <el-table-column prop="clientName" label="客户名称">
          <template #default="{ row }">
            <el-button 
              link 
              type="primary" 
              @click="handleClientClick(row.clientId)"
            >
              {{ row.clientName }}
            </el-button>
          </template>
        </el-table-column>
        <el-table-column prop="userName" label="负责人">
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
        <el-table-column prop="lastOrderTime" label="最近订单">
          <template #default="{ row }">
            {{ formatDateTime(row.lastOrderTime) }}
          </template>
        </el-table-column>
        <el-table-column prop="orderFrequency" label="订单频率" />
        <el-table-column prop="totalAmount" label="消费总额">
          <template #default="{ row }">
            {{ (row.totalAmount / 100).toFixed(2) }}
          </template>
        </el-table-column>
        <el-table-column prop="customerLevel" label="客户等级">
          <template #default="{ row }">
            <el-tag :type="getLevelTagType(row.customerLevel)">
              {{ CUSTOMER_LEVEL_MAP[row.customerLevel] }}
            </el-tag>
          </template>
        </el-table-column>
      </el-table>

      <el-pagination
        v-model:current-page="pagination.pageNum"
        v-model:page-size="pagination.pageSize"
        :total="pagination.total"
        :page-sizes="[10, 20, 50]"
        layout="total, sizes, prev, pager, next"
        @size-change="handleSizeChange"
        @current-change="handleCurrentChange"
        class="pagination"
      />

      <!-- 用户选择弹窗 -->
      <el-dialog
        v-model="showUserDialog"
        title="选择负责人"
        width="600px"
      >
        <el-table
          :data="userList"
          style="width: 100%"
          height="400px"
        >
          <el-table-column prop="userName" label="用户名" />
          <el-table-column prop="realName" label="真实姓名" />
          <el-table-column prop="email" label="邮箱" />
          <el-table-column label="操作" width="120" align="center">
            <template #default="{ row }">
              <el-button
                type="primary"
                link
                @click="handleUserSelect(row)"
              >
                选择
              </el-button>
            </template>
          </el-table-column>
        </el-table>
      </el-dialog>
    </el-card>
  </div>
</template>

<script lang="ts" setup>
import { ref, reactive, onMounted, onBeforeUnmount } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { Refresh, Close } from '@element-plus/icons-vue'
import { useStore } from '../../hooks/useStore'
import { clientApi } from '../../api/client'
import { userApi } from '../../api/user'
import { CUSTOMER_LEVEL_MAP } from '../../types'
import { formatDateTime } from '../../utils/format'
import * as echarts from 'echarts'

const router = useRouter()
const store = useStore()
const loading = ref(false)
const showUserDialog = ref(false)
const userList = ref([])
const selectedUserId = ref<number>()
const selectedUserName = ref('')

const clientList = ref([])
const pagination = reactive({
  pageNum: 1,
  pageSize: 10,
  total: 0
})

const searchForm = reactive({
  customerLevel: undefined as string | undefined,
  userId: undefined as number | undefined
})

// 获取客户列表
const fetchClientList = async () => {
  loading.value = true
  try {
    const res = await clientApi.getValueCustomers({
      ...pagination,
      userId: store.isAdmin.value ? searchForm.userId : store.userInfo.value?.id,
      customerLevel: searchForm.customerLevel
    })
    if (res.code === 200 && res.data) {
      clientList.value = res.data.list
      pagination.total = res.data.total
    }
  } catch (error) {
    ElMessage.error('获取客户列表失败')
  } finally {
    loading.value = false
  }
}

const handleSearch = () => {
  pagination.pageNum = 1
  fetchClientList()
}

const handleRefresh = async () => {
  try {
    await clientApi.updateRfm(
      store.isAdmin.value ? undefined : store.userInfo.value?.id
    )
    ElMessage.success('更新成功')
    fetchClientList()
  } catch (error) {
    ElMessage.error('更新失败')
  }
}

const handleSizeChange = (size: number) => {
  pagination.pageSize = size
  fetchClientList()
}

const handleCurrentChange = (page: number) => {
  pagination.pageNum = page
  fetchClientList()
}

const handleClientClick = (id: number) => {
  router.push(`/client/${id}`)
}

const handleUserClick = (id: number) => {
  router.push(`/user/${id}`)
}

const getLevelTagType = (level: string): 'success' | 'warning' | 'info' | 'danger' => {
  const typeMap: Record<string, 'success' | 'warning' | 'info' | 'danger'> = {
    'A': 'success',
    'B': 'warning',
    'C': 'info',
    'D': 'danger'
  }
  return typeMap[level] ?? 'info'
}

// 获取用户列表
const fetchUserList = async () => {
  try {
    const res = await userApi.getUsers({
      pageNum: 1,
      pageSize: 1000
    })
    if (res.code === 200) {
      userList.value = res.data.list
    }
  } catch (error) {
    ElMessage.error('获取用户列表失败')
  }
}

// 选择用户
const handleUserSelect = (row: any) => {
  selectedUserId.value = row.id
  selectedUserName.value = row.realName
  searchForm.userId = row.id
  showUserDialog.value = false
  handleSearch()
}

// 清除用户选择
const clearUser = () => {
  selectedUserId.value = undefined
  selectedUserName.value = ''
  searchForm.userId = undefined
  handleSearch()
}

onMounted(() => {
  fetchClientList()
  if (store.isAdmin.value) {
    fetchUserList()
  }
})
</script>

<style scoped>
.client-value {
  padding: 24px;
}

.charts-container {
  margin-bottom: 20px;
}

.chart {
  height: 400px;
}

.value-list {
  margin-top: 20px;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.search-form {
  margin-bottom: 20px;
}

.pagination {
  margin-top: 20px;
  text-align: right;
}
</style> 