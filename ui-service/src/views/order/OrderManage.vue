<template>
  <div class="order-manage">
    <page-loading :loading="loading" text="加载订单数据..." />
    
    <!-- 搜索表单 -->
    <el-form :inline="true" class="search-form">
      <el-form-item label="订单编号">
        <el-input
          v-model="searchForm.orderNo"
          placeholder="请输入订单编号"
          clearable
          @clear="handleSearch"
        />
      </el-form-item>
      <el-form-item label="状态">
        <el-select
          v-model="searchForm.status"
          placeholder="请选择状态"
          clearable
          @clear="handleSearch"
          style="width: 160px"
        >
          <el-option
            v-for="[key, value] in Object.entries(ORDER_STATUS_MAP)"
            :key="key"
            :label="value"
            :value="key"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="金额范围">
        <el-input-number
          v-model="searchForm.minAmount"
          :min="0"
          :precision="2"
          :step="100"
          placeholder="最小金额"
          style="width: 130px"
        />
        <span class="mx-2">-</span>
        <el-input-number
          v-model="searchForm.maxAmount"
          :min="0"
          :precision="2"
          :step="100"
          placeholder="最大金额"
          style="width: 130px"
        />
      </el-form-item>
      <el-form-item label="创建时间">
        <el-date-picker
        v-model="value2"
        type="datetimerange"
        start-placeholder="Start date"
        end-placeholder="End date"
        format="YYYY-MM-DD HH:mm:ss"
        value-format="YYYY-MM-DD HH:mm:ss"
        time-format="HH:mm:ss"
      />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="handleSearch">查询</el-button>
      </el-form-item>
    </el-form>

    <!-- 订单列表 -->
    <el-table
      :data="orderList"
      :loading="loading"
      @sort-change="handleSortChange"
      style="width: 100%; margin-top: 20px"
    >
      <el-table-column 
        prop="orderNo" 
        label="订单编号"
        sortable="custom"
      >
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
      <el-table-column prop="clientName" label="客户名称">
        <template #default="{ row }">
          <el-button 
            link 
            type="primary" 
            @click="handleClientClick(row.clientId)"
          >
            {{ row.clientName }}
          </el-button>
        </template>
      </el-table-column>
      <el-table-column prop="userName" label="负责人" />
      <el-table-column 
        prop="totalAmount" 
        label="总金额"
        sortable="custom"
      >
        <template #default="{ row }">
          {{ (row.totalAmount / 100).toFixed(2) }}
        </template>
      </el-table-column>
      <el-table-column 
        prop="createTime" 
        label="创建时间"
        sortable="custom"
      >
        <template #default="{ row }">
          {{ formatTime(row.createTime) }}
        </template>
      </el-table-column>
      <el-table-column 
        prop="updateTime" 
        label="修改时间"
        sortable="custom"
      >
        <template #default="{ row }">
          {{ formatTime(row.updateTime) }}
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
      <el-table-column label="操作" width="200">
        <template #default="{ row }">
          <el-button 
            link 
            type="primary" 
            @click="handleOrderClick(row.id)"
          >
            查看
          </el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 分页 -->
    <el-pagination
      v-model:current-page="pagination.pageNum"
      v-model:page-size="pagination.pageSize"
      :total="pagination.total"
      :page-sizes="[10, 20, 50, 100]"
      layout="total, sizes, prev, pager, next"
      @size-change="handleSizeChange"
      @current-change="handleCurrentChange"
      class="pagination"
    />
  </div>
</template>

<script lang="ts">
import { defineComponent, ref, reactive, onMounted, watch } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { ElMessage } from 'element-plus'
import { orderApi } from '../../api/order'
import { ORDER_STATUS_MAP } from '../../types'
import type { OrderInfo } from '../../types'
import { formatDateTime } from '../../utils/format'
import { useStore } from '../../hooks/useStore'

