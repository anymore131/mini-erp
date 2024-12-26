<template>
  <page-container title="合同管理">
    <template #header-right>
      <el-button type="primary" @click="handleCreate">
        创建合同
      </el-button>
    </template>

    <!-- 搜索表单 -->
    <el-form :inline="true" :model="queryForm" class="search-form">
      <el-form-item label="状态">
        <el-select v-model="queryForm.status" clearable placeholder="请选择状态">
          <el-option 
            v-for="(label, value) in CONTRACT_STATUS_MAP" 
            :key="value" 
            :label="label" 
            :value="value"
          />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="handleSearch">查询</el-button>
        <el-button @click="handleReset">重置</el-button>
      </el-form-item>
    </el-form>

    <!-- 合同列表 -->
    <el-table :data="contracts" v-loading="loading">
      <el-table-column prop="id" label="ID" width="80" />
      <el-table-column prop="title" label="标题" />
      <el-table-column prop="clientName" label="客户" />
      <el-table-column prop="userName" label="创建人" />
      <el-table-column prop="totalAmount" label="金额" />
      <el-table-column prop="status" label="状态">
        <template #default="{ row }">
          <el-tag :type="getStatusType(row.status)">
            {{ CONTRACT_STATUS_MAP[row.status] }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="createTime" label="创建时间" />
      <el-table-column label="操作" width="250">
        <template #default="{ row }">
          <el-button link @click="handleView(row)">查看</el-button>
          <el-button 
            v-if="row.status === 'draft'" 
            link 
            @click="handleUpdateStatus(row.id, 'pending')"
          >
            提交审核
          </el-button>
          <el-button 
            v-if="row.status === 'pending' && isAdmin" 
            link 
            type="success" 
            @click="handleUpdateStatus(row.id, 'approve')"
          >
            通过
          </el-button>
          <el-button 
            v-if="row.status === 'pending' && isAdmin" 
            link 
            type="danger" 
            @click="handleUpdateStatus(row.id, 'reject')"
          >
            驳回
          </el-button>
          <el-button 
            v-if="row.status === 'approved'" 
            link 
            type="success" 
            @click="handleUpdateStatus(row.id, 'complete')"
          >
            完成
          </el-button>
          <el-button 
            v-if="['draft', 'pending'].includes(row.status)" 
            link 
            type="danger" 
            @click="handleUpdateStatus(row.id, 'cancel')"
          >
            取消
          </el-button>
          <el-button 
            v-if="row.status === 'draft'" 
            link 
            type="danger" 
            @click="handleDelete(row)"
          >
            删除
          </el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 分页 -->
    <div class="pagination">
      <el-pagination
        v-model:current-page="queryForm.pageNum"
        v-model:page-size="queryForm.pageSize"
        :total="total"
        :page-sizes="[10, 20, 50]"
        layout="total, sizes, prev, pager, next"
        @size-change="handleSizeChange"
        @current-change="handleCurrentChange"
      />
    </div>
  </page-container>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage, ElMessageBox } from 'element-plus'
import { contractApi } from '../../api/contract'
import { useStore } from '../../hooks/useStore'
import type { ContractInfo } from '../../api/contract'

const CONTRACT_STATUS_MAP = {
  draft: '草稿',
  pending: '待审核',
  approved: '已通过',
  rejected: '已驳回',
  completed: '已完成',
  cancelled: '已取消'
}

const router = useRouter()
const { isAdmin } = useStore()
const loading = ref(false)
const contracts = ref<ContractInfo[]>([])
const total = ref(0)

const queryForm = ref({
  pageNum: 1,
  pageSize: 10,
  status: ''
})

// 获取合同列表
const getContracts = async () => {
  loading.value = true
  try {
    const res = await contractApi.getContracts(queryForm.value)
    contracts.value = res.list
    total.value = res.total
  } finally {
    loading.value = false
  }
}

// 状态样式
const getStatusType = (status: string) => {
  const map: Record<string, string> = {
    draft: 'info',
    pending: 'warning',
    approved: 'success',
    rejected: 'danger',
    completed: 'success',
    cancelled: 'info'
  }
  return map[status]
}

// 搜索
const handleSearch = () => {
  queryForm.value.pageNum = 1
  getContracts()
}

// 重置
const handleReset = () => {
  queryForm.value = {
    pageNum: 1,
    pageSize: 10,
    status: ''
  }
  getContracts()
}

// 分页
const handleSizeChange = (val: number) => {
  queryForm.value.pageSize = val
  getContracts()
}

const handleCurrentChange = (val: number) => {
  queryForm.value.pageNum = val
  getContracts()
}

// 创建合同
const handleCreate = () => {
  router.push('/contract/create')
}

// 查看合同
const handleView = (row: ContractInfo) => {
  router.push(`/contract/detail/${row.id}`)
}

// 更新状态
const handleUpdateStatus = async (id: number, action: string) => {
  try {
    await contractApi.updateStatus(id, action)
    ElMessage.success('操作成功')
    getContracts()
  } catch (error) {
    console.error(error)
  }
}

// 删除合同
const handleDelete = (row: ContractInfo) => {
  ElMessageBox.confirm('确认删除该合同?', '提示', {
    type: 'warning'
  }).then(async () => {
    try {
      await contractApi.deleteContract(row.id)
      ElMessage.success('删除成功')
      getContracts()
    } catch (error) {
      console.error(error)
    }
  })
}

onMounted(() => {
  getContracts()
})
</script>

<style scoped>
.search-form {
  margin-bottom: 20px;
}
.pagination {
  margin-top: 20px;
  text-align: right;
}
</style> 