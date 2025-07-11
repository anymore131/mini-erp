<template>
  <div class="contract-manage">
    <page-loading :loading="loading" text="加载合同数据..." />
    
    <!-- 搜索表单 -->
    <el-form :inline="true" class="search-form">
      <div class="search-form-content">
        <div class="search-items">
          <el-form-item label="合同编号">
            <el-input
              v-model="searchForm.id"
              placeholder="请输入合同编号"
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
              style="width: 160px"
            >
              <el-option
                v-for="[key, value] in Object.entries(CONTRACT_STATUS_MAP)"
                :key="key"
                :label="value"
                :value="key"
              />
            </el-select>
          </el-form-item>
          <el-form-item label="金额范围">
            <el-input-number
              v-model="searchForm.minAmount"
              :min="0"
              :precision="2"
              :step="100"
              placeholder="最小金额"
              style="width: 130px"
            />
            <span class="mx-2">-</span>
            <el-input-number
              v-model="searchForm.maxAmount"
              :min="0"
              :precision="2"
              :step="100"
              placeholder="最大金额"
              style="width: 130px"
            />
          </el-form-item>
          <el-form-item label="创建时间">
            <el-date-picker
              v-model="value2"
              type="datetimerange"
              start-placeholder="开始时间"
              end-placeholder="结束时间"
              format="YYYY-MM-DD HH:mm:ss"
              value-format="YYYY-MM-DD HH:mm:ss"
            />
          </el-form-item>
          <el-form-item>
            <el-button type="primary" @click="handleSearch">查询</el-button>
          </el-form-item>
        </div>
        <div class="action-buttons">
          <el-button type="primary" @click="handleCreateContract">
            <el-icon><Plus /></el-icon>添加合同
          </el-button>
        </div>
      </div>
    </el-form>

    <!-- 合同列表 -->
    <el-table
      :data="contractList"
      :loading="loading"
      @sort-change="handleSortChange"
      style="width: 100%; margin-top: 20px"
    >
      <el-table-column 
        prop="id" 
        label="合同编号"
        sortable="custom"
      >
        <template #default="{ row }">
          <el-button 
            link 
            type="primary" 
            @click="handleContractClick(row.id)"
          >
            {{ row.id }}
          </el-button>
        </template>
      </el-table-column>
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
      <el-table-column prop="userName" label="负责人" />
      <el-table-column 
        prop="amount" 
        label="总金额"
        sortable="custom"
      >
        <template #default="{ row }">
          {{ (row.amount / 100).toFixed(2) }}
        </template>
      </el-table-column>
      <el-table-column 
        prop="createTime" 
        label="创建时间"
        sortable="custom"
      >
        <template #default="{ row }">
          {{ formatTime(row.createTime) }}
        </template>
      </el-table-column>
      <el-table-column 
        prop="updateTime" 
        label="修改时间"
        sortable="custom"
      >
        <template #default="{ row }">
          {{ formatTime(row.updateTime) }}
        </template>
      </el-table-column>
      <el-table-column prop="status" label="状态">
        <template #default="{ row }">
          <span 
            class="status-tag" 
            :class="{
              'status-draft': row.status === 'DRAFT',
              'status-pending': row.status === 'PENDING',
              'status-approved': row.status === 'APPROVED',
              'status-rejected': row.status === 'REJECTED',
              'status-completed': row.status === 'COMPLETED',
              'status-cancelled': row.status === 'CANCELLED'
            }"
          >
            {{ CONTRACT_STATUS_MAP[row.status] }}
          </span>
        </template>
      </el-table-column>
      <el-table-column label="操作" width="200">
        <template #default="{ row }">
          <el-button 
            link 
            type="primary" 
            @click="handleContractClick(row.id)"
          >
            查看
          </el-button>
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

    <!-- 选择客户对话框 -->
    <el-dialog
      v-model="clientDialogVisible"
      title="选择客户"
      width="500px"
    >
      <el-table
        :data="clientList"
        style="width: 100%"
      >
        <el-table-column prop="name" label="客户名称" />
        <el-table-column prop="status" label="状态">
          <template #default="{ row }">
            {{ CLIENT_STATUS_MAP[row.status] }}
          </template>
        </el-table-column>
        <el-table-column label="操作" width="120" fixed="right">
          <template #default="{ row }">
            <el-button 
              type="primary" 
              link
              @click="handleClientSelect(row)"
            >
              创建合同
            </el-button>
          </template>
        </el-table-column>
      </el-table>
      <template #footer>
        <div class="dialog-footer">
          <el-button @click="clientDialogVisible = false">取消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script lang="ts">
import { defineComponent, ref, reactive, onMounted, watch } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { ElMessage } from 'element-plus'
import { Plus } from '@element-plus/icons-vue'
import { contractApi } from '../../api/contract'
import { CONTRACT_STATUS_MAP, CLIENT_STATUS_MAP } from '../../types'
import { clientApi } from '../../api/client'
import type { ContractInfo } from '../../types'
import { formatDateTime } from '../../utils/format'
import { useStore } from '../../hooks/useStore'

