<template>
  <el-container class="layout-container">
    <!-- 侧边栏 -->
    <el-aside width="200px" class="sidebar-container">
      <div class="logo">
        <span>管理系统</span>
      </div>
      <div class="menu-container">
        <el-menu
          :default-active="currentRoute"
          class="el-menu-vertical"
          background-color="#304156"
          text-color="#bfcbd9"
          active-text-color="#409EFF"
          router
        >
          <el-menu-item index="/dashboard">
            <el-icon></el-icon>
            <span>首页</span>
          </el-menu-item>

          <el-menu-item index="/message">
            <el-icon><Message /></el-icon>
            <span>消息</span>
          </el-menu-item>

          <el-sub-menu v-if="isAdmin" index="user">
            <template #title>
              <el-icon></el-icon>
              <span>用户</span>
            </template>
            <el-menu-item index="/user-manage">
              <el-icon></el-icon>
              <span>用户管理</span>
            </el-menu-item>
          </el-sub-menu>

          <el-sub-menu v-if="isAdmin" index="client">
            <template #title>
              <el-icon></el-icon>
              <span>客户管理</span>
            </template>

            <el-menu-item index="/client-manage">
              <el-icon></el-icon>
              <span>所有客户</span>
            </el-menu-item>
            <el-menu-item :index="`/client-manage/${userInfo?.id}`">
              <el-icon></el-icon>
              <span>我的客户</span>
            </el-menu-item>
            <el-menu-item index="/client-value">
              <el-icon></el-icon>
              <span>客户价值分析</span>
            </el-menu-item>
          </el-sub-menu>

          <el-sub-menu v-else index="client">
            <template #title>
              <el-icon></el-icon>
              <span>客户管理</span>
            </template>
            <el-menu-item index="/client-manage">
              <el-icon></el-icon>
              <span>我的客户</span>
            </el-menu-item>
            <el-menu-item index="/client-value">
              <el-icon></el-icon>
              <span>客户价值分析</span>
            </el-menu-item>
          </el-sub-menu>

          <el-sub-menu v-if="isAdmin" index="order">
            <template #title>
              <el-icon></el-icon>
              <span>订单管理</span>
            </template>
            <el-menu-item index="/order-manage">
              <el-icon></el-icon>
              <span>所有订单</span>
            </el-menu-item>
            <el-menu-item index="/order-manage/pending">
              <el-icon></el-icon>
              <span>待检验订单</span>
            </el-menu-item>
            <el-menu-item :index="`/order-manage/${userInfo?.id}`">
              <el-icon></el-icon>
              <span>我的订单</span>
            </el-menu-item>
          </el-sub-menu>

          <el-sub-menu v-else index="order">
            <template #title>
              <el-icon></el-icon>
              <span>订单管理</span>
            </template>
            <el-menu-item index="/order-manage">
              <el-icon></el-icon>
              <span>我的订单</span>
            </el-menu-item>
          </el-sub-menu>

          <!-- <el-sub-menu v-if="isAdmin" index="contract">
            <template #title>
              <el-icon></el-icon>
              <span>合同管理</span>
            </template>
            <el-menu-item index="/contract-manage">
              <el-icon></el-icon>
              <span>所有合同</span>
            </el-menu-item>
            <el-menu-item index="/contract-manage/pending">
              <el-icon></el-icon>
              <span>待检验合同</span>
            </el-menu-item>
            <el-menu-item :index="`/contract-manage/${userInfo?.id}`">
              <el-icon></el-icon>
              <span>我的合同</span>
            </el-menu-item>
            <el-menu-item index="/contract-log">
              <el-icon><Timer /></el-icon>
              <span>合同日志</span>
            </el-menu-item>
          </el-sub-menu>

          <el-sub-menu v-else index="contract">
            <template #title>
              <el-icon></el-icon>
              <span>合同管理</span>
            </template>
            <el-menu-item :index="`/contract-manage/${userInfo?.id}`">
              <el-icon></el-icon>
              <span>我的合同</span>
            </el-menu-item>
            <el-menu-item index="/contract-log">
              <el-icon><Timer /></el-icon>
              <span>合同日志</span>
            </el-menu-item>
          </el-sub-menu> -->

          <el-sub-menu v-if="isAdmin" index="file">
            <template #title>
              <el-icon></el-icon>
              <span>文件列表</span>
            </template>
            <el-menu-item index="/file-manage">
              <el-icon></el-icon>
              <span>所有文件</span>
            </el-menu-item>
          </el-sub-menu>

          <el-sub-menu v-if="isAdmin" index="log">
            <template #title>
              <el-icon></el-icon>
              <span>日志管理</span>
            </template>
            <el-menu-item index="/log/order">
              <el-icon></el-icon>
              <span>订单日志</span>
            </el-menu-item>
          </el-sub-menu>

          <el-menu-item index="/profile">
            <el-icon></el-icon>
            <span>个人中心</span>
          </el-menu-item>

          <!-- 开发文档 -->
          <el-sub-menu v-if="isAdmin" index="docs">
            <template #title>
              <el-icon></el-icon>
              <span>开发文档</span>
            </template>
            <el-menu-item @click="openDoc('satoken')">
              <span>Sa-Token</span>
            </el-menu-item>
            <el-menu-item @click="openDoc('mybatis')">
              <span>MyBatis-Plus</span>
            </el-menu-item>
            <el-menu-item @click="openDoc('element')">
              <span>Element Plus</span>
            </el-menu-item>
            <el-menu-item @click="openDoc('vue')">
              <span>Vue3</span>
            </el-menu-item>
            <el-menu-item @click="openDoc('minio')">
              <span>MinIO</span>
            </el-menu-item>
          </el-sub-menu>

        </el-menu>
      </div>
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
import { User, Message, Timer } from '@element-plus/icons-vue'

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

    const DOC_URLS = {
      satoken: 'https://sa-token.cc/',
      mybatis: 'https://baomidou.com/getting-started/',
      element: 'https://element-plus.org/zh-CN/component/overview.html',
      vue: 'https://cn.vuejs.org/guide/introduction',
      minio: 'https://min.io/docs/minio/linux/developers/javascript/API.html'
    }

    const openDoc = (type: keyof typeof DOC_URLS) => {
      window.open(DOC_URLS[type], '_blank')
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
      openDoc,
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
  display: flex;
  flex-direction: column;
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
.logo img {
  width: 40px;
  height: 40px;
  margin-right: 10px;
}

.menu-container {
  flex: 1;
  overflow-y: auto;
}

/* 自定义滚动条样式 */
.menu-container::-webkit-scrollbar {
  width: 6px;
}

.menu-container::-webkit-scrollbar-thumb {
  background: #41485d;
  border-radius: 3px;
}

.menu-container::-webkit-scrollbar-track {
  background: #304156;
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