<template>
  <div class="pending-orders">
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
          start-placeholder="开始时间"
          end-placeholder="结束时间"
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
      style="width: 100%; margin-top: 20px"
    >
      <el-table-column prop="orderNo" label="订单编号">
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
      <el-table-column prop="totalAmount" label="总金额">
        <template #default="{ row }">
          {{ (row.totalAmount / 100).toFixed(2) }}
        </template>
      </el-table-column>
      <el-table-column prop="createTime" label="创建时间">
        <template #default="{ row }">
          {{ formatTime(row.createTime) }}
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
          <el-button 
            link 
            type="primary" 
            @click="handleApproval(row.id)"
          >
            审批
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
import { defineComponent, ref, reactive, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { orderApi } from '../../api/order'
import type { OrderInfo } from '../../types'
import { formatDateTime } from '../../utils/format'

export default defineComponent({
  name: 'PendingOrders',
  setup() {
    const router = useRouter()
    const loading = ref(false)
    const orderList = ref<OrderInfo[]>([])
    const value2 = ref()

    const pagination = reactive({
      pageNum: 1,
      pageSize: 10,
      total: 0
    })

    const searchForm = reactive({
      orderNo: undefined as string | undefined,
      minAmount: undefined as number | undefined,
      maxAmount: undefined as number | undefined
    })

    // 获取订单列表
    const fetchOrderList = async () => {
      loading.value = true
      try {
        const params = {
          ...pagination,
          status: 'PENDING',
          ...(searchForm.orderNo ? { orderNo: searchForm.orderNo } : {}),
          ...(searchForm.minAmount ? { minAmount: Math.round(searchForm.minAmount * 100) } : {}),
          ...(searchForm.maxAmount ? { maxAmount: Math.round(searchForm.maxAmount * 100) } : {}),
          ...(value2.value?.[0] ? { createTime: value2.value[0] } : {}),
          ...(value2.value?.[1] ? { updateTime: value2.value[1] } : {})
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

    // 通过审核
    const handleApprove = async (id: number) => {
      try {
        await orderApi.approveOrder(id)
        ElMessage.success('审核通过')
        fetchOrderList()
      } catch (error) {
        ElMessage.error('操作失败')
      }
    }

    // 拒绝审核
    const handleReject = async (id: number) => {
      try {
        await orderApi.rejectOrder(id)
        ElMessage.success('已拒绝')
        fetchOrderList()
      } catch (error) {
        ElMessage.error('操作失败')
      }
    }

    const handleApproval = (id: number) => {
      router.push(`/order/approval/${id}`)
    }

    const handleClientClick = (clientId: number) => {
      router.push(`/client/${clientId}`)
    }

    onMounted(() => {
      fetchOrderList()
    })

    return {
      loading,
      orderList,
      pagination,
      searchForm,
      value2,
      handleSearch,
      handleCurrentChange,
      handleSizeChange,
      handleOrderClick,
      handleApprove,
      handleReject,
      handleApproval,
      handleClientClick,
      formatTime: formatDateTime
    }
  }
})
</script>

<style scoped>
.pending-orders {
  padding: 24px;
}

.search-form {
  margin-bottom: 20px;
}

.pagination {
  margin-top: 20px;
  text-align: right;
}

.mx-2 {
  margin: 0 8px;
}
</style> 