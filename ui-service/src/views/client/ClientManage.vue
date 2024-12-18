<template>
  <div class="client-manage">
    <!-- 搜索表单 -->
    <el-form :inline="true" class="search-form">
      <el-form-item label="客户名称">
        <el-input
          v-model="searchForm.name"
          placeholder="请输入客户名称"
          clearable
          @clear="handleSearch"
        />
      </el-form-item>
      <el-form-item label="状态">
        <el-select
          v-model="searchForm.status"
          placeholder="请选择状态"
          clearable
          @clear="handleSearch"
          style="width: 120px"
        >
          <el-option
            v-for="status in CLIENT_STATUS_OPTIONS"
            :key="status"
            :label="status"
            :value="status"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="最低交易额">
        <el-input-number
          v-model="searchForm.sum"
          :min="0"
          :precision="2"
          placeholder="最低交易额"
        />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="handleSearch">查询</el-button>
      </el-form-item>
    </el-form>

    <!-- 客户列表 -->
    <el-table
      :data="clientList"
      :loading="loading"
      style="width: 100%; margin-top: 20px"
      @sort-change="handleSortChange"
    >
      <el-table-column prop="name" label="客户名称" sortable="custom" />
      <el-table-column prop="status" label="状态">
        <template #default="{ row }">
          <span 
            class="status-tag" 
            :class="{
              'status-start': row.status === 'START',
              'status-cooperation': row.status === 'COOPERATION',
              'status-waiting': row.status === 'WAITING'
            }"
          >
            {{ CLIENT_STATUS_MAP[row.status] || row.status }}
          </span>
        </template>
      </el-table-column>
      <el-table-column prop="sum" label="交易额" sortable="custom">
        <template #default="{ row }">
          {{ (row.sum / 100).toFixed(2) }}
        </template>
      </el-table-column>
      <el-table-column prop="userName" label="负责人" />
      <el-table-column prop="lastTime" label="最后更新时间" sortable="custom" />
    </el-table>

    <!-- 分页 -->
    <el-pagination
      v-model:current-page="pagination.pageNum"
      v-model:page-size="pagination.pageSize"
      :total="pagination.total"
      :page-sizes="[5, 10, 20, 50]"
      layout="total, sizes, prev, pager, next"
      @size-change="handleSizeChange"
      @current-change="handleCurrentChange"
      class="pagination"
    />
  </div>
</template>

<script lang="ts">
import { defineComponent, ref, reactive, onMounted } from 'vue'
import { ElMessage } from 'element-plus'
import { clientApi } from '../../api/client'
import type { ClientInfo } from '../../api/client'
import { CLIENT_STATUS_OPTIONS, CLIENT_STATUS_MAP } from '../../types'
import { useStore } from '../../hooks/useStore'

export default defineComponent({
  name: 'ClientManage',
  setup() {
    const store = useStore()
    const loading = ref(false)
    const clientList = ref<ClientInfo[]>([])

    const pagination = reactive({
      pageNum: 1,
      pageSize: 10,
      total: 0
    })

    const searchForm = reactive({
      name: undefined as string | undefined,
      status: undefined as string | undefined,
      sum: undefined as number | undefined
    })

    const sortState = reactive({
      sortBy: '',
      asc: true
    })

    // 前端字段名到后端字段名的映射
    const columnFieldMap: Record<string, string> = {
      name: 'name',
      status: 'status',
      sum: 'sum',
      lastTime: 'last_time'
    }

    // 获取客户列表
    const fetchClientList = async () => {
      loading.value = true
      try {
        const response = await clientApi.getClients({
          pageNum: pagination.pageNum,
          pageSize: pagination.pageSize,
          sortBy: sortState.sortBy,
          asc: sortState.asc,
          name: searchForm.name,
          status: searchForm.status,
          sum: searchForm.sum ? searchForm.sum * 100 : undefined,
          userId: store.isAdmin.value ? undefined : store.userInfo.value?.id
        })
        console.log('响应数据:', response)

        if (response.code === 200 && response.data) {
          clientList.value = response.data.list
          pagination.total = response.data.total
        }
      } catch (error: any) {
        console.error('获取客户列表失败:', error)
        ElMessage.error(error.response?.data?.msg || error.message || '获取客户列表失败')
      } finally {
        loading.value = false
      }
    }

    // 处理搜索
    const handleSearch = () => {
      pagination.pageNum = 1
      fetchClientList()
    }

    // 处理排序变化
    const handleSortChange = ({ prop, order }: { prop?: string, order?: string }) => {
      sortState.sortBy = prop ? (columnFieldMap[prop] || prop) : ''
      sortState.asc = order === 'ascending'
      fetchClientList()
    }

    // 处理页码变化
    const handleCurrentChange = (page: number) => {
      pagination.pageNum = page
      fetchClientList()
    }

    // 处理每页条数变化
    const handleSizeChange = (size: number) => {
      pagination.pageSize = size
      fetchClientList()
    }

    onMounted(() => {
      fetchClientList()
    })

    return {
      CLIENT_STATUS_OPTIONS,
      CLIENT_STATUS_MAP,
      loading,
      clientList,
      pagination,
      searchForm,
      handleSearch,
      handleSortChange,
      handleCurrentChange,
      handleSizeChange
    }
  }
})
</script>

<style scoped>
.client-manage {
  padding: 24px;
  position: relative;
  min-height: 200px;
}

.search-form {
  margin-bottom: 20px;
}

.pagination {
  margin-top: 20px;
  text-align: right;
}

.status-tag {
  display: inline-block;
  padding: 2px 8px;
  border-radius: 4px;
  border: 1px solid transparent;
}

.status-start {
  border-color: #67C23A;
  color: #67C23A;
}

.status-cooperation {
  border-color: #F56C6C;
  color: #F56C6C;
}

.status-waiting {
  border-color: #909399;
  color: #909399;
}
</style> 