export default defineComponent({
  name: 'OrderManage',
  setup() {
    const store = useStore()
    const router = useRouter()
    const route = useRoute()
    const loading = ref(false)
    const orderList = ref<OrderInfo[]>([])

    const pagination = reactive({
      pageNum: 1,
      pageSize: 10,
      total: 0
    })

    const searchForm = reactive({
      orderNo: undefined as string | undefined,
      status: undefined as string | undefined,
      userId: route.params.userId ? Number(route.params.userId) : 
              (store.isAdmin.value ? undefined : store.userInfo.value?.id),
      minAmount: undefined as number | undefined,
      maxAmount: undefined as number | undefined,
      timeRange: undefined as any,
      updateTimeRange: undefined as any,
      startTime: undefined as string | undefined,
      endTime: undefined as string | undefined,
      startUpdateTime: undefined as string | undefined,
      endUpdateTime: undefined as string | undefined,
      sortBy: undefined as string | undefined,
      asc: true
    })

    const value2 = ref()

    // 监听路由参数变化
    watch(
      () => route.params.userId,
      () => {
        searchForm.userId = route.params.userId ? Number(route.params.userId) : 
                           (store.isAdmin.value ? undefined : store.userInfo.value?.id)
        fetchOrderList()
      }
    )

    // 获取订单列表
    const fetchOrderList = async () => {
      loading.value = true
      try {
        const params = {
          ...pagination,
          ...(searchForm.orderNo ? { orderNo: searchForm.orderNo } : {}),
          ...(searchForm.status ? { status: searchForm.status } : {}),
          ...(route.path === '/order-manage/pending' ? { status: 'PENDING' } : {}),
          ...(route.params.userId ? { userId: Number(route.params.userId) } : {}),
          ...(!store.userInfo.value?.role?.includes('admin') ? { userId: store.userInfo.value?.id } : {}),
          ...(searchForm.minAmount ? { minAmount: Math.round(searchForm.minAmount * 100) } : {}),
          ...(searchForm.maxAmount ? { maxAmount: Math.round(searchForm.maxAmount * 100) } : {}),
          ...(value2.value?.[0] ? { createTime: value2.value[0] } : {}),
          ...(value2.value?.[1] ? { updateTime: value2.value[1] } : {}),
          ...(searchForm.sortBy ? { 
            sortBy: searchForm.sortBy,
            asc: searchForm.asc 
          } : {})
        }
        const res = await orderApi.getOrders(params)
        orderList.value = res.data.list
        pagination.total = res.data.total
      } catch (error) {
        console.error('获取订单列表失败:', error)
        ElMessage.error('获取订单列表失败')
      } finally {
        loading.value = false
      }
    }

    // 处理搜索
    const handleSearch = () => {
      pagination.pageNum = 1
      fetchOrderList()
    }

    // 处理页码变化
    const handleCurrentChange = (page: number) => {
      pagination.pageNum = page
      fetchOrderList()
    }

    // 处理每页条数变化
    const handleSizeChange = (size: number) => {
      pagination.pageSize = size
      fetchOrderList()
    }

    // 点击订单编号跳转到详情页
    const handleOrderClick = (id: number) => {
      router.push(`/order/${id}`)
    }

    const handleTimeRangeChange = (val: any) => {
      if (val && val.length === 2) {
        searchForm.startTime = val[0]
        searchForm.endTime = val[1]
      } else {
        searchForm.startTime = undefined
        searchForm.endTime = undefined
      }
    }

    const handleUpdateTimeRangeChange = (val: any) => {
      if (val && val.length === 2) {
        searchForm.startUpdateTime = val[0]
        searchForm.endUpdateTime = val[1]
      } else {
        searchForm.startUpdateTime = undefined
        searchForm.endUpdateTime = undefined
      }
    }

    const handleClientClick = (clientId: number) => {
      router.push(`/client/${clientId}`)
    }

    const handleSortChange = ({ prop, order }: { prop: string, order: string | null }) => {
      searchForm.sortBy = order ? prop.replace(/([A-Z])/g, '_$1').toLowerCase() : undefined
      searchForm.asc = order === 'ascending'
      fetchOrderList()
    }

    onMounted(() => {
      fetchOrderList()
    })

    return {
      loading,
      orderList,
      pagination,
      searchForm,
      ORDER_STATUS_MAP,
      handleSearch,
      handleCurrentChange,
      handleSizeChange,
      handleOrderClick,
      formatTime: formatDateTime,
      handleTimeRangeChange,
      handleUpdateTimeRangeChange,
      value2,
      handleClientClick,
      handleSortChange
    }
  }
})
</script>

<style scoped>
.order-manage {
  padding: 24px;
}

.search-form {
  margin-bottom: 20px;
}

.pagination {
  margin-top: 20px;
  text-align: right;
}

/* 添加状态标签样式 */
.status-tag {
  display: inline-block;
  padding: 2px 8px;
  border-radius: 4px;
  border: 1px solid transparent;
}

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

.mx-2 {
  margin: 0 8px;
}
</style> 