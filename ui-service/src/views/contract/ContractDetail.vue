<template>
  <page-container :title="'合同详情 - ' + contract?.title">
    <el-descriptions :column="2" border>
      <el-descriptions-item label="合同编号">{{ contract?.id }}</el-descriptions-item>
      <el-descriptions-item label="合同标题">{{ contract?.title }}</el-descriptions-item>
      <el-descriptions-item label="客户">{{ contract?.clientName }}</el-descriptions-item>
      <el-descriptions-item label="创建人">{{ contract?.userName }}</el-descriptions-item>
      <el-descriptions-item label="合同金额">{{ contract?.totalAmount }}</el-descriptions-item>
      <el-descriptions-item label="状态">
        <el-tag :type="getStatusType(contract?.status)">
          {{ CONTRACT_STATUS_MAP[contract?.status] }}
        </el-tag>
      </el-descriptions-item>
      <el-descriptions-item label="创建时间">{{ contract?.createTime }}</el-descriptions-item>
      <el-descriptions-item label="更新时间">{{ contract?.updateTime }}</el-descriptions-item>
      <el-descriptions-item :span="2" label="合同内容">
        {{ contract?.content }}
      </el-descriptions-item>
    </el-descriptions>

    <!-- 合同审批组件 -->
    <contract-approval 
      :contract-id="Number(id)" 
      :status="contract?.status"
    />
  </page-container>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import { contractApi } from '../../api/contract'
import type { ContractInfo } from '../../api/contract'
import ContractApproval from './ContractApproval.vue'

const route = useRoute()
const id = route.params.id
const contract = ref<ContractInfo>()

const CONTRACT_STATUS_MAP = {
  draft: '草稿',
  pending: '待审核',
  approved: '已通过',
  rejected: '已驳回',
  completed: '已完成',
  cancelled: '已取消'
}

// 获取合同详情
const getContract = async () => {
  try {
    const res = await contractApi.getContract(Number(id))
    contract.value = res.data
  } catch (error) {
    console.error(error)
  }
}

// 获取状态样式
const getStatusType = (status?: string) => {
  if (!status) return ''
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

onMounted(() => {
  getContract()
})
</script> 