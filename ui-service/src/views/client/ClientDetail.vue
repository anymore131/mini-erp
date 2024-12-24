<template>
  <page-container>
    <!-- 标题和操作按钮 -->
    <div class="header-actions">
      <el-button @click="handleBack">返回</el-button>
      <div class="title">{{ title }}</div>
      <div class="right-actions">
        <el-button type="primary" @click="handleCreateOrder">创建订单</el-button>
        <el-button type="primary" @click="handleEdit">编辑</el-button>
      </div>
    </div>

    <el-descriptions :column="2" border>
      <el-descriptions-item label="客户名称">
        {{ clientInfo.name }}
      </el-descriptions-item>
      <el-descriptions-item label="状态">
        <span 
          class="status-tag"
          :class="{
            'status-start': clientInfo.status === 'START',
              'status-cooperation': clientInfo.status === 'COOPERATION',
              'status-waiting': clientInfo.status === 'WAITING'
          }"
        >
          {{ clientInfo.status ? CLIENT_STATUS_MAP[clientInfo.status] : '-' }}
        </span>
      </el-descriptions-item>
      <el-descriptions-item label="联系电话">
        {{ clientInfo.mobile || '-' }}
      </el-descriptions-item>
      <el-descriptions-item label="电子邮箱">
        {{ clientInfo.email || '-' }}
      </el-descriptions-item>
      <el-descriptions-item label="联系地址">
        {{ clientInfo.address || '-' }}
      </el-descriptions-item>
      <el-descriptions-item label="负责销售">
        <el-button 
          link 
          type="primary" 
          @click="handleUserClick(clientInfo.userId)"
        >
          {{ clientInfo.userName }}
        </el-button>
      </el-descriptions-item>
      <el-descriptions-item label="累计金额">
        {{ clientInfo.sum }}
      </el-descriptions-item>
      <el-descriptions-item label="最后更新">
        {{ clientInfo.lastTime }}
      </el-descriptions-item>
      <el-descriptions-item label="备注" :span="2">
        {{ clientInfo.remark || '-' }}
      </el-descriptions-item>
    </el-descriptions>

    <!-- 相关订单列表 -->
    <div class="order-section">
      <div class="section-header">
        <h3>相关订单</h3>
      </div>
      
      <el-table :data="orderList" style="width: 100%">
        <el-table-column prop="orderNo" label="订单编号">
          <template #default="{ row }">
            <el-button 
              link 
              type="primary" 
              @click="handleOrderClick(row.id)"
            >
              {{ row.orderNo }}
            </el-button>
          </template>
        </el-table-column>
        <el-table-column prop="userName" label="负责人" />
        <el-table-column label="总金额">
          <template #default="{ row }">
            {{ (row.totalAmount / 100).toFixed(2) }}
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
              {{ ORDER_STATUS_MAP[row.status] }}
            </span>
          </template>
        </el-table-column>
        <el-table-column prop="createTime" label="创建时间">
          <template #default="{ row }">
            {{ formatDateTime(row.createTime) }}
          </template>
        </el-table-column>
      </el-table>
    </div>

    <!-- 编辑对话框 -->
    <el-dialog
      v-model="dialogVisible"
      :title="'编辑客户 - ' + clientInfo.name"
      width="500px"
    >
      <el-form
        ref="formRef"
        :model="form"
        :rules="rules"
        label-width="100px"
      >
        <el-form-item label="客户名称" prop="name">
          <el-input v-model="form.name" />
        </el-form-item>
        <el-form-item label="联系电话" prop="mobile">
          <el-input v-model="form.mobile" />
        </el-form-item>
        <el-form-item label="电子邮箱" prop="email">
          <el-input v-model="form.email" />
        </el-form-item>
        <el-form-item label="联系地址" prop="address">
          <el-input v-model="form.address" />
        </el-form-item>
        <el-form-item label="备注" prop="remark">
          <el-input
            v-model="form.remark"
            type="textarea"
            :rows="3"
          />
        </el-form-item>
      </el-form>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="dialogVisible = false">取消</el-button>
          <el-button type="primary" @click="handleSubmit">确认</el-button>
        </span>
      </template>
    </el-dialog>
  </page-container>
