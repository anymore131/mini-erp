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
    <el-row :gutter="20">
      <el-col :span="12">
        <el-card class="chart-card">
          <template #header>
            <div class="card-header">
              <span>近七日订单状态分布</span>
            </div>
          </template>
          <div ref="orderStatusChartRef" class="chart"></div>
        </el-card>
      </el-col>
      <el-col :span="12">
        <el-card class="chart-card">
          <template #header>
            <div class="card-header">
              <span>
                <el-icon><PieChart /></el-icon>
                客户价值分布
              </span>
            </div>
          </template>
          <div ref="valueChartRef" class="chart"></div>
        </el-card>
      </el-col>
    </el-row>
    <el-row :gutter="20" v-show="isAdmin">
      <el-col :span="24">
        <el-card class="chart-card">
          <template #header>
            <div class="card-header">
              <span>
                <el-icon><PieChart /></el-icon>
                所有客户价值分布
              </span>
            </div>
          </template>
          <div ref="valueAllChartRef" class="chart"></div>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script lang="ts">
import { defineComponent, ref, onMounted, computed, onBeforeUnmount } from 'vue'
import { User, Calendar, Briefcase, PieChart, TrendCharts, Refresh } from '@element-plus/icons-vue'
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
    TrendCharts,
    Refresh
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
    const levelChartRef = ref<HTMLElement>()
    let orderStatusChart: echarts.ECharts | null = null
    let levelChart: echarts.ECharts | null = null

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

    const valueChartRef = ref<HTMLElement>()
    let valueChart: echarts.ECharts | null = null

    const fetchCustomerValue = async () => {
      try {
        const res = await clientApi.getCustomerRfm(store.userInfo.value?.id)
        if (res.code === 200 && res.data) {
          initValueChart(res.data)
        }
      } catch (error) {
        console.error('获取客户价值分布失败:', error)
        ElMessage.error('获取客户价值分布失败')
      }
    }

    // 初始化客户价值图表
    const initValueChart = (data: Array<{
      clientId: number
      clientName: string
      frequency: number
      monetary: number
      tier: string
      churnRisk: number
    }>) => {
      if (!valueChartRef.value) return
      
      if (!valueChart) {
        valueChart = echarts.init(valueChartRef.value)
      }

      // 计算中位数作为分割线
      const frequencies = data.map(item => item.frequency)
      const monetaries = data.map(item => item.monetary)
      const medianFrequency = frequencies.length > 0 ? 
        [...frequencies].sort((a, b) => a - b)[Math.floor(frequencies.length / 2)] : 0
      const medianMonetary = monetaries.length > 0 ? 
        [...monetaries].sort((a, b) => a - b)[Math.floor(monetaries.length / 2)] : 0

      // 按客户等级分组颜色
      const tierColors: Record<string, string> = {
        '黄金': '#FFD700',
        '白银': '#C0C0C0',
        '青铜': '#CD7F32',
        '钻石': '#5F9EA0'
      }

      valueChart.setOption({
        tooltip: {
          trigger: 'item',
          formatter: (params: any) => {
            const data = params.data
            return `
              <div>客户名称: ${data.name}</div>
              <div>等级: ${data.tier}</div>
              <div>购买频率: ${data.frequency}</div>
              <div>消费金额: ${data.monetary.toFixed(2)}</div>
              <div>流失风险: ${(data.churnRisk * 100).toFixed(2)}%</div>
            `
          }
        },
        legend: {
          data: Object.keys(tierColors),
          right: 10,
          top: 20
        },
        xAxis: {
          name: '购买频率',
          nameLocation: 'middle',
          nameGap: 30,
          type: 'value',
          splitLine: {
            lineStyle: {
              type: 'dashed'
            }
          },
          axisLine: {
            onZero: false
          }
        },
        yAxis: {
          name: '消费金额',
          nameLocation: 'middle',
          nameGap: 30,
          type: 'value',
          splitLine: {
            lineStyle: {
              type: 'dashed'
            }
          },
          axisLine: {
            onZero: false
          }
        },
        visualMap: {
          show: false,
          dimension: 3, // 使用churnRisk作为视觉映射
          min: 0,
          max: 1,
          inRange: {
            opacity: [0.5, 1] // 流失风险越高，点越不透明
          }
        },
        series: [
          {
            type: 'scatter',
            symbolSize: (data: any) => Math.sqrt(data[2]) * 5 / 100, // 根据消费金额调整点大小
            data: data.map(item => ({
              name: item.clientName,
              value: [item.frequency, item.monetary, item.monetary, item.churnRisk],
              clientName: item.clientName,
              frequency: item.frequency,
              monetary: item.monetary,
              tier: item.tier,
              churnRisk: item.churnRisk
            })),
            itemStyle: {
              color: (params: any) => tierColors[params.data.tier] || '#000'
            },
            emphasis: {
              itemStyle: {
                shadowBlur: 10,
                shadowColor: 'rgba(0, 0, 0, 0.5)'
              }
            }
          },
          // 添加中位线
          {
            type: 'line',
            markLine: {
              silent: true,
              symbol: 'none',
              lineStyle: {
                color: '#333',
                width: 1
              },
              data: [
                {
                  xAxis: medianFrequency,
                  label: {
                    formatter: '频率中位线',
                    position: 'start'
                  }
                },
                {
                  yAxis: medianMonetary,
                  label: {
                    formatter: '金额中位线',
                    position: 'start'
                  }
                }
              ]
            }
          }
        ],
        graphic: [
          // 添加四象限标签
          {
            type: 'text',
            left: '10%',
            top: '10%',
            style: {
              text: '流量型客户',
              fill: '#333',
              fontSize: 14
            }
          },
          {
            type: 'text',
            left: '60%',
            top: '10%',
            style: {
              text: '高价值客户',
              fill: '#333',
              fontSize: 14
            }
          },
          {
            type: 'text',
            left: '10%',
            top: '60%',
            style: {
              text: '低价值客户',
              fill: '#333',
              fontSize: 14
            }
          },
          {
            type: 'text',
            left: '60%',
            top: '60%',
            style: {
              text: '潜力型客户',
              fill: '#333',
              fontSize: 14
            }
          }
        ]
      })

      valueChart.on('click', function(params) {
        if (params.data && params.data.name) {
          try {
              navigator.clipboard.writeText(params.data.name);
              ElMessage.success('客户名已复制到剪贴板');
          } catch (err) {
              console.error('无法复制文本: ', err);
              ElMessage.error('复制客户名失败');
          }
        }
      });
    }

    const valueAllChartRef = ref<HTMLElement>()
    let valueAllChart: echarts.ECharts | null = null

    const fetchCustomerAllValue = async () => {
      try {
        const res = await clientApi.getCustomerRfmAll()
        if (res.code === 200 && res.data) {
          initAllValueChart(res.data)
        }
      } catch (error) {
        console.error('获取客户价值分布失败:', error)
        ElMessage.error('获取客户价值分布失败')
      }
    }

    // 初始化客户价值图表
    const initAllValueChart = (data: Array<{
      clientId: number
      clientName: string
      frequency: number
      monetary: number
      cluster: number
      tier: string
      churnRisk: number
    }>) => {
      if (!valueAllChartRef.value) return
      
      if (!valueAllChart) {
        valueAllChart = echarts.init(valueAllChartRef.value)
      }

      // 计算中位数作为分割线
      const frequencies = data.map(item => item.frequency)
      const monetaries = data.map(item => item.monetary)
      const medianFrequency = frequencies.length > 0 ? 
        [...frequencies].sort((a, b) => a - b)[Math.floor(frequencies.length / 2)] : 0
      const medianMonetary = monetaries.length > 0 ? 
        [...monetaries].sort((a, b) => a - b)[Math.floor(monetaries.length / 2)] : 0

      // 按客户等级分组颜色
      const tierColors: Record<number, string> = {
        '2' : '#FFD700',
        '1' : '#C0C0C0',
        '0': '#CD7F32',
        '3': '#5F9EA0'
      }

      valueAllChart.setOption({
        tooltip: {
          trigger: 'item',
          formatter: (params: any) => {
            const data = params.data
            return `
              <div>客户: ${data.clientName}</div>
              <div>等级: ${data.tier}</div>
              <div>购买频率: ${data.frequency}</div>
              <div>消费金额: ${data.monetary.toFixed(2)}</div>
              <div>流失风险: ${(data.churnRisk * 100).toFixed(2)}%</div>
            `
          }
        },
        legend: {
          data: Object.keys(tierColors),
          right: 10,
          top: 20
        },
        xAxis: {
          name: '购买频率',
          nameLocation: 'middle',
          nameGap: 30,
          type: 'value',
          splitLine: {
            lineStyle: {
              type: 'dashed'
            }
          },
          axisLine: {
            onZero: false
          }
        },
        yAxis: {
          name: '消费金额',
          nameLocation: 'middle',
          nameGap: 30,
          type: 'value',
          splitLine: {
            lineStyle: {
              type: 'dashed'
            }
          },
          axisLine: {
            onZero: false
          }
        },
        visualMap: {
          show: false,
          dimension: 3, // 使用churnRisk作为视觉映射
          min: 0,
          max: 1,
          inRange: {
            opacity: [0.5, 1] // 流失风险越高，点越不透明
          }
        },
        series: [
          {
            type: 'scatter',
            symbolSize: (data: any) => Math.sqrt(data[2]) * 5 / 100, // 根据消费金额调整点大小
            data: data.map(item => ({
              name: item.clientName,
              value: [item.frequency, item.monetary, item.monetary, item.churnRisk],
              clientName: item.clientName,
              frequency: item.frequency,
              monetary: item.monetary,
              cluster: item.cluster,
              tier: item.tier,
              churnRisk: item.churnRisk
            })),
            itemStyle: {
              color: (params: any) => tierColors[params.data.cluster] || '#000'
            },
            emphasis: {
              itemStyle: {
                shadowBlur: 10,
                shadowColor: 'rgba(0, 0, 0, 0.5)'
              }
            }
          },
          // 添加中位线
          {
            type: 'line',
            markLine: {
              silent: true,
              symbol: 'none',
              lineStyle: {
                color: '#333',
                width: 1
              },
              data: [
                {
                  xAxis: medianFrequency,
                  label: {
                    formatter: '频率中位线',
                    position: 'start'
                  }
                },
                {
                  yAxis: medianMonetary,
                  label: {
                    formatter: '金额中位线',
                    position: 'start'
                  }
                }
              ]
            }
          }
        ],
        graphic: [
          // 添加四象限标签
          {
            type: 'text',
            left: '10%',
            top: '10%',
            style: {
              text: '流量型客户',
              fill: '#333',
              fontSize: 14
            }
          },
          {
            type: 'text',
            left: '60%',
            top: '10%',
            style: {
              text: '高价值客户',
              fill: '#333',
              fontSize: 14
            }
          },
          {
            type: 'text',
            left: '10%',
            top: '60%',
            style: {
              text: '低价值客户',
              fill: '#333',
              fontSize: 14
            }
          },
          {
            type: 'text',
            left: '60%',
            top: '60%',
            style: {
              text: '潜力型客户',
              fill: '#333',
              fontSize: 14
            }
          }
        ]
      })

      valueAllChart.on('click', function(params) {
        if (params.data && params.data.name) {
          try {
              navigator.clipboard.writeText(params.data.name);
              ElMessage.success('客户名已复制到剪贴板');
          } catch (err) {
              console.error('无法复制文本: ', err);
              ElMessage.error('复制客户名失败');
          }
        }
      });
    }

    onMounted(() => {
      loading.value = true
      Promise.all([
        fetchUserCount(),
        fetchClientCount(),
        fetchStatusDistribution(),
        fetchOrderTrend(),
        fetchCustomerValue(),
      ]).finally(() => {
        loading.value = false
      })

      if  (store.isAdmin.value == true) {
        Promise.all([
          fetchCustomerAllValue(),
        ]).finally(() => {
          loading.value = false
        })
      }

      fetchOrderStatusDistribution().finally(() => {
        loading.value = false
      })

      window.addEventListener('resize', handleResize)
    })

    const handleResize = () => {
      orderStatusChart?.resize()
      if  (store.isAdmin.value == true) {
        valueAllChart?.resize()
      }
      valueChart?.resize()
      levelChart?.resize()
    }

    onBeforeUnmount(() => {
      window.removeEventListener('resize', handleResize)
      orderStatusChart?.dispose()
      if  (store.isAdmin.value == true) {
        valueAllChart?.resize()
      }
      valueChart?.dispose()
      levelChart?.dispose()
    })

    return {
      store,
      isAdmin : store.isAdmin.value,
      userCount,
      clientCount,
      currentDate,
      loading,
      statusChartRef,
      trendChartRef,
      orderStatusChartRef,
      levelChartRef,
      valueChartRef,
      valueAllChartRef
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