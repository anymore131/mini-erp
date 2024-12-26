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
        class="order-form"
    >
      <el-form-item label="客户名称">
        <el-input v-model="clientName" disabled />
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
import { orderApi } from '../../api/order'
import { clientApi } from '../../api/client'
import { useStore } from '../../hooks/useStore'
import {contractApi} from "@/api/contract.ts";

export default defineComponent({
  name: 'CreateContract',
  setup() {
    const route = useRoute()
    const router = useRouter()
    const store = useStore()
    const formRef = ref<FormInstance>()
    const clientName = ref('')

    const form = ref({
      clientId: Number(route.params.clientId),
      number: '',
      userId: store.userInfo.value?.id,
      remark: '',
      totalAmount: 0
    })
    const rules = {
      remark: [{ max: 500, message: '备注最多500字符', trigger: 'blur' }]
    }

    // 获取客户信息
    const getClientInfo = async () => {
      try {
        const res = await clientApi.getClientDetail(form.value.clientId)
        if (res.code === 200 && res.data) {
          clientName.value = res.data.name
        }
      } catch (error) {
        ElMessage.error('获取客户信息失败')
      }
    }

    // 提交表单
    const handleSubmit = async () => {
      if (!formRef.value) return
      if (!form.value.userId) {
        ElMessage.error('用户ID不能为空')
        return
      }

      await formRef.value.validate(async (valid) => {
        if (valid) {
          try {
            const res = await contractApi.createContract({
              content: form.value.remark,
              number: '',
               totalAmount: 0,
              clientId: form.value.clientId,
              userId: form.value.userId,
              content: form.value.remark
            })
            ElMessage.success('创建成功')
            router.push(`/order/${res.data}`)
          } catch (error) {
            ElMessage.error('创建失败')
          }
        }
      })
    }

    // 返回
    const handleBack = () => {
      router.back()
    }

    onMounted(() => {
      getClientInfo()
    })

    return {
      formRef,
      form,
      rules,
      clientName,
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

.order-form {
  max-width: 600px;
}

.form-actions {
  margin-top: 20px;
  text-align: center;
}
</style>