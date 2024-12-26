<template>
  <page-container>
    <div class="header-actions">
      <el-button @click="handleBack">返回</el-button>
      <div class="title">创建合同</div>
    </div>

    <el-form
      ref="formRef"
      :model="form"
      :rules="rules"
      label-width="100px"
      class="contract-form"
    >
      <el-form-item label="订单编号">
        <el-input v-model="orderInfo.orderNo" disabled />
      </el-form-item>
      <el-form-item label="客户名称">
        <el-input v-model="orderInfo.clientName" disabled />
      </el-form-item>
      <el-form-item label="订单金额">
        <el-input :value="formatAmount(orderInfo.totalAmount)" disabled />
      </el-form-item>
      <el-form-item label="合同金额" prop="amount">
        <el-input-number 
          v-model="form.amount"
          :min="0"
          :precision="2"
          :step="100"
          style="width: 200px"
        />
      </el-form-item>
      <el-form-item label="备注" prop="remark">
        <el-input
          v-model="form.remark"
          type="textarea"
          :rows="3"
          placeholder="请输入备注信息"
        />
      </el-form-item>
    </el-form>

    <div class="form-actions">
      <el-button type="primary" @click="handleSubmit">保存</el-button>
    </div>
  </page-container>
</template>

<script lang="ts">
import { defineComponent, ref, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import type { FormInstance } from 'element-plus'
import { contractApi } from '../../api/contract'
import { orderApi } from '../../api/order'
import type { OrderInfo } from '../../types'

export default defineComponent({
  name: 'CreateContract',
  setup() {
    const route = useRoute()
    const router = useRouter()
    const formRef = ref<FormInstance>()
    const orderInfo = ref<Partial<OrderInfo>>({})

    const form = ref({
      orderId: Number(route.params.orderId),
      amount: 0,
      remark: ''
    })

    const rules = {
      amount: [
        { required: true, message: '请输入合同金额', trigger: 'blur' },
        { type: 'number', min: 0, message: '金额必须大于0', trigger: 'blur' }
      ],
      remark: [{ max: 500, message: '备注最多500字符', trigger: 'blur' }]
    }

    // 获取订单信息
    const getOrderInfo = async () => {
      try {
        const res = await orderApi.getOrderDetail(form.value.orderId)
        orderInfo.value = res.data
        // 默认使用订单金额作为合同金额
        form.value.amount = res.data.totalAmount ? res.data.totalAmount / 100 : 0
      } catch (error) {
        ElMessage.error('获取订单信息失败')
      }
    }

    // 格式化金额显示
    const formatAmount = (amount?: number) => {
      if (amount === undefined || amount === null) return '-'
      return `¥${(amount / 100).toFixed(2)}`
    }

    // 提交表单
    const handleSubmit = async () => {
      if (!formRef.value) return
      
      await formRef.value.validate(async (valid) => {
        if (valid) {
          try {
            const res = await contractApi.createContract({
              orderId: form.value.orderId,
              amount: Math.round(form.value.amount * 100),
              remark: form.value.remark
            })
            ElMessage.success('创建成功')
            router.push(`/contract/${res.data}`)
          } catch (error) {
            if (error.response?.data?.message) {
              ElMessage.error(error.response.data.message)
            } else {
              ElMessage.error('创建失败')
            }
          }
        }
      })
    }

    // 返回
    const handleBack = () => {
      router.back()
    }

    onMounted(() => {
      getOrderInfo()
    })

    return {
      formRef,
      form,
      rules,
      orderInfo,
      formatAmount,
      handleSubmit,
      handleBack
    }
  }
})
</script>

<style scoped>
.header-actions {
  display: flex;
  align-items: center;
  margin-bottom: 20px;
}

.title {
  margin-left: 20px;
  font-size: 18px;
  font-weight: bold;
}

.contract-form {
  max-width: 600px;
}

.form-actions {
  margin-top: 20px;
  text-align: center;
}
</style>