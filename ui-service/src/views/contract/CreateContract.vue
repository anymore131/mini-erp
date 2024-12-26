<template>
  <page-container>
    <page-loading :loading="loading" />
    
    <el-alert
      v-if="error"
      :title="error"
      type="error"
      :closable="false"
      show-icon
    />

    <div class="header-actions">
      <el-button @click="handleBack">返回</el-button>
      <div class="title">创建合同</div>
    </div>

    <!-- 客户状态卡片 -->
    <el-card class="client-status" shadow="hover">
      <template #header>
        <div class="card-header">
          <span>客户状态</span>
          <div class="status-tags">
            <el-tag 
              :type="hasOrders ? 'success' : 'warning'"
              size="small"
              class="mr-2"
            >
              {{ hasOrders ? '已有订单' : '暂无订单' }}
            </el-tag>
            <el-tag 
              v-if="hasActiveOrders"
              type="primary" 
              size="small"
            >
              有进行中订单
            </el-tag>
          </div>
        </div>
      </template>
      <div class="client-info">
        <div class="info-item">
          <span class="label">客户名称：</span>
          <span>{{ clientName }}</span>
        </div>
        <div class="info-item">
          <span class="label">总订单数：</span>
          <span>{{ orderList.length }}</span>
        </div>
        <div class="info-item">
          <span class="label">已完成订单：</span>
          <span>{{ completedOrders.length }}</span>
        </div>
        <div class="info-item">
          <span class="label">进行中订单：</span>
          <span>{{ activeOrders.length }}</span>
        </div>
        <div class="info-item">
          <span class="label">订单总额：</span>
          <span>¥{{ totalOrderAmount.toFixed(2) }}</span>
        </div>
        <div class="info-item">
          <span class="label">完成率：</span>
          <span>{{ completionRate }}%</span>
        </div>
      </div>
    </el-card>

    <!-- 选择订单 -->
    <el-form
      ref="formRef"
      :model="form"
      :rules="rules"
      label-width="100px"
      class="contract-form"
    >
      <el-form-item label="关联订单" prop="orderId">
        <el-select
          v-model="form.orderId"
          placeholder="请选择关联订单"
          style="width: 100%"
          @change="handleOrderSelect"
        >
          <el-option
            v-for="order in completedOrders"
            :key="order.id"
            :label="`订单号: ${order.orderNo} - 金额: ¥${(order.totalAmount / 100).toFixed(2)}`"
            :value="order.id"
          >
            <div class="order-option">
              <span>订单号: {{ order.orderNo }}</span>
              <div class="order-info">
                <span class="order-amount">¥{{ (order.totalAmount / 100).toFixed(2) }}</span>
                <el-tag
                  size="small"
                  :type="order.status === 'COMPLETED' ? 'success' : 'primary'"
                >
                  {{ ORDER_STATUS_MAP[order.status] }}
                </el-tag>
                <span class="order-date">{{ formatDate(order.createTime) }}</span>
              </div>
            </div>
          </el-option>
        </el-select>
      </el-form-item>

      <el-form-item label="合同标题" prop="title">
        <el-input
          v-model="form.title"
          placeholder="请输入合同标题"
        />
      </el-form-item>

      <el-form-item label="合同金额" prop="totalAmount">
        <el-input-number
          v-model="form.totalAmount"
          :min="0"
          :precision="2"
          :step="100"
          style="width: 200px"
          placeholder="请输入合同金额"
          :disabled="true"
        />
        <span class="tip">（自动使用订单金额）</span>
      </el-form-item>

      <el-form-item label="合同内容" prop="content">
        <el-input
          v-model="form.content"
          type="textarea"
          :rows="5"
          placeholder="请输入合同内容"
        />
      </el-form-item>
    </el-form>

    <div class="form-actions">
      <el-button type="primary" @click="handleSubmit" :disabled="!form.orderId">保存</el-button>
      <el-button @click="handleBack">取消</el-button>
    </div>
  </page-container>
</template>