export default defineComponent({
  name: 'ContractManage',
  setup() {
    const store = useStore()
    const router = useRouter()
    const route = useRoute()
    const loading = ref(false)
    const contractList = ref<ContractInfo[]>([])
    const clientDialogVisible = ref(false)
    const clientList = ref([])

    const pagination = reactive({
      pageNum: 1,
      pageSize: 10,
      total: 0
    })

    const searchForm = reactive({
      id: undefined as string | undefined,
      status: undefined as string | undefined,
      userId: route.params.userId ? Number(route.params.userId) : 
              (store.isAdmin.value ? undefined : store.userInfo.value?.id),
      minAmount: undefined as number | undefined,
      maxAmount: undefined as number | undefined,
      sortBy: undefined as string | undefined,
      asc: true
    })

    const value2 = ref()

    // 监听路由参数变化
    watch(
      () => route.params.userId,
      () => {
        searchForm.userId = route.params.userId ? Number(route.params.userId) : 
                           (store.isAdmin.value ? undefined : store.userInfo.value?.id)
        fetchContractList()
      }
    )

    // 获取合同列表
    const fetchContractList = async () => {
      try {
        this.loading = true;
        console.log('请求参数:', {
          pageNum: this.pagination.pageNum,
          pageSize: this.pagination.pageSize,
          ...this.searchForm
        });
        
        const res = await contractApi.getContracts({
          pageNum: this.pagination.pageNum,
          pageSize: this.pagination.pageSize,
          ...this.searchForm
        });
        
        console.log('响应结果:', res);
        
        if (res.code === 200) {
          this.contractList = res.data.list;
          this.pagination.total = res.data.total;
        } else {
          ElMessage.error(res.msg || '查询失败');
        }
      } catch (error) {
        console.error('获取合同列表失败:', error);
        ElMessage.error('获取合同列表失败');
      } finally {
        this.loading = false;
      }
    }

    // 处理搜索
    const handleSearch = () => {
      this.pagination.pageNum = 1
      fetchContractList()
    }

    // 处理页码变化
    const handleCurrentChange = (page: number) => {
      this.pagination.pageNum = page
      fetchContractList()
    }

    // 处理每页条数变化
    const handleSizeChange = (size: number) => {
      this.pagination.pageSize = size
      fetchContractList()
    }

    // 点击合同编号跳转到详情页
    const handleContractClick = (id: number) => {
      router.push(`/contract/${id}`)
    }

    const handleClientClick = (clientId: number) => {
      router.push(`/client/${clientId}`)
    }

    const handleSortChange = ({ prop, order }: { prop: string, order: string | null }) => {
      this.searchForm.sortBy = order ? prop.replace(/([A-Z])/g, '_$1').toLowerCase() : undefined
      this.searchForm.asc = order === 'ascending'
      fetchContractList()
    }

    // 获取客户列表
    const fetchClientList = async () => {
      try {
        const res = await clientApi.getAllClients(
          store.isAdmin.value ? store.userInfo.value?.id : store.userInfo.value?.id
        )
        this.clientList = res.data
      } catch (error) {
        ElMessage.error('获取客户列表失败')
      }
    }

    // 处理创建合同按钮点击
    const handleCreateContract = () => {
      fetchClientList()
      this.clientDialogVisible = true
    }

    // 处理客户选择
    const handleClientSelect = (row: any) => {
      this.clientDialogVisible = false
      router.push(`/contract/create/${row.id}`)
    }

    onMounted(() => {
      fetchContractList()
    })

    return {
      loading,
      contractList,
      pagination,
      searchForm,
      CONTRACT_STATUS_MAP,
      CLIENT_STATUS_MAP,
      handleSearch,
      handleCurrentChange,
      handleSizeChange,
      handleContractClick,
      formatTime: formatDateTime,
      value2,
      handleClientClick,
      handleSortChange,
      clientDialogVisible,
      clientList,
      handleCreateContract,
      handleClientSelect
    }
  }
})
</script>

<style scoped>
.contract-manage {
  padding: 24px;
}

.search-form {
  margin-bottom: 20px;
}

.search-form-content {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  flex-wrap: wrap;
}

.search-items {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  gap: 16px;
  flex: 1;
}

.action-buttons {
  display: flex;
  gap: 8px;
  margin-left: auto;
  margin-top: 4px;
}

.pagination {
  margin-top: 20px;
  text-align: right;
}

/* 状态标签样式 */
.status-tag {
  display: inline-block;
  padding: 2px 8px;
  border-radius: 4px;
  border: 1px solid transparent;
}

.status-draft {
  border-color: #909399;
  color: #909399;
}

.status-pending {
  border-color: #E6A23C;
  color: #E6A23C;
}

.status-approved {
  border-color: #67C23A;
  color: #67C23A;
}

.status-rejected {
  border-color: #F56C6C;
  color: #F56C6C;
}

.status-completed {
  border-color: #409EFF;
  color: #409EFF;
}

.status-cancelled {
  border-color: #909399;
  color: #909399;
}

.mx-2 {
  margin: 0 8px;
}
</style> 