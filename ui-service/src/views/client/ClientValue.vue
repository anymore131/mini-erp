<template>
  <div class="client-value">
    <!-- 高价值客户列表 -->
    <el-card class="value-list">
      <template #header>
        <div class="card-header">
          <span>客户价值列表</span>
        </div>
      </template>

      <el-form :inline="true">
        <el-form-item label="用户" style="width: 250px;" v-show="store.isAdmin.value">
          <el-select
            v-model="searchForm.userId"
            filterable
            remote
            reserve-keyword
            placeholder="请输入用户名搜索并添加"
            :remote-method="searchUser"
            :loading="userLoading"
            style="width: 100%"
            clearable
          >
            <el-option
              v-for="user in userOptions"
              :key="user.id"
              :label="`${user.userName} (ID: ${user.id})`"
              :value="user.id"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="客户等级" style="width: 200px;">
          <el-select v-model="searchForm.tier" clearable>
            <el-option label="钻石" value="钻石"/>
            <el-option label="黄金" value="黄金"/>
            <el-option label="白银" value="白银"/>
            <el-option label="普通" value="普通"/>
          </el-select>
        </el-form-item>
        <el-form-item label="异常消费" style="width: 200px;">
          <el-select v-model="searchForm.isAnomaly" clearable>
            <el-option label="异常" value="1"/>
            <el-option label="正常" value="0"/>
          </el-select>
        </el-form-item>
        <el-form-item label="集群" style="width: 200px;">
          <el-select v-model="searchForm.cluster" clearable>
            <el-option label="0" value="0"/>
            <el-option label="1" value="1"/>
            <el-option label="2" value="2"/>
            <el-option label="3" value="3"/>
          </el-select>
        </el-form-item>
        <el-button type="primary" @click="loadData">查询</el-button>
      </el-form>

      <el-table :data="tableData" v-loading="loading" @sort-change="handleSortChange">
        <el-table-column prop="clientName" label="客户名称">
          <template #default="{row}">
            <el-button type="text" @click="handleClientClick(row.clientId)">
              {{ row.clientName }}
            </el-button>
          </template>
        </el-table-column>
        <el-table-column prop="userName" label="负责人">
          <template #default="{row}">
            <el-button type="text" @click="handleUserClick(row.userId)">
              {{ row.userName }}
            </el-button>
          </template>
        </el-table-column>
        <el-table-column prop="lastOrderTime" label="最后下单时间" sortable="custom" width="200px">
          <template #default="{row}">
            {{ formatDateTime(row.lastOrderTime) }}
          </template>
        </el-table-column>
        <el-table-column prop="frequency" label="交易频率" sortable="custom"/>
        <el-table-column prop="monetary" label="交易金额" sortable="custom"/>
        <el-table-column prop="tier" label="价值等级"/>
        <el-table-column prop="cluster" label="集群" sortable="custom"/>
        <el-table-column prop="isAnomaly" label="异常消费">
          <template #default="{row}">
            <el-tag :type="row.isAnomaly ? 'danger' : 'info'">
              {{ row.isAnomaly ? '是' : '否' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="churnRisk" label="流失风险" sortable="custom">
          <template #default="{row}">
            <el-progress 
              :percentage="row.churnRisk * 100" 
              :color="clientApi.riskColor(row.churnRisk * 100)"
              :show-text="false"/>
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
import { ref, reactive, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { useStore } from '../../hooks/useStore'
import { clientApi } from '../../api/client'
import { userApi } from '../../api/user'
import { ClientRfm } from '../../types'
import { formatDateTime } from '../../utils/format'

const router = useRouter()
const store = useStore()
const loading = ref(false)
const showUserDialog = ref(false)
const userList = ref([])
const selectedUserId = ref<number>()
const selectedUserName = ref('')

const pagination = reactive({
  pageNum: 1,
  pageSize: 10,
  sortBy: 'clientId',
  asc: true,
  total: 0,
  sortField: new Map<string, any>()
})

const searchForm = reactive({
  tier: undefined as string | undefined,
  userId: undefined as number | undefined,
  isAnomaly: undefined as number | undefined,
  cluster: undefined as number | undefined
})

const tableData = ref<ClientRfm[]>()

const loadData = async () => {
  const queryParams = reactive({
    pageNum: pagination.pageNum,
    pageSize: pagination.pageSize,
    sortBy: pagination.sortBy,
    asc: pagination.asc,
    tier: searchForm.tier,
    userId: searchForm.userId,
    isAnomaly: searchForm.isAnomaly,
    cluster: searchForm.cluster
  })
  
  try {
    loading.value = true
    const res = await clientApi.getValueCustomers(queryParams)
    tableData.value = res.data.list
    pagination.total = res.data.total
  } finally {
    loading.value = false
  }
}

const handleSortChange = ({ prop, order }: any) => {
  // 更新sortBy和asc
  if (order) {
    pagination.sortBy = prop
    pagination.asc = order === 'ascending' ? true : false
    console.log(pagination);
    
  } else {
    pagination.sortBy = 'clientId'
    pagination.asc = true
  }
  
  loadData()
}

const handleSearch = () => {
  pagination.pageNum = 1
  loadData()
}

const handleSizeChange = (size: number) => {
  pagination.pageSize = size
  loadData()
}

const handleCurrentChange = (page: number) => {
  pagination.pageNum = page
  loadData()
}

const handleClientClick = (id: number) => {
  router.push(`/client/${id}`)
}

const handleUserClick = (id: number) => {
  router.push(`/user/${id}`)
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

const userLoading = ref(false);
const userOptions = ref<Array<{ id: number; userName: string }>>([]);

const searchUser = async (userName: string) => {
  if (userName.trim()) {
    userLoading.value = true;
    try {
      const res = await userApi.getUserIds(userName);
      if (res.code == 200) {
        userOptions.value = res.data.map((item) => ({ id: item.id, userName: item.userName }));
      }
    } catch (error) {
      userOptions.value = [];
    } finally {
      userLoading.value = false;
    }
  } else {
    userOptions.value = [];
    searchForm.userId = undefined;
  }
};


onMounted(() => {
  if (!store.isAdmin.value) {
    searchForm.userId = store.userInfo.value?.id;
  }
  loadData()
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