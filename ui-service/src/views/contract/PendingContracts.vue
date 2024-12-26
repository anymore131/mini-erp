<template>
  <page-container title="待审批合同">
    <!-- 搜索表单 -->
    <el-form :inline="true" :model="queryForm" class="search-form">
      <el-form-item label="合同编号">
        <el-input v-model="queryForm.id" placeholder="请输入合同编号" clearable />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="handleSearch">查询</el-button>
        <el-button @click="handleReset">重置</el-button>
      </el-form-item>
    </el-form>

    <!-- 合同列表 -->
    <el-table :data="approvals" v-loading="loading">
      <el-table-column prop="id" label="审批ID" width="80" />
      <el-table-column prop="contractId" label="合同编号" width="100" />
      <el-table-column prop="userName" label="提交人" width="120" />
      <el-table-column prop="createTime" label="提交时间" width="180" />
      <el-table-column prop="status" label="状态" width="100">
        <template #default="{ row }">
          <el-tag :type="getStatusType(row.status)">
            {{ APPROVAL_STATUS_MAP[row.status] }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作" width="250" fixed="right">
        <template #default="{ row }">
          <el-button 
            link 
            type="primary" 
            @click="handleView(row)"
          >
            查看
          </el-button>
          <el-button 
            v-if="row.status === 0" 
            link 
            type="success" 
            @click="handleApprove(row)"
          >
            通过
          </el-button>
          <el-button 
            v-if="row.status === 0" 
            link 
            type="danger" 
            @click="handleReject(row)"
          >
            驳回
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

    <!-- 审批对话框 -->
    <el-dialog
      v-model="dialogVisible"
      :title="dialogType === 'approve' ? '审批通过' : '审批驳回'"
      width="500px"
    >
      <el-form :model="approvalForm">
        <el-form-item label="审批意见" required>
          <el-input
            v-model="approvalForm.comment"
            type="textarea"
            rows="3"
            placeholder="请输入审批意见"
          />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" @click="submitApproval">确定</el-button>
      </template>
    </el-dialog>
  </page-container>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage, ElMessageBox } from 'element-plus'
import { contractApi } from '../../api/contract'
import type { ContractApproval } from '../../api/contract'

const router = useRouter()
const loading = ref(false)
const approvals = ref<ContractApproval[]>([])
const total = ref(0)

// 查询表单
const queryForm = ref({
  pageNum: 1,
  pageSize: 10,
  id: ''
})

// 审批状态映射
const APPROVAL_STATUS_MAP: Record<number, string> = {
  0: '待审批',
  1: '已通过',
  2: '已驳回'
}

// 获取状态样式
const getStatusType = (status: number) => {
  const map: Record<number, string> = {
    0: 'warning',
    1: 'success',
    2: 'danger'
  }
  return map[status] || ''
}

// 获取待审批列表
const getApprovals = async () => {
  loading.value = true
  try {
    const res = await contractApi.getApprovals(0) // 0表示待审批状态
    approvals.value = res.data
    total.value = res.total || 0
  } catch (error) {
    console.error(error)
  } finally {
    loading.value = false
  }
}

// 查看合同详情
const handleView = (row: ContractApproval) => {
  router.push(`/contract/detail/${row.contractId}`)
}

// 审批对话框
const dialogVisible = ref(false)
const dialogType = ref<'approve' | 'reject'>('approve')
const currentApproval = ref<ContractApproval>()
const approvalForm = ref({
  comment: ''
})

// 打开通过审批对话框
const handleApprove = (row: ContractApproval) => {
  dialogType.value = 'approve'
  currentApproval.value = row
  approvalForm.value.comment = ''
  dialogVisible.value = true
}

// 打开驳回审批对话框
const handleReject = (row: ContractApproval) => {
  dialogType.value = 'reject'
  currentApproval.value = row
  approvalForm.value.comment = ''
  dialogVisible.value = true
}

// 提交审批
const submitApproval = async () => {
  if (!approvalForm.value.comment) {
    return ElMessage.warning('请输入审批意见')
  }

  try {
    if (dialogType.value === 'approve') {
      await contractApi.passApproval(
        currentApproval.value!.id!, 
        approvalForm.value.comment
      )
    } else {
      await contractApi.rejectApproval(
        currentApproval.value!.id!, 
        approvalForm.value.comment
      )
    }
    ElMessage.success('操作成功')
    dialogVisible.value = false
    getApprovals()
  } catch (error) {
    console.error(error)
  }
}

// 分页相关方法
const handleSizeChange = (val: number) => {
  queryForm.value.pageSize = val
  getApprovals()
}

const handleCurrentChange = (val: number) => {
  queryForm.value.pageNum = val
  getApprovals()
}

// 搜索和重置
const handleSearch = () => {
  queryForm.value.pageNum = 1
  getApprovals()
}

const handleReset = () => {
  queryForm.value = {
    pageNum: 1,
    pageSize: 10,
    id: ''
  }
  getApprovals()
}

onMounted(() => {
  getApprovals()
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