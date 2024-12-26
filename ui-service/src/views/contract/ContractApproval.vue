<template>
  <page-container>
    <div class="header-actions">
      <el-button @click="handleBack">返回</el-button>
      <div class="title">合同审批</div>
    </div>

    <!-- 合同详情 -->
    <el-descriptions :column="2" border>
      <el-descriptions-item label="合同编号">
        {{ contractInfo.id }}
      </el-descriptions-item>
      <el-descriptions-item label="合同状态">
        <span 
          class="status-tag"
          :class="{
            'status-draft': contractInfo.status === 'DRAFT',
            'status-pending': contractInfo.status === 'PENDING',
            'status-approved': contractInfo.status === 'APPROVED',
            'status-rejected': contractInfo.status === 'REJECTED',
            'status-completed': contractInfo.status === 'COMPLETED',
            'status-cancelled': contractInfo.status === 'CANCELLED'
          }"
        >
          {{ contractInfo.status ? CONTRACT_STATUS_MAP[contractInfo.status] : '-' }}
        </span>
      </el-descriptions-item>
      <el-descriptions-item label="客户名称">
        <el-button 
          link 
          type="primary" 
          @click="handleClientClick(contractInfo.clientId)"
        >
          {{ contractInfo.clientName }}
        </el-button>
      </el-descriptions-item>
      <el-descriptions-item label="负责人">
        {{ contractInfo.userName }}
      </el-descriptions-item>
      <el-descriptions-item label="合同金额">
        {{ contractInfo.amount !== undefined && contractInfo.amount !== null ? 
          `¥${(contractInfo.amount / 100).toFixed(2)}` : '-' }}
      </el-descriptions-item>
      <el-descriptions-item label="创建时间">
        {{ contractInfo.createTime ? formatDateTime(contractInfo.createTime) : '-' }}
      </el-descriptions-item>
      <el-descriptions-item label="备注" :span="2">
        {{ contractInfo.remark || '-' }}
      </el-descriptions-item>
    </el-descriptions>

    <!-- 合同文件 -->
    <div class="section">
      <div class="section-header">
        <h3>合同文件</h3>
      </div>
      
      <el-table :data="fileList" style="width: 100%">
        <el-table-column label="文件名称">
          <template #default="{ row }">
            {{ row.fileVo?.fileName }}
          </template>
        </el-table-column>
        <el-table-column label="上传时间">
          <template #default="{ row }">
            {{ formatDateTime(row.createTime) }}
          </template>
        </el-table-column>
        <el-table-column prop="remark" label="备注" />
        <el-table-column label="操作">
          <template #default="{ row }">
            <el-button link type="primary" @click="handleDownload(row.fileVo)">
              下载
            </el-button>
          </template>
        </el-table-column>
      </el-table>
    </div>

    <!-- 历史审批记录 -->
    <div class="section">
      <div class="section-header">
        <h3>审批记录</h3>
      </div>

      <el-table :data="approvalList" style="width: 100%">
        <el-table-column prop="approverName" label="审批人" />
        <el-table-column prop="status" label="审批结果">
          <template #default="{ row }">
            <el-tag :type="row.status === 'PASS' ? 'success' : 'danger'">
              {{ row.status === 'PASS' ? '通过' : '不通过' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="comment" label="审批意见" />
        <el-table-column prop="createTime" label="审批时间">
          <template #default="{ row }">
            {{ formatDateTime(row.createTime) }}
          </template>
        </el-table-column>
      </el-table>
    </div>

    <!-- 审批表单 -->
    <div class="approval-form">
      <h3>审批意见</h3>
      <el-form ref="formRef" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="审批结果" prop="status">
          <el-radio-group v-model="form.status">
            <el-radio label="PASS">通过</el-radio>
            <el-radio label="REJECT">不通过</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="审批意见" prop="comment">
          <el-input
            v-model="form.comment"
            type="textarea"
            :rows="3"
            placeholder="请输入审批意见"
          />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleSubmit">提交审批</el-button>
        </el-form-item>
      </el-form>
    </div>
  </page-container>
</template>

<script lang="ts" setup>
import { ref, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import type { FormInstance } from 'element-plus'
import { contractApi } from '../../api/contract'
import { CONTRACT_STATUS_MAP } from '../../types'
import type { ContractInfo } from '../../types'
import { formatDateTime } from '../../utils/format'
import { useStore } from '../../hooks/useStore'

const route = useRoute()
const router = useRouter()
const formRef = ref<FormInstance>()
const store = useStore()

const contractInfo = ref<Partial<ContractInfo>>({})
const fileList = ref([])
const approvalList = ref([])

const form = ref({
  status: '',
  comment: ''
})

const rules = {
  status: [{ required: true, message: '请选择审批结果', trigger: 'change' }],
  comment: [{ required: true, message: '请输入审批意见', trigger: 'blur' }]
}

// 获取合同详情
const getContractInfo = async () => {
  try {
    const res = await contractApi.getContractDetail(Number(route.params.id))
    contractInfo.value = res.data
  } catch (error) {
    ElMessage.error('获取合同详情失败')
  }
}

// 获取合同文件
const getFileList = async () => {
  try {
    const res = await contractApi.getContractFiles(Number(route.params.id))
    fileList.value = res.data
  } catch (error) {
    ElMessage.error('获取文件列表失败')
  }
}

// 获取审批记录
const getApprovalList = async () => {
  try {
    const res = await contractApi.getContractApprovals(Number(route.params.id))
    approvalList.value = res.data
  } catch (error) {
    ElMessage.error('获取审批记录失败')
  }
}

// 提交审批
const handleSubmit = async () => {
  if (!formRef.value) return
  
  await formRef.value.validate(async (valid) => {
    if (valid) {
      try {
        const contractId = Number(route.params.id)
        if (!contractId) {
          ElMessage.error('合同ID无效')
          return
        }

        await contractApi.submitApproval({
          contractId,
          approverId: store.userInfo.value?.id as number,
          status: form.value.status,
          comment: form.value.comment
        })
        ElMessage.success('提交成功')
        router.back()
      } catch (error) {
        if (error.response?.data?.message) {
          ElMessage.error(error.response.data.message)
        } else {
          ElMessage.error('提交失败')
        }
      }
    }
  })
}

const handleBack = () => {
  router.back()
}

const handleClientClick = (clientId: number) => {
  router.push(`/client/${clientId}`)
}

const handleDownload = (fileVo: any) => {
  if (fileVo?.url && fileVo?.fileName) {
    const link = document.createElement('a')
    link.href = fileVo.url
    link.download = fileVo.fileName
    document.body.appendChild(link)
    link.click()
    document.body.removeChild(link)
  }
}

onMounted(() => {
  getContractInfo()
  getFileList()
  getApprovalList()
})
</script>

<style scoped>
.header-actions {
  display: flex;
  align-items: center;
  margin-bottom: 20px;
  justify-content: space-between;
}

.title {
  font-size: 18px;
  font-weight: bold;
}

.section {
  margin-top: 24px;
}

.section-header {
  margin-bottom: 16px;
}

.section-header h3 {
  margin: 0;
  font-size: 16px;
}

.approval-form {
  margin-top: 24px;
  max-width: 600px;
}

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
</style> 