</template>

<script lang="ts" setup>
import { ref, onMounted, computed } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import type { FormInstance } from 'element-plus'
import { clientApi } from '../../api/client'
import { orderApi } from '../../api/order'
import { CLIENT_STATUS_MAP, ORDER_STATUS_MAP } from '../../types'
import type { ClientInfo, ClientForm, OrderInfo } from '../../types'
import { formatDateTime } from '../../utils/format'
import { useStore } from '../../hooks/useStore'

const route = useRoute()
const router = useRouter()

const clientInfo = ref<ClientInfo>({} as ClientInfo)
const dialogVisible = ref(false)
const formRef = ref<FormInstance>()

const title = computed(() => `客户详情 - ${clientInfo.value.name || ''}`)

// 表单数据
const form = ref<ClientForm>({
  name: '',
  mobile: '',
  email: '',
  address: '',
  status: '',
  remark: '',
  userId: 0
})

// 表单校验规则
const rules = {
  name: [{ required: true, message: '请输入客户名称', trigger: 'blur' }],
  mobile: [{ pattern: /^1[3-9]\d{9}$/, message: '请输入正确的手机号', trigger: 'blur' }],
  email: [{ type: 'email' as const, message: '请输入正确的邮箱地址', trigger: 'blur' }],
  status: [{ required: true, message: '请选择客户状态', trigger: 'change' }]
}

// 获取客户详情
const getClientInfo = async (id: number) => {
  try {
    const res = await clientApi.getClientDetail(id)
    clientInfo.value = res.data
  } catch (error) {
    ElMessage.error('获取客户详情失败')
  }
}

// 打开编辑对话框
const handleEdit = () => {
  const { id, name, mobile, email, address, userId, remark, status } = clientInfo.value
  form.value = {
    id, name, mobile, email, address, userId, remark,
    status: CLIENT_STATUS_MAP[status]
  }
  dialogVisible.value = true
}

// 提交编辑
const handleSubmit = async () => {
  if (!formRef.value) return
  
  await formRef.value.validate(async (valid) => {
    if (valid) {
      try {
        const submitData = {
          ...form.value,
          id: clientInfo.value.id
        }
        await clientApi.updateClient(submitData)
        ElMessage.success('更新成功')
        dialogVisible.value = false
        getClientInfo(clientInfo.value.id)
      } catch (error) {
        ElMessage.error('更新失败')
      }
    }
  })
}

// 返回处理
const handleBack = () => {
  if (window.history.state?.back) {
    router.back()
  } else {
    router.push('/client-manage')
  }
}

// 点击用户名跳转到用户详情
const handleUserClick = (id: number) => {
  router.push(`/user/${id}`)
}

const orderList = ref([])

// 获取客户相关订单
const getClientOrders = async (clientId: number) => {
  try {
    const store = useStore()
    if (!store.userInfo.value?.id) {
      ElMessage.error('获取用户信息失败')
      return
    }

    const res = await orderApi.getOrders({
      clientId,
      userId: store.userInfo.value.id,
      pageNum: 1,
      pageSize: 1000
    })
    orderList.value = res.data.list
  } catch (error) {
    ElMessage.error('获取订单列表失败')
  }
}

// 点击订单编号跳转到订单详情
const handleOrderClick = (id: number) => {
  router.push(`/order/${id}`)
}

// 创建订单
const handleCreateOrder = () => {
  router.push(`/order/create/${clientInfo.value.id}`)
}

onMounted(() => {
  const id = Number(route.params.id)
  if (id) {
    getClientInfo(id)
    getClientOrders(id)
  }
})
</script>

<style scoped>
.header-actions {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.title {
  font-size: 18px;
  font-weight: bold;
}

.dialog-footer {
  display: flex;
  justify-content: flex-end;
  gap: 10px;
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

.order-section {
  margin-top: 24px;
}

.section-header {
  margin-bottom: 16px;
}

.section-header h3 {
  margin: 0;
  font-size: 16px;
}

/* 订单状态样式 */
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

.right-actions {
  display: flex;
  gap: 10px;
}
</style> 