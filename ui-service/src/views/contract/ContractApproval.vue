<template>
  <div class="contract-approval">
    <h3>审批记录</h3>
    
    <!-- 审批记录列表 -->
    <el-timeline>
      <el-timeline-item
        v-for="item in approvals"
        :key="item.id"
        :type="getStatusType(item.status)"
        :timestamp="item.createTime"
      >
        <el-card>
          <template #header>
            <div class="approval-header">
              <span>{{ item.userName }}</span>
              <el-tag :type="getStatusType(item.status)">
                {{ APPROVAL_STATUS_MAP[item.status] }}
              </el-tag>
            </div>
          </template>
          <p>{{ item.approvalOpinion }}</p>
        </el-card>
      </el-timeline-item>
    </el-timeline>

    <!-- 审批操作 -->
    <div v-if="showApprovalActions" class="approval-actions">
      <el-input
        v-model="comment"
        type="textarea"
        rows="3"
        placeholder="请输入审批意见"
      />
      <div class="action-buttons">
        <el-button type="success" @click="handlePass">通过</el-button>
        <el-button type="danger" @click="handleReject">驳回</el-button>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, computed } from 'vue'
import { ElMessage } from 'element-plus'
import { contractApi } from '../../api/contract.ts'
import type { ContractApproval } from '../../api/contract.ts'

const props = defineProps<{
  contractId: number
  status: string
}>()

const APPROVAL_STATUS_MAP = {
  0: '待审核',
  1: '通过',
  2: '驳回'
}

const approvals = ref<ContractApproval[]>([])
const comment = ref('')

// 只有管理员且合同状态为pending时显示审批操作
const showApprovalActions = computed(() => {
  return props.status === 'pending'
})

// 获取审批记录
const getApprovals = async () => {
  try {
    const res = await contractApi.getApprovals(props.contractId)
    approvals.value = res.data
  } catch (error) {
    console.error(error)
  }
}

// 获取状态样式
const getStatusType = (status: number) => {
  const map: Record<number, string> = {
    0: 'warning',
    1: 'success',
    2: 'danger'
  }
  return map[status]
}

// 通过审批
const handlePass = async () => {
  if (!comment.value) {
    return ElMessage.warning('请输入审批意见')
  }
  try {
    await contractApi.passApproval(props.contractId, comment.value)
    ElMessage.success('操作成功')
    comment.value = ''
    getApprovals()
  } catch (error) {
    console.error(error)
  }
}

// 驳回审批
const handleReject = async () => {
  if (!comment.value) {
    return ElMessage.warning('请输入审批意见')
  }
  try {
    await contractApi.rejectApproval(props.contractId, comment.value)
    ElMessage.success('操作成功')
    comment.value = ''
    getApprovals()
  } catch (error) {
    console.error(error)
  }
}

onMounted(() => {
  getApprovals()
})
</script>

<style scoped>
.contract-approval {
  margin-top: 20px;
}

.approval-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.approval-actions {
  margin-top: 20px;
}

.action-buttons {
  margin-top: 10px;
  text-align: right;
}
</style> 