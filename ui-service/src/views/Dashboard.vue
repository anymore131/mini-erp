<template>
  <div class="dashboard">
    <page-loading :loading="loading" text="加载数据..." />
    <el-row :gutter="20">
      <el-col :span="8">
        <el-card class="box-card">
          <template #header>
            <div class="card-header">
              <span>
                <el-icon><User /></el-icon>
                用户总数
              </span>
            </div>
          </template>
          <div class="card-value">{{ userCount }}</div>
        </el-card>
      </el-col>
      
      <el-col :span="8">
        <el-card class="box-card">
          <template #header>
            <div class="card-header">
              <span>
                <el-icon><Calendar /></el-icon>
                今日日期
              </span>
            </div>
          </template>
          <div class="card-value">{{ currentDate }}</div>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script lang="ts">
import { defineComponent, ref, onMounted, computed } from 'vue'
import { User, Calendar } from '@element-plus/icons-vue'
import { userApi } from '../api/user'
import { ElMessage } from 'element-plus'
import PageLoading from '../components/PageLoading.vue'

export default defineComponent({
  name: 'Dashboard',
  components: {
    User,
    Calendar,
    PageLoading
  },
  setup() {
    const loading = ref(false)
    const userCount = ref(0)
    const currentDate = computed(() => {
      return new Date().toLocaleDateString('zh-CN', {
        year: 'numeric',
        month: 'long',
        day: 'numeric',
        weekday: 'long'
      })
    })

    const fetchUserCount = async () => {
      loading.value = true
      try {
        const response = await userApi.getUsers({ 
          pageNum: 1,
          pageSize: 1,
          sortBy: 'create_time',
          isAsc: true
        })
        console.log('用户列表响应:', response)
        if (response.code === 200 && response.data) {
          userCount.value = response.data.total
        } else {
          throw new Error(response.msg || '获取用户总数失败')
        }
      } catch (error: any) {
        console.error('获取用户总数失败:', error)
        ElMessage.error(error.response?.data?.msg || error.message || '获取用户总数失败')
      } finally {
        loading.value = false
      }
    }

    onMounted(() => {
      fetchUserCount()
    })

    return {
      userCount,
      currentDate,
      loading
    }
  }
})
</script>

<style scoped>
.dashboard {
  position: relative;
  min-height: 200px;
}

.box-card {
  margin-bottom: 20px;
}

.card-header {
  display: flex;
  align-items: center;
}

.card-header .el-icon {
  margin-right: 8px;
  font-size: 18px;
}

.card-value {
  font-size: 24px;
  font-weight: bold;
  color: #409EFF;
  text-align: center;
  padding: 20px 0;
}
</style> 