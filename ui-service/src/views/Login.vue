<template>
  <div class="login-container">
    <el-card class="login-card">
      <template #header>
        <div class="login-header">
          <h2>登录</h2>
        </div>
      </template>
      
      <el-form
        ref="loginFormRef"
        :model="loginForm"
        :rules="rules"
        label-width="80px"
        @submit.prevent="handleSubmit"
      >
        <el-form-item label="用户名" prop="userName">
          <el-input 
            v-model="loginForm.userName"
            placeholder="请输入用户名"
            prefix-icon="User"
          />
        </el-form-item>

        <el-form-item label="密码" prop="password">
          <el-input 
            v-model="loginForm.password"
            type="password"
            placeholder="请输入密码"
            prefix-icon="Lock"
            show-password
          />
        </el-form-item>

        <el-form-item>
          <el-button 
            type="primary" 
            :loading="loading" 
            class="login-button"
            @click="handleSubmit"
          >
            登录
          </el-button>
        </el-form-item>
      </el-form>
    </el-card>
  </div>
</template>

<script lang="ts">
import { defineComponent, reactive, ref } from 'vue'
import { useStore } from '../hooks/useStore'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { userApi } from '../api/user'
import type { LoginForm } from '../types'

export default defineComponent({
  name: 'Login',
  setup() {
    const store = useStore()
    const router = useRouter()
    const loading = ref(false)
    const loginFormRef = ref()

    const loginForm = reactive<LoginForm>({
      userName: '',
      password: ''
    })

    const rules = {
      userName: [
        { required: true, message: '请输入用户名', trigger: 'blur' },
        { min: 3, max: 20, message: '长度在 3 到 20 个字符', trigger: 'blur' }
      ],
      password: [
        { required: true, message: '请输入密码', trigger: 'blur' }
      ]
    }

    const handleSubmit = async () => {
      if (!loginFormRef.value) return
      
      await loginFormRef.value.validate(async (valid: boolean) => {
        if (!valid) return
        
        loading.value = true
        try {
          const res = await userApi.login(loginForm)
          if (res.code === 200 && res.data) {
            localStorage.setItem('token', `Bearer ${res.data.userName}`)
            await store.setUserInfo(res.data)
            ElMessage.success(res.msg || '登录成功')
            router.push('/dashboard')
          } else {
            throw new Error(res.msg || '登录失败')
          }
        } catch (error: any) {
          console.log(error)
          const errorMsg = error.response?.data?.msg || error.message || '登录失败'
          ElMessage.error(errorMsg)
        } finally {
          loading.value = false
        }
      })
    }

    return {
      loginForm,
      loginFormRef,
      loading,
      rules,
      handleSubmit
    }
  }
})
</script>

<style scoped>
.login-container {
  height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
  background: #f0f2f5;
}

.login-card {
  width: 400px;
}

.login-header {
  text-align: center;
}

.login-header h2 {
  margin: 0;
  font-weight: 500;
  color: #303133;
}

.login-button {
  width: 100%;
}

:deep(.el-form-item__label) {
  color: #606266;
}

:deep(.el-input__wrapper) {
  background-color: #fff;
}
</style> 