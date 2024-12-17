<template>
  <el-container class="layout-container">
    <!-- 侧边栏 -->
    <el-aside width="200px" class="sidebar-container">
      <div class="logo">
        <span>ERP 管理系统</span>
      </div>
      <el-menu
        :default-active="currentRoute"
        class="el-menu-vertical"
        background-color="#304156"
        text-color="#bfcbd9"
        active-text-color="#409EFF"
        router
      >
        <el-menu-item index="/dashboard">
          <el-icon><Odometer /></el-icon>
          <span>控制台</span>
        </el-menu-item>

        <el-sub-menu index="system" v-if="isAdmin">
          <template #title>
            <el-icon><Setting /></el-icon>
            <span>系统管理</span>
          </template>
          <el-menu-item index="/user-manage">用户管理</el-menu-item>
        </el-sub-menu>

        <el-menu-item index="/profile">
          <el-icon><User /></el-icon>
          <span>个人中心</span>
        </el-menu-item>
      </el-menu>
    </el-aside>

    <el-container>
      <!-- 头部 -->
      <el-header class="navbar">
        <div class="hamburger">
          <el-icon><Fold /></el-icon>
        </div>
        <div class="right-menu">
          <el-dropdown trigger="click">
            <span class="el-dropdown-link">
              <el-avatar size="small" :src="''">
                {{ userInfo?.userName?.charAt(0).toUpperCase() }}
              </el-avatar>
              <span class="username">{{ userInfo?.userName }}</span>
            </span>
            <template #dropdown>
              <el-dropdown-menu>
                <el-dropdown-item @click="$router.push('/profile')">
                  <el-icon><User /></el-icon>个人信息
                </el-dropdown-item>
                <el-dropdown-item @click="showChangePasswordDialog">
                  <el-icon><Key /></el-icon>修改密码
                </el-dropdown-item>
                <el-dropdown-item divided @click="handleLogout">
                  <el-icon><SwitchButton /></el-icon>退出登录
                </el-dropdown-item>
              </el-dropdown-menu>
            </template>
          </el-dropdown>
        </div>
      </el-header>

      <!-- 主要内容区 -->
      <el-main class="main-content">
        <router-view v-slot="{ Component }">
          <transition name="fade-transform" mode="out-in">
            <component :is="Component" />
          </transition>
        </router-view>
      </el-main>
    </el-container>
  </el-container>

  <!-- 添加修改密码弹窗 -->
  <el-dialog
    v-model="passwordDialogVisible"
    title="修改密码"
    width="400px"
  >
    <el-form
      ref="passwordFormRef"
      :model="passwordForm"
      label-width="100px"
      :rules="passwordRules"
    >
      <el-form-item label="原密码" prop="oldPassword">
        <el-input
          v-model="passwordForm.oldPassword"
          type="password"
          show-password
        />
      </el-form-item>
      <el-form-item label="新密码" prop="newPassword">
        <el-input
          v-model="passwordForm.newPassword"
          type="password"
          show-password
        />
      </el-form-item>
    </el-form>
    <template #footer>
      <el-button @click="passwordDialogVisible = false">取消</el-button>
      <el-button type="primary" @click="handleChangePassword">确定</el-button>
    </template>
  </el-dialog>
</template>

<script lang="ts">
import { defineComponent, computed, ref, reactive } from 'vue'
import { useStore } from '../hooks/useStore'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { userApi } from '../api/user'

export default defineComponent({
  name: 'Layout',
  setup() {
    const store = useStore()
    const router = useRouter()

    const currentRoute = computed(() => router.currentRoute.value.path)

    const handleLogout = async () => {
      await store.logout()
      router.push('/login')
    }

    const passwordDialogVisible = ref(false)
    const passwordFormRef = ref()
    const passwordForm = reactive({
      oldPassword: '',
      newPassword: ''
    })

    const passwordRules = {
      oldPassword: [{ required: true, message: '请输入原密码', trigger: 'blur' }],
      newPassword: [{ required: true, message: '请输入新密码', trigger: 'blur' }]
    }

    const showChangePasswordDialog = () => {
      passwordDialogVisible.value = true
      passwordForm.oldPassword = ''
      passwordForm.newPassword = ''
    }

    const handleChangePassword = async () => {
      if (!passwordFormRef.value) return
      
      await passwordFormRef.value.validate(async (valid: boolean) => {
        if (!valid) return
        
        try {
          await userApi.updatePassword(passwordForm)
          ElMessage.success('密码修改成功')
          passwordDialogVisible.value = false
        } catch (error) {
          ElMessage.error('密码修改失败')
        }
      })
    }

    return {
      currentRoute,
      isAdmin: store.isAdmin,
      userInfo: store.userInfo,
      handleLogout,
      passwordDialogVisible,
      passwordFormRef,
      passwordForm,
      showChangePasswordDialog,
      handleChangePassword,
      passwordRules
    }
  }
})
</script>

<style scoped>
.layout-container {
  height: 100vh;
}

.sidebar-container {
  background-color: #304156;
  height: 100%;
  position: fixed;
  left: 0;
  top: 0;
  bottom: 0;
  overflow: hidden;
}

.logo {
  height: 50px;
  line-height: 50px;
  background: #2b2f3a;
  text-align: center;
  color: #fff;
  font-size: 16px;
  font-weight: bold;
}

.navbar {
  height: 50px;
  line-height: 50px;
  background: #fff;
  border-bottom: 1px solid #d8dce5;
  box-shadow: 0 1px 4px rgba(0,21,41,.08);
  display: flex;
  justify-content: space-between;
  padding: 0 15px;
}

.hamburger {
  cursor: pointer;
  font-size: 20px;
}

.right-menu {
  display: flex;
  align-items: center;
}

.el-dropdown-link {
  display: flex;
  align-items: center;
  cursor: pointer;
}

.username {
  margin-left: 8px;
  margin-right: 4px;
}

.main-content {
  position: relative;
  padding: 20px;
  background: #f0f2f5;
  min-height: calc(100vh - 50px);
  margin-left: 200px;
}

/* 过渡动画 */
.fade-transform-enter-active,
.fade-transform-leave-active {
  transition: all .5s;
}

.fade-transform-enter-from {
  opacity: 0;
  transform: translateX(-30px);
}

.fade-transform-leave-to {
  opacity: 0;
  transform: translateX(30px);
}
</style>