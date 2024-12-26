<template>
  <div class="dashboard">
    <page-loading :loading="loading" text="加载数据..." />
    <el-row :gutter="20" class="data-cards">
      <el-col v-if="isAdmin" :span="8">
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

      <el-col v-if="isAdmin" :span="8">
        <el-card class="box-card">
          <template #header>
            <div class="card-header">
              <span>
                <el-icon><Briefcase /></el-icon>
                客户总数
              </span>
            </div>
          </template>
          <div class="card-value">{{ clientCount }}</div>
        </el-card>
      </el-col>
      
      <el-col v-if="!isAdmin" :span="8">
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
                最近7天订单趋势
              </span>
            </div>
          </template>
          <div ref="trendChartRef" class="chart"></div>
        </el-card>
      </el-col>
    </el-row>

    <!-- 订单状态分布图表 -->
    <el-card class="chart-card">
      <template #header>
        <div class="card-header">
          <span>近七日订单状态分布</span>
        </div>
      </template>
      <div ref="orderStatusChartRef" class="chart"></div>
    </el-card>
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
import { orderApi } from '../api/order'
import { ORDER_STATUS_MAP } from '../types'

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
      if (!store.isAdmin.value) {
        return
      }
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
        const response = await clientApi.getClientCount(
          store.isAdmin.value ? undefined : store.userInfo.value?.id
        )
        if (response.code === 200 && response.data) {
          clientCount.value = response.data
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
      try {
        const response = await clientApi.getClientStatusDistribution(
          store.isAdmin.value ? undefined : store.userInfo.value?.id
        )
        if (response.code === 200 && response.data) {
          initStatusChart(response.data)
        }
      } catch (error) {
        console.error('获取客户状态分布失败:', error)
        ElMessage.error('获取客户状态分布失败')
      }
    }

    // 初始化客户状态分布图表
    const initStatusChart = (data: Record<string, number>) => {
      if (!statusChartRef.value) return
      
      if (!statusChart) {
        statusChart = echarts.init(statusChartRef.value)
      }
      
      const chartData = Object.entries(data).map(([status, count]) => ({
        name: CLIENT_STATUS_MAP[status] || status,
        value: count
      }))
      
      statusChart.setOption({
        tooltip: {
          trigger: 'item',
          formatter: '{b}: {c} ({d}%)'
        },
        legend: {
          orient: 'vertical',
          right: 10,
          top: 'center'
        },
        series: [
          {
            type: 'pie',
            radius: ['40%', '70%'],
            avoidLabelOverlap: false,
            itemStyle: {
              borderRadius: 10,
              borderColor: '#fff',
              borderWidth: 2
            },
            label: {
              show: false
            },
            emphasis: {
              label: {
                show: true,
                fontSize: 16,
                fontWeight: 'bold'
              }
            },
            labelLine: {
              show: false
            },
            data: chartData
          }
        ]
      })
    }

    const orderStatusChartRef = ref<HTMLElement>()
    let orderStatusChart: echarts.ECharts | null = null

    // 获取订单状态分布数据
    const fetchOrderStatusDistribution = async () => {
      try {
        const res = store.isAdmin.value 
          ? await orderApi.getAllOrderStatusDistribution()
          : await orderApi.getOrderStatusDistribution(store.userInfo.value?.id!)

        if (res.code === 200 && res.data) {
          initOrderStatusChart(res.data)
        }
      } catch (error) {
        ElMessage.error('获取订单状态分布数据失败')
      }
    }

    // 初始化订单状态图表
    const initOrderStatusChart = (data: Record<string, number>) => {
      if (!orderStatusChartRef.value) return

      if (!orderStatusChart) {
        orderStatusChart = echarts.init(orderStatusChartRef.value)
      }

      const chartData = Object.entries(data).map(([status, count]) => ({
        name: ORDER_STATUS_MAP[status] || status,
        value: count
      }))

      orderStatusChart.setOption({
        tooltip: {
          trigger: 'item',
          formatter: '{b}: {c} ({d}%)'
        },
        legend: {
          orient: 'vertical',
          right: 10,
          top: 'center'
        },
        series: [
          {
            type: 'pie',
            radius: ['40%', '70%'],
            avoidLabelOverlap: false,
            itemStyle: {
              borderRadius: 10,
              borderColor: '#fff',
              borderWidth: 2
            },
            label: {
              show: false
            },
            emphasis: {
              label: {
                show: true,
                fontSize: 16,
                fontWeight: 'bold'
              }
            },
            labelLine: {
              show: false
            },
            data: chartData
          }
        ]
      })
    }

    // 处理窗口大小变化
    const handleResize = () => {
      statusChart?.resize()
      trendChart?.resize()
      orderStatusChart?.resize()
    }

    // 获取订单趋势数据
    const fetchOrderTrend = async () => {
      try {
        const res = await orderApi.getOrderTrend(
          store.isAdmin.value ? undefined : store.userInfo.value?.id
        )
        if (res.code === 200 && res.data) {
          initTrendChart(res.data)
        }
      } catch (error) {
        ElMessage.error('获取订单趋势数据失败')
      }
    }

    // 初始化趋势图表
    const initTrendChart = (data: { date: string; newCount: number; completedCount: number }[]) => {
      if (!trendChartRef.value) return
      
      if (!trendChart) {
        trendChart = echarts.init(trendChartRef.value)
      }

      const dates = data.map(item => item.date)
      const newOrders = data.map(item => item.newCount)
      const completedOrders = data.map(item => item.completedCount)
 
      trendChart.setOption({
        tooltip: {
          trigger: 'axis'
        },
        legend: {
          data: ['新增订单', '完成订单']
        },
        xAxis: {
          type: 'category',
          data: dates
        },
        yAxis: {
          type: 'value'
        },
        series: [
          {
            name: '新增订单',
            data: newOrders,
            type: 'line',
            smooth: true,
            areaStyle: {
              opacity: 0.3
            }
          },
          {
            name: '完成订单',
            data: completedOrders,
            type: 'line',
            smooth: true,
            areaStyle: {
              opacity: 0.3
            }
          }
        ]
      })
    }

    onMounted(() => {
      loading.value = true
      Promise.all([
        fetchUserCount(),
        fetchClientCount(),
        fetchStatusDistribution(),
        fetchOrderTrend()
      ]).finally(() => {
        loading.value = false
      })

      fetchOrderStatusDistribution().finally(() => {
        loading.value = false
      })

      window.addEventListener('resize', handleResize)
    })

    onBeforeUnmount(() => {
      window.removeEventListener('resize', handleResize)
      statusChart?.dispose()
      trendChart?.dispose()
      orderStatusChart?.dispose()
    })

    return {
      isAdmin : store.isAdmin.value,
      userCount,
      clientCount,
      currentDate,
      loading,
      statusChartRef,
      trendChartRef,
      orderStatusChartRef
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

.chart-card {
  margin-bottom: 20px;
}

.card-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.chart {
  height: 400px;
}
</style> 