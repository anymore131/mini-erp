<template>
  <page-container>
    <div class="header-actions">
      <el-button @click="handleBack">返回</el-button>
      <div class="title">订单审批</div>
    </div>

    <!-- 订单详情 -->
    <el-descriptions :column="2" border>
      <el-descriptions-item label="订单编号">
        {{ orderInfo.orderNo }}
      </el-descriptions-item>
      <el-descriptions-item label="订单状态">
        <span 
          class="status-tag"
          :class="{
            'status-draft': orderInfo.status === 'DRAFT',
            'status-pending': orderInfo.status === 'PENDING',
            'status-approved': orderInfo.status === 'APPROVED',
            'status-rejected': orderInfo.status === 'REJECTED',
            'status-completed': orderInfo.status === 'COMPLETED',
            'status-cancelled': orderInfo.status === 'CANCELLED'
          }"
        >
          {{ orderInfo.status ? ORDER_STATUS_MAP[orderInfo.status] : '-' }}
        </span>
      </el-descriptions-item>
      <el-descriptions-item label="客户名称">
        <el-button 
          link 
          type="primary" 
          @click="handleClientClick(orderInfo.clientId)"
        >
          {{ orderInfo.clientName }}
        </el-button>
      </el-descriptions-item>
      <el-descriptions-item label="负责人">
        {{ orderInfo.userName }}
      </el-descriptions-item>
      <el-descriptions-item label="总金额">
        {{ orderInfo.totalAmount !== undefined && orderInfo.totalAmount !== null ? 
          `¥${(orderInfo.totalAmount / 100).toFixed(2)}` : '-' }}
      </el-descriptions-item>
      <el-descriptions-item label="创建时间">
        {{ orderInfo.createTime ? formatDateTime(orderInfo.createTime) : '-' }}
      </el-descriptions-item>
      <el-descriptions-item label="备注" :span="2">
        {{ orderInfo.remark || '-' }}
      </el-descriptions-item>
    </el-descriptions>

    <!-- 订单文件 -->
    <div class="section">
      <div class="section-header">
        <h3>订单文件</h3>
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

    <!-- 订单明细 -->
    <div class="section">
      <div class="section-header">
        <h3>订单明细</h3>
      </div>

      <el-table :data="itemList" style="width: 100%">
        <el-table-column prop="productName" label="产品名称" />
        <el-table-column prop="quantity" label="数量" />
        <el-table-column label="单价">
          <template #default="{ row }">
            {{ (row.unitPrice / 100).toFixed(2) }}
          </template>
        </el-table-column>
        <el-table-column label="总价">
          <template #default="{ row }">
            {{ (row.totalPrice / 100).toFixed(2) }}
          </template>
        </el-table-column>
        <el-table-column prop="remark" label="备注" />
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
        <el-table-column prop="approveTime" label="审批时间">
          <template #default="{ row }">
            {{ formatDateTime(row.approveTime) }}
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
import { orderApi } from '../../api/order'
import { ORDER_STATUS_MAP } from '../../types'
import type { OrderInfo } from '../../types'
import { formatDateTime } from '../../utils/format'
import { useStore } from '../../hooks/useStore'

const route = useRoute()
const router = useRouter()
const formRef = ref<FormInstance>()
const store = useStore()

const orderInfo = ref<Partial<OrderInfo>>({})
const fileList = ref([])
const itemList = ref([])
const approvalList = ref([])

const form = ref({
  status: '',
  comment: ''
})

const rules = {
  status: [{ required: true, message: '请选择审批结果', trigger: 'change' }],
  comment: [{ required: true, message: '请输入审批意见', trigger: 'blur' }]
}

// 获取订单详情
const getOrderInfo = async () => {
  try {
    const res = await orderApi.getOrderDetail(Number(route.params.id))
    orderInfo.value = res.data
  } catch (error) {
    ElMessage.error('获取订单详情失败')
  }
}

// 获取订单文件
const getFileList = async () => {
  try {
    const res = await orderApi.getOrderFiles(Number(route.params.id))
    fileList.value = res.data
  } catch (error) {
    ElMessage.error('获取文件列表失败')
  }
}

// 获取订单明细
const getItemList = async () => {
  try {
    const res = await orderApi.getOrderItems(Number(route.params.id))
    itemList.value = res.data
  } catch (error) {
    ElMessage.error('获取订单明细失败')
  }
}

// 获取审批记录
const getApprovalList = async () => {
  try {
    const res = await orderApi.getOrderApprovals(Number(route.params.id))
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
        const orderId = Number(route.params.id)
        if (!orderId) {
          ElMessage.error('订单ID无效')
          return
        }

        await orderApi.submitApproval({
          orderId,
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
  getOrderInfo()
  getFileList()
  getItemList()
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