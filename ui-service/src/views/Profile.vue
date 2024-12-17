<template>
  <div class="profile">
    <page-loading :loading="loading" text="加载个人信息..." />
    <el-card class="box-card">
      <template #header>
        <div class="card-header">
          <span>个人信息</span>
          <el-button type="primary" @click="handleEdit">
            编辑
          </el-button>
        </div>
      </template>

      <el-descriptions :column="2">
        <el-descriptions-item label="用户名">
          {{ userInfo?.userName }}
        </el-descriptions-item>
        <el-descriptions-item label="角色">
          {{ userInfo?.role === 'admin' ? '管理员' : '普通用户' }}
        </el-descriptions-item>
        <el-descriptions-item label="真实姓名">
          {{ userInfo?.realName }}
        </el-descriptions-item>
        <el-descriptions-item label="邮箱">
          {{ userInfo?.email }}
        </el-descriptions-item>
        <el-descriptions-item label="手机号">
          {{ userInfo?.phone }}
        </el-descriptions-item>
      </el-descriptions>
    </el-card>

    <!-- 编辑弹窗 -->
    <el-dialog 
      v-model="dialogVisible" 
      title="编辑个人信息"
      width="500px"
      class="edit-dialog"
    >
      <el-form 
        ref="formRef"
        :model="form" 
        :rules="rules"
        label-width="100px"
        class="edit-form"
        v-loading="loading"
        element-loading-text="保存中..."
      >
        <el-form-item label="用户名" prop="userName">
          <el-input v-model="form.userName" />
        </el-form-item>
        <el-form-item label="真实姓名">
          <el-input v-model="form.realName" />
        </el-form-item>
        <el-form-item label="邮箱" prop="email">
          <el-input v-model="form.email" />
        </el-form-item>
        <el-form-item label="手机号" prop="phone">
          <el-input v-model="form.phone" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" @click="handleSave">保存</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script lang="ts">
import { defineComponent, reactive, ref } from 'vue'
import { useStore } from '../hooks/useStore'
import { ElMessage, type FormRules } from 'element-plus'
import { userApi } from '../api/user'
import PageLoading from '../components/PageLoading.vue'

export default defineComponent({
  name: 'Profile',
  components: {
    PageLoading
  },
  setup() {
    const store = useStore()
    const dialogVisible = ref(false)
    const formRef = ref()
    const loading = ref(false)
    const form = reactive({
      userName: '',
      realName: '',
      email: '',
      phone: ''
    })

    const rules: FormRules = {
      userName: [
        { required: true, message: '请输入用户名', trigger: 'blur' },
        { min: 2, max: 20, message: '长度在 2 到 20 个字符', trigger: 'blur' }
      ],
      email: [
        { required: true, message: '请输入邮箱', trigger: 'blur' },
        { type: 'email', message: '请输入正确的邮箱格式', trigger: 'blur' }
      ],
      phone: [
        { required: true, message: '请输入手机号', trigger: 'blur' },
        { pattern: /^1[3-9]\d{9}$/, message: '请输入正确的手机号格式', trigger: 'blur' }
      ]
    }

    const handleEdit = () => {
      Object.assign(form, store.userInfo.value)
      dialogVisible.value = true
    }

    const handleSave = async () => {
      if (!formRef.value) return
      
      await formRef.value.validate(async (valid: boolean) => {
        if (!valid) return
        
        loading.value = true
        try {
          await userApi.updateUserInfo(form)
          ElMessage.success('保存成功')
          dialogVisible.value = false
          store.getUserInfo()
        } catch (error) {
          ElMessage.error('保存失败')
        } finally {
          loading.value = false
        }
      })
    }

    return {
      userInfo: store.userInfo,
      dialogVisible,
      formRef,
      form,
      rules,
      loading,
      handleEdit,
      handleSave
    }
  }
})
</script>

<style scoped>
.profile {
  padding: 24px;
  position: relative;
  min-height: 200px;
}

.box-card {
  margin-bottom: 20px;
}

.card-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.edit-dialog :deep(.el-dialog__body) {
  padding: 20px;
}

.edit-form {
  width: 100%;
}
</style> 