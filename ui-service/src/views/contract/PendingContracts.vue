<template>
  <div class="pending-contracts">
    <page-loading :loading="loading" text="加载合同数据..." />

    <!-- 搜索表单 -->
    <el-form :inline="true" class="search-form">
      <el-form-item label="合同编号">
        <el-input
            v-model="searchForm.id"
            placeholder="请输入合同编号"
            clearable
            @clear="handleSearch"
        />
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
            v-model="dateRange"
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
    </el-form>

    <!-- 合同列表 -->
    <el-table
        :data="contractList"
        :loading="loading"
        style="width: 100%; margin-top: 20px"
    >
      <el-table-column prop="id" label="合同编号">
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
      <el-table-column prop="amount" label="总金额">
        <template #default="{ row }">
          {{ (row.amount / 100).toFixed(2) }}
        </template>
      </el-table-column>
      <el-table-column prop="createTime" label="创建时间">
        <template #default="{ row }">
          {{ formatTime(row.createTime) }}
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
          <el-button
              link
              type="primary"
              @click="handleApproval(row.id)"
          >
            审批
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
  </div>
</template>

<script lang="ts">
import { defineComponent, ref, reactive, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { contractApi } from '../../api/contract'
import type { ContractInfo } from '../../types'
import { formatDateTime } from '../../utils/format'

export default defineComponent({
  name: 'PendingContracts',
  setup() {
    const router = useRouter()
    const loading = ref(false)
    const contractList = ref<ContractInfo[]>([])
    const dateRange = ref()

    const pagination = reactive({
      pageNum: 1,
      pageSize: 10,
      total: 0
    })

    const searchForm = reactive({
      id: undefined as string | undefined,
      minAmount: undefined as number | undefined,
      maxAmount: undefined as number | undefined
    })

    // 获取合同列表
    const fetchContractList = async () => {
      loading.value = true
      try {
        const params = {
          ...pagination,
          status: 'PENDING',
          ...(searchForm.id ? { id: searchForm.id } : {}),
          ...(searchForm.minAmount ? { minAmount: Math.round(searchForm.minAmount * 100) } : {}),
          ...(searchForm.maxAmount ? { maxAmount: Math.round(searchForm.maxAmount * 100) } : {}),
          ...(dateRange.value?.[0] ? { createTime: dateRange.value[0] } : {}),
          ...(dateRange.value?.[1] ? { updateTime: dateRange.value[1] } : {})
        }
        const res = await contractApi.getContracts(params)
        contractList.value = res.data.list
        pagination.total = res.data.total
      } catch (error) {
        console.error('获取合同列表失败:', error)
        ElMessage.error('获取合同列表失败')
      } finally {
        loading.value = false
      }
    }

    // 处理搜索
    const handleSearch = () => {
      pagination.pageNum = 1
      fetchContractList()
    }

    // 处理页码变化
    const handleCurrentChange = (page: number) => {
      pagination.pageNum = page
      fetchContractList()
    }

    // 处理每页条数变化
    const handleSizeChange = (size: number) => {
      pagination.pageSize = size
      fetchContractList()
    }

    // 点击合同编号跳转到详情页
    const handleContractClick = (id: number) => {
      router.push(`/contract/${id}`)
    }

    // 跳转到审批页面
    const handleApproval = (id: number) => {
      router.push(`/contract/approval/${id}`)
    }

    // 点击客户名称跳转到客户详情
    const handleClientClick = (clientId: number) => {
      router.push(`/client/${clientId}`)
    }

    onMounted(() => {
      fetchContractList()
    })

    return {
      loading,
      contractList,
      pagination,
      searchForm,
      dateRange,
      handleSearch,
      handleCurrentChange,
      handleSizeChange,
      handleContractClick,
      handleApproval,
      handleClientClick,
      formatTime: formatDateTime
    }
  }
})
</script>

<style scoped>
.pending-contracts {
  padding: 24px;
}

.search-form {
  margin-bottom: 20px;
}

.pagination {
  margin-top: 20px;
  text-align: right;
}

.mx-2 {
  margin: 0 8px;
}
</style>