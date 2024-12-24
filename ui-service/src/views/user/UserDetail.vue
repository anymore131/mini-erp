<template>
  <page-container>
    <!-- 标题和操作按钮 -->
    <div class="header-actions">
      <el-button @click="handleBack">返回</el-button>
      <div class="title">{{ title }}</div>
      <el-button type="primary" @click="handleEdit">编辑</el-button>
    </div>

    <el-descriptions :column="2" border>
      <el-descriptions-item label="用户名">
        {{ userInfo.userName }}
      </el-descriptions-item>
      <el-descriptions-item label="真实姓名">
        {{ userInfo.realName }}
      </el-descriptions-item>
      <el-descriptions-item label="电子邮箱">
        {{ userInfo.email || '-' }}
      </el-descriptions-item>
      <el-descriptions-item label="联系电话">
        {{ userInfo.phone || '-' }}
      </el-descriptions-item>
      <el-descriptions-item label="角色">
        {{ userInfo.role === 'admin' ? '管理员' : '普通用户' }}
      </el-descriptions-item>
      <el-descriptions-item label="创建时间">
        {{ formatTime(userInfo.createTime) }}
      </el-descriptions-item>
      <el-descriptions-item label="最后更新">
        {{ formatTime(userInfo.lastUpdate) }}
      </el-descriptions-item>
    </el-descriptions>

    <!-- 编辑对话框 -->
    <el-dialog
      v-model="dialogVisible"
      :title="'编辑用户 - ' + userInfo.userName"
      width="500px"
    >
      <el-form
        ref="formRef"
        :model="form"
        :rules="rules"
        label-width="100px"
      >
        <el-form-item label="用户名" prop="userName">
          <el-input v-model="form.userName" disabled />
        </el-form-item>
        <el-form-item label="真实姓名" prop="realName">
          <el-input v-model="form.realName" />
        </el-form-item>
        <el-form-item label="电子邮箱" prop="email">
          <el-input v-model="form.email" />
        </el-form-item>
        <el-form-item label="联系电话" prop="phone">
          <el-input v-model="form.phone" />
        </el-form-item>
      </el-form>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="dialogVisible = false">取消</el-button>
          <el-button type="primary" @click="handleSubmit">确认</el-button>
        </span>
      </template>
    </el-dialog>

    <!-- 添加客户列表 -->
    <div class="client-list">
      <div class="section-title">负责的客户</div>
      <el-table
        :data="clientList"
        style="width: 100%; margin-top: 20px"
        v-loading="clientLoading"
      >
        <el-table-column prop="name" label="客户名称">
          <template #default="{ row }">
            <el-button 
              link 
              type="primary" 
              @click="handleClientClick(row.id)"
            >
              {{ row.name }}
            </el-button>
          </template>
        </el-table-column>
        <el-table-column prop="status" label="状态">
          <template #default="{ row }">
            <span 
              class="status-tag" 
              :class="{
                'status-start': row.status === 'START',
                'status-cooperation': row.status === 'COOPERATION',
                'status-waiting': row.status === 'WAITING'
              }"
            >
              {{ CLIENT_STATUS_MAP[row.status] || row.status }}
            </span>
          </template>
        </el-table-column>
        <el-table-column prop="sum" label="交易额">
          <template #default="{ row }">
            {{ (row.sum / 100).toFixed(2) }}
          </template>
        </el-table-column>
        <el-table-column prop="lastTime" label="最后更新时间" />
      </el-table>
    </div>
  </page-container>
</template>

<script lang="ts" setup>
import { ref, onMounted, computed } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import type { FormInstance } from 'element-plus'
import { userApi } from '../../api/user'
import { clientApi } from '../../api/client'
import { CLIENT_STATUS_MAP } from '../../types'
import type { UserInfo, UserForm, ClientInfo } from '../../types'
import { formatDateTime } from '../../utils/format'

const route = useRoute()
const router = useRouter()

const userInfo = ref<UserInfo>({} as UserInfo)
const dialogVisible = ref(false)
const formRef = ref<FormInstance>()

const title = computed(() => `用户详情 - ${userInfo.value.userName || ''}`)

// 表单数据
const form = ref<UserForm>({
  userName: '',
  realName: '',
  email: '',
  phone: '',
  role: ''
})

// 表单校验规则
const rules = {
  realName: [{ required: true, message: '请输入真实姓名', trigger: 'blur' }],
  email: [{ type: 'email' as const, message: '请输入正确的邮箱地址', trigger: 'blur' }],
  phone: [{ pattern: /^1[3-9]\d{9}$/, message: '请输入正确的手机号', trigger: 'blur' }]
}

// 获取用户详情
const getUserInfo = async (id: number) => {
  try {
    const res = await userApi.get(id)
    userInfo.value = res.data
  } catch (error) {
    ElMessage.error('获取用户详情失败')
  }
}

// 打开编辑对话框
const handleEdit = () => {
  form.value = {
    ...userInfo.value,
    password: undefined
  }
  dialogVisible.value = true
}

// 提交编辑
const handleSubmit = async () => {
  if (!formRef.value) return
  
  await formRef.value.validate(async (valid: boolean) => {
    if (valid) {
      try {
        await userApi.updateUser(form.value)
        ElMessage.success('更新成功')
        dialogVisible.value = false
        getUserInfo(userInfo.value.id)
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
    router.push('/user-manage')
  }
}

// 客户列表相关
const clientList = ref<ClientInfo[]>([])
const clientLoading = ref(false)

// 获取用户的客户列表
const getClientList = async (userId: number) => {
  clientLoading.value = true
  try {
    const res = await clientApi.getClients({
      pageNum: 1,
      pageSize: 1000,
      userId
    })
    if (res.code === 200 && res.data) {
      clientList.value = res.data.list
    }
  } catch (error) {
    ElMessage.error('获取客户列表失败')
  } finally {
    clientLoading.value = false
  }
}

// 点击客户名称跳转到客户详情
const handleClientClick = (id: number) => {
  router.push(`/client/${id}`)
}

const formatTime = (time: string | null) => time ? formatDateTime(time) : ''

onMounted(() => {
  const id = Number(route.params.id)
  if (id) {
    getUserInfo(id)
    getClientList(id)
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

.client-list {
  margin-top: 30px;
}

.section-title {
  font-size: 16px;
  font-weight: bold;
  margin-bottom: 16px;
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
</style> 