<script lang="ts" setup>
import { ref, computed, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import type { FormInstance } from 'element-plus'
import { contractApi } from '../../api/contract'
import { clientApi } from '../../api/client'
import { orderApi } from '../../api/order'
import { useStore } from '../../hooks/useStore'

const route = useRoute()
const router = useRouter()
const store = useStore()
const formRef = ref<FormInstance>()
const clientName = ref('')
const orderList = ref([])
const loading = ref(false)
const error = ref('')

// 验证客户ID
const clientId = computed(() => {
  const id = Number(route.params.clientId)
  if (!id || isNaN(id)) {
    ElMessage.error('无效的客户ID')
    router.push('/client') // 或其他适当的路由
    return null
  }
  return id
})

const form = ref({
  clientId: clientId.value,
  userId: store.userInfo.value?.id,
  orderId: undefined as number | undefined,
  title: '',
  content: '',
  totalAmount: undefined as number | undefined
})

const rules = {
  orderId: [
    { required: true, message: '请选择关联订单', trigger: 'change' }
  ],
  title: [
    { required: true, message: '请输入合同标题', trigger: 'blur' },
    { max: 100, message: '标题最多100字符', trigger: 'blur' }
  ],
  content: [
    { required: true, message: '请输入合同内容', trigger: 'blur' },
    { max: 2000, message: '内容最多2000字符', trigger: 'blur' }
  ]
}

// 添加订单状态映射
const ORDER_STATUS_MAP: Record<string, string> = {
  'DRAFT': '草稿',
  'PENDING': '待审核',
  'APPROVED': '已通过',
  'REJECTED': '已驳回',
  'COMPLETED': '已完成',
  'CANCELLED': '已取消'
}

// 修改计算属性
const hasOrders = computed(() => orderList.value.length > 0)
const completedOrders = computed(() =>
  orderList.value.filter(order => order.status === 'COMPLETED')
)
const activeOrders = computed(() =>
  orderList.value.filter(order =>
    ['APPROVED', 'PENDING'].includes(order.status)
  )
)
const hasActiveOrders = computed(() => activeOrders.value.length > 0)
const totalOrderAmount = computed(() =>
  orderList.value.reduce((sum, order) => sum + order.totalAmount / 100, 0)
)
const completionRate = computed(() => {
  if (orderList.value.length === 0) return 0
  return Math.round((completedOrders.value.length / orderList.value.length) * 100)
})

// 格式化日期
const formatDate = (date: string) => {
  return new Date(date).toLocaleDateString('zh-CN')
}

// 获取客户信息
const getClientInfo = async () => {
  loading.value = true
  error.value = ''

  if (!clientId.value) return

  try {
    const res = await clientApi.getClientDetail(clientId.value)
    if (res.code === 200 && res.data) {
      clientName.value = res.data.name
    } else {
      ElMessage.error('获取客户信息失败：' + (res.msg || '未知错误'))
    }
  } catch (err: any) {
    error.value = '获取客户信息失败：' + (err.message || '未知错误')
  } finally {
    loading.value = false
  }
}

// 获取客户的订单列表
const getOrderList = async () => {
  try {
    const res = await orderApi.getOrders({
      pageNum: 1,
      pageSize: 1000,
      clientId: form.value.clientId,
      // 不再过滤状态，获取所有订单
    })
    orderList.value = res.data.list
    
    if (orderList.value.length === 0) {
      ElMessage.warning('该客户暂无订单记录，请先创建订单')
    } else if (completedOrders.value.length === 0) {
      ElMessage.warning('该客户暂无已完成的订单，请等待订单完成后再创建合同')
    }
  } catch (error) {
    ElMessage.error('获取订单列表失败')
  }
}

// 选择订单时自动填充金额
const handleOrderSelect = (orderId: number) => {
  const selectedOrder = orderList.value.find(order => order.id === orderId)
  if (selectedOrder) {
    form.value.totalAmount = selectedOrder.totalAmount / 100
    form.value.title = `${clientName.value}-${selectedOrder.orderNo}合同`
  }
}

// 提交表单
const handleSubmit = async () => {
  if (!formRef.value) return
  if (!form.value.userId) {
    ElMessage.error('用户ID不能为空')
    return
  }
  
  await formRef.value.validate(async (valid) => {
    if (valid) {
      try {
        const res = await contractApi.createContract({
          clientId: form.value.clientId,
          userId: form.value.userId,
          orderId: form.value.orderId,
          title: form.value.title,
          content: form.value.content,
          totalAmount: form.value.totalAmount!
        })
        ElMessage.success('创建成功')
        router.push(`/contract/${res.data}`)
      } catch (error) {
        ElMessage.error('创建失败')
      }
    }
  })
}

// 返回
const handleBack = () => {
  router.back()
}

onMounted(async () => {
  if (clientId.value) {
    await getClientInfo()
    await getOrderList()
  }
})
</script>

<style scoped>
.header-actions {
  display: flex;
  align-items: center;
  margin-bottom: 20px;
}

.title {
  margin-left: 20px;
  font-size: 18px;
  font-weight: bold;
}

.contract-form {
  max-width: 800px;
}

.form-actions {
  margin-top: 20px;
  text-align: center;
}

.tip {
  margin-left: 10px;
  color: #909399;
  font-size: 14px;
}

.client-status {
  margin-bottom: 20px;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.client-info {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 16px;
}

.info-item {
  display: flex;
  align-items: center;
}

.label {
  color: #606266;
  margin-right: 8px;
}

.order-option {
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 100%;
}

.order-amount {
  color: #67C23A;
  font-weight: bold;
}

.order-date {
  color: #909399;
  font-size: 12px;
}

.tip {
  margin-left: 10px;
  color: #909399;
  font-size: 14px;
}

.status-tags {
  display: flex;
  gap: 8px;
}

.mr-2 {
  margin-right: 8px;
}

.order-info {
  display: flex;
  align-items: center;
  gap: 12px;
}
</style>