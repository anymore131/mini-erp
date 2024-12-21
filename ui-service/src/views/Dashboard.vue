<template>
  <div class="dashboard">
    <page-loading :loading="loading" text="加载数据..." />
    <el-row :gutter="20" class="data-cards">
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
                <el-icon><Briefcase /></el-icon>
                我的客户数
              </span>
            </div>
          </template>
          <div class="card-value">{{ clientCount }}</div>
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

    <el-row :gutter="20" class="charts-container">
      <el-col :span="12">
        <el-card class="box-card">
          <template #header>
            <div class="card-header">
              <span>
                <el-icon><PieChart /></el-icon>
                客户状态分布
              </span>
            </div>
          </template>
          <div ref="statusChartRef" class="chart"></div>
        </el-card>
      </el-col>

      <el-col :span="12">
        <el-card class="box-card">
          <template #header>
            <div class="card-header">
              <span>
                <el-icon><TrendCharts /></el-icon>
                最近7天新增客户
              </span>
            </div>
          </template>
          <div ref="trendChartRef" class="chart"></div>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script lang="ts">
import { defineComponent, ref, onMounted, computed, onBeforeUnmount } from 'vue'
import { User, Calendar, Briefcase, PieChart, TrendCharts } from '@element-plus/icons-vue'
import { userApi } from '../api/user'
import { clientApi } from '../api/client'
import { ElMessage } from 'element-plus'
import PageLoading from '../components/PageLoading.vue'
import { useStore } from '../hooks/useStore'
import { CLIENT_STATUS_MAP } from '../types'
import * as echarts from 'echarts'

export default defineComponent({
  name: 'Dashboard',
  components: {
    User,
    Calendar,
    Briefcase,
    PageLoading,
    PieChart,
    TrendCharts
  },
  setup() {
    const store = useStore()
    const loading = ref(false)
    const userCount = ref(0)
    const clientCount = ref(0)
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
          asc: true
        })
        if (response.code === 200 && response.data) {
          userCount.value = response.data.total
        } else {
          throw new Error(response.msg || '获取用户总数失败')
        }
      } catch (error: any) {
        ElMessage.error(error.response?.data?.msg || error.message || '获取用户总数失败')
      } finally {
        loading.value = false
      }
    }

    const fetchClientCount = async () => {
      if (!store.userInfo.value?.id) return
      
      try {
        const response = await clientApi.getClients({
          pageNum: 1,
          pageSize: 1,
          userId: store.userInfo.value.id
        })
        if (response.code === 200 && response.data) {
          clientCount.value = response.data.total
        }
      } catch (error: any) {
        console.error('获取客户总数失败:', error)
        ElMessage.error('获取客户总数失败')
      }
    }

    const statusChartRef = ref<HTMLElement>()
    const trendChartRef = ref<HTMLElement>()
    let statusChart: echarts.ECharts | null = null
    let trendChart: echarts.ECharts | null = null

    const fetchStatusDistribution = async () => {
      if (!store.userInfo.value?.id) return
      
      try {
        const response = await clientApi.getClients({
          pageNum: 1,
          pageSize: 1000,
          userId: store.userInfo.value.id
        })
        if (response.code === 200 && response.data) {
          const statusCount: Record<string, number> = {
            '已添加': 0,
            '正在合作': 0,
            '未开展合作': 0
          }
          response.data.list.forEach(client => {
            const status = CLIENT_STATUS_MAP[client.status]
            if (status) statusCount[status]++
          })

          if (statusChart) {
            statusChart.setOption({
              series: [{
                data: Object.entries(statusCount).map(([name, value]) => ({ name, value }))
              }]
            })
          }
        }
      } catch (error) {
        console.error('获取客户状态分布失败:', error)
      }
    }

    const initCharts = () => {
      if (statusChartRef.value) {
        statusChart = echarts.init(statusChartRef.value)
        statusChart.setOption({
          tooltip: {
            trigger: 'item',
            formatter: '{b}: {c} ({d}%)'
          },
          legend: {
            orient: 'vertical',
            left: 'left'
          },
          series: [{
            type: 'pie',
            radius: '50%',
            data: [],
            emphasis: {
              itemStyle: {
                shadowBlur: 10,
                shadowOffsetX: 0,
                shadowColor: 'rgba(0, 0, 0, 0.5)'
              }
            }
          }]
        })
      }

      if (trendChartRef.value) {
        trendChart = echarts.init(trendChartRef.value)
        const dates = Array.from({ length: 7 }, (_, i) => {
          const date = new Date()
          date.setDate(date.getDate() - i)
          return date.toLocaleDateString('zh-CN', { month: 'short', day: 'numeric' })
        }).reverse()

        trendChart.setOption({
          tooltip: {
            trigger: 'axis'
          },
          xAxis: {
            type: 'category',
            data: dates
          },
          yAxis: {
            type: 'value'
          },
          series: [{
            data: [5, 7, 3, 9, 4, 6, 8],
            type: 'line',
            smooth: true,
            areaStyle: {}
          }]
        })
      }
    }

    const handleResize = () => {
      statusChart?.resize()
      trendChart?.resize()
    }

    onMounted(() => {
      loading.value = true
      Promise.all([
        fetchUserCount(),
        fetchClientCount(),
        fetchStatusDistribution()
      ]).finally(() => {
        loading.value = false
        initCharts()
      })

      window.addEventListener('resize', handleResize)
    })

    onBeforeUnmount(() => {
      window.removeEventListener('resize', handleResize)
      statusChart?.dispose()
      trendChart?.dispose()
    })

    return {
      userCount,
      clientCount,
      currentDate,
      loading,
      statusChartRef,
      trendChartRef
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

.charts-container {
  margin-top: 20px;
}

.chart {
  height: 300px;
}

.data-cards {
  margin-bottom: 20px;
}
</style> 