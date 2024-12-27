<template>
  <page-container>
    <div class="header-actions">
      <el-button @click="handleBack">返回</el-button>
      <div class="title">订单详情</div>
      <div class="right-actions">
        <el-button 
          v-if="['DRAFT', 'PENDING'].includes(orderInfo.status)"
          type="danger" 
          @click="handleCancel"
        >
          取消订单
        </el-button>
        <el-button 
          v-if="['DRAFT', 'REJECTED'].includes(orderInfo.status)"
          type="primary" 
          @click="handleSubmitCheck"
        >
          提交检验
        </el-button>
        <el-button 
          v-if="orderInfo.status === 'APPROVED'"
          type="success" 
          @click="handleComplete"
        >
          完成订单
        </el-button>
      </div>
    </div>

    <el-descriptions :column="2" border>
      <el-descriptions-item label="订单编号">
        {{ orderInfo.orderNo }}
      </el-descriptions-item>
      <el-descriptions-item label="订单状态">
        <span 
          class="status-tag"
          :class="{
            'status-draft': orderInfo.status === 'DRAFT',
            'status-pending': orderInfo.status === 'PENDING',
            'status-approved': orderInfo.status === 'APPROVED',
            'status-rejected': orderInfo.status === 'REJECTED',
            'status-completed': orderInfo.status === 'COMPLETED',
            'status-cancelled': orderInfo.status === 'CANCELLED'
          }"
        >
          {{ orderInfo.status ? ORDER_STATUS_MAP[orderInfo.status] : '-' }}
        </span>
      </el-descriptions-item>
      <el-descriptions-item label="客户名称">
        <el-button 
          link 
          type="primary" 
          @click="handleClientClick(orderInfo.clientId)"
        >
          {{ orderInfo.clientName }}
        </el-button>
      </el-descriptions-item>
      <el-descriptions-item label="负责人">
        {{ orderInfo.userName }}
      </el-descriptions-item>
      <el-descriptions-item label="总金额">
        {{ orderInfo.totalAmount !== undefined && orderInfo.totalAmount !== null ? 
          `¥${(orderInfo.totalAmount / 100).toFixed(2)}` : '-' }}
      </el-descriptions-item>
      <el-descriptions-item label="创建时间">
        {{ orderInfo.createTime ? formatTime(orderInfo.createTime) : '-' }}
      </el-descriptions-item>
      <el-descriptions-item label="备注" :span="2">
        {{ orderInfo.remark || '-' }}
      </el-descriptions-item>
    </el-descriptions>

    <div class="file-section">
      <div class="section-header">
        <h3>订单文件</h3>
        <el-button type="primary" @click="handleUpload">添加文件</el-button>
      </div>

      <el-table :data="fileList" style="width: 100%">
        <el-table-column label="文件名称">
          <template #default="{ row }">
            {{ row.fileVo?.fileName }}
          </template>
        </el-table-column>
        <el-table-column label="上传时间">
          <template #default="{ row }">
            {{ formatTime(row.createTime) }}
          </template>
        </el-table-column>
        <el-table-column prop="remark" label="备注" />
        <el-table-column label="操作" width="200">
          <template #default="{ row }">
            <el-button link type="primary" @click="handleDownload(row.fileVo)">
              下载
            </el-button>
            <el-button link type="danger" @click="handleDeleteFile(row)">
              删除
            </el-button>
          </template>
        </el-table-column>
      </el-table>
    </div>

    <div class="order-items">
      <div class="section-header">
        <h3>订单明细</h3>
        <el-button 
          v-if="['DRAFT', 'REJECTED'].includes(orderInfo.status)"
          type="primary" 
          @click="handleAddItem"
        >
          添加明细
        </el-button>
      </div>

      <el-table :data="itemList" style="width: 100%">
        <el-table-column prop="productName" label="产品名称" />
        <el-table-column prop="quantity" label="数量" />
        <el-table-column label="单价">
          <template #default="{ row }">
            {{ (row.unitPrice / 100).toFixed(2) }}
          </template>
        </el-table-column>
        <el-table-column label="总价">
          <template #default="{ row }">
            {{ (row.totalPrice / 100).toFixed(2) }}
          </template>
        </el-table-column>
        <el-table-column prop="remark" label="备注" />
        <el-table-column 
          label="操作" 
          width="150"
          v-if="['DRAFT', 'REJECTED'].includes(orderInfo.status)"
        >
          <template #default="{ row }">
            <el-button link type="primary" @click="handleEditItem(row)">
              编辑
            </el-button>
            <el-button link type="danger" @click="handleDeleteItem(row)">
              删除
            </el-button>
          </template>
        </el-table-column>
      </el-table>
    </div>

    <el-dialog v-model="uploadDialogVisible" title="上传文件" width="500px">
      <el-form ref="uploadFormRef" :model="uploadForm" label-width="80px">
        <el-form-item label="文件" prop="file">
          <el-upload
            ref="uploadRef"
            :auto-upload="false"
            :limit="1"
            :action="''"
            :http-request="httpRequest"
            accept=".pdf,.doc,.docx,.xls,.xlsx"
            :on-change="handleFileChange"
          >
            <template #trigger>
              <el-button type="primary">选择文件</el-button>
            </template>
          </el-upload>
        </el-form-item>
        <el-form-item label="备注">
          <el-input v-model="uploadForm.remark" type="textarea" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="uploadDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="submitUpload">确认</el-button>
      </template>
    </el-dialog>

    <el-dialog v-model="itemDialogVisible" title="添加明细" width="500px">
      <el-form ref="itemFormRef" :model="itemForm" :rules="itemRules" label-width="100px">
        <el-form-item label="产品名称" prop="productName">
          <el-input v-model="itemForm.productName" />
        </el-form-item>
        <el-form-item label="数量" prop="quantity">
          <el-input-number v-model="itemForm.quantity" :min="1" />
        </el-form-item>
        <el-form-item label="单价" prop="unitPrice">
          <el-input-number 
            v-model="itemForm.unitPrice" 
            :min="0" 
            :precision="2" 
            :step="0.01"
          />
        </el-form-item>
        <el-form-item label="备注">
          <el-input v-model="itemForm.remark" type="textarea" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="itemDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="submitItem">确认</el-button>
      </template>
    </el-dialog>

    <el-dialog 
      v-model="editDialogVisible" 
      title="编辑明细" 
      width="500px"
    >
      <el-form 
        ref="editFormRef" 
        :model="editForm" 
        :rules="itemRules" 
        label-width="100px"
      >
        <el-form-item label="产品名称" prop="productName">
          <el-input v-model="editForm.productName" />
        </el-form-item>
        <el-form-item label="数量" prop="quantity">
          <el-input-number v-model="editForm.quantity" :min="1" />
        </el-form-item>
        <el-form-item label="单价" prop="unitPrice">
          <el-input-number 
            v-model="editForm.unitPrice" 
            :min="0" 
            :precision="2" 
            :step="0.01"
          />
        </el-form-item>
        <el-form-item label="备注">
          <el-input v-model="editForm.remark" type="textarea" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="editDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="submitEdit">确认</el-button>
      </template>
    </el-dialog>

    <!-- 审批记录 -->
    <div class="section">
      <div class="section-header">
        <h3>审批记录</h3>
      </div>

      <el-table :data="approvalList" style="width: 100%">
        <el-table-column prop="approverName" label="审批人" />
        <el-table-column prop="status" label="审批结果">
          <template #default="{ row }">
            <el-tag :type="row.status === 'PASS' ? 'success' : 'danger'">
              {{ row.status === 'PASS' ? '通过' : '不通过' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="comment" label="审批意见" />
        <el-table-column prop="createTime" label="审批时间">
          <template #default="{ row }">
            {{ formatTime(row.createTime) }}
          </template>
        </el-table-column>
      </el-table>
    </div>
  </page-container>
</template>

<script lang="ts">
import { defineComponent, ref, onMounted, computed } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { ElMessage, ElMessageBox } from 'element-plus'
import type { UploadInstance } from 'element-plus'
import { orderApi } from '../../api/order'
import { ORDER_STATUS_MAP } from '../../types'
import type { OrderInfo } from '../../types'
import { formatDateTime } from '../../utils/format'
import { useStore } from '../../hooks/useStore'

export default defineComponent({
  name: 'OrderDetail',
  setup() {
    const route = useRoute()
    const router = useRouter()
    const orderInfo = ref<Partial<OrderInfo>>({})

    const getOrderInfo = async () => {
      try {
        const res = await orderApi.getOrderDetail(Number(route.params.id))
        orderInfo.value = res.data
      } catch (error) {
        ElMessage.error('获取订单详情失败')
      }
    }

    const handleBack = () => {
      router.back()
    }

    const fileList = ref([])
    const uploadDialogVisible = ref(false)
    const uploadRef = ref<UploadInstance>()
    const uploadForm = ref({
      remark: ''
    })

    const getFileList = async () => {
      try {
        const res = await orderApi.getOrderFiles(Number(route.params.id))
        fileList.value = res.data
      } catch (error) {
        ElMessage.error('获取文件列表失败')
      }
    }

    const handleUpload = () => {
      uploadDialogVisible.value = true
      uploadForm.value.remark = ''
      if (uploadRef.value) {
        uploadRef.value.clearFiles()
      }
    }

    const fileData = ref<File>()
    
    const handleFileChange = (file: any) => {
      if (!file || !file.raw) {
        fileData.value = undefined
        return
      }
      fileData.value = file.raw
    }

    const submitUpload = async () => {
      if (!fileData.value) {
        ElMessage.warning('请选择文件')
        return
      }

      try {
        const formData = new FormData()
        formData.append('file', fileData.value)
        formData.append('remark', uploadForm.value.remark)
        await orderApi.uploadOrderFile(Number(route.params.id), formData)
        ElMessage.success('上传成功')
        uploadDialogVisible.value = false
        fileData.value = undefined
        uploadForm.value.remark = ''
        if (uploadRef.value) {
          uploadRef.value.clearFiles()
        }
        getFileList()
      } catch (error) {
        ElMessage.error('上传失败')
      }
    }

    const handleDeleteFile = async (file: any) => {
      try {
        await orderApi.deleteOrderFile(file.id)
        ElMessage.success('删除成功')
        getFileList()
      } catch (error) {
        ElMessage.error('删除失败')
      }
    }

    const httpRequest = (options: any): Promise<any> => {
      return Promise.resolve()
    }

    const handleDownload = (fileVo: any) => {
      if (fileVo?.url && fileVo?.fileName) {
        const link = document.createElement('a')
        link.href = fileVo.url
        link.download = fileVo.fileName
        document.body.appendChild(link)
        link.click()
        document.body.removeChild(link)
      }
    }

    const itemList = ref([])
    const itemDialogVisible = ref(false)
    const itemForm = ref({
      productName: '',
      quantity: 1,
      unitPrice: 0,
      remark: ''
    })
    const itemRules = {
      productName: [{ required: true, message: '请输入产品名称', trigger: 'blur' }],
      quantity: [{ required: true, message: '请输入数量', trigger: 'blur' }],
      unitPrice: [{ required: true, message: '请输入单价', trigger: 'blur' }]
    }

    const handleAddItem = () => {
      itemForm.value = {
        productName: '',
        quantity: 1,
        unitPrice: 0,
        remark: ''
      }
      itemDialogVisible.value = true
    }

    const submitItem = async () => {
      try {
        await orderApi.addOrderItem({
          orderId: Number(route.params.id),
          ...itemForm.value,
          unitPrice: Math.round(itemForm.value.unitPrice * 100)
        })
        ElMessage.success('添加成功')
        itemDialogVisible.value = false
        await Promise.all([getItemList(), getOrderInfo()])
      } catch (error) {
        ElMessage.error('添加失败')
      }
    }

    const handleDeleteItem = async (item: any) => {
      try {
        await orderApi.deleteOrderItem(item.id)
        ElMessage.success('删除成功')
        await Promise.all([getItemList(), getOrderInfo()])
      } catch (error) {
        ElMessage.error('删除失败')
      }
    }

    const getItemList = async () => {
      try {
        const res = await orderApi.getOrderItems(Number(route.params.id))
        itemList.value = res.data
      } catch (error) {
        ElMessage.error('获取订单明细失败')
      }
    }

    const handleSubmitCheck = async () => {
      try {
        await orderApi.submitCheck(Number(route.params.id))
        ElMessage.success('提交成功')
        await getOrderInfo()
      } catch (error) {
        ElMessage.error('提交失败')
      }
    }

    const editDialogVisible = ref(false)
    const editForm = ref({
      id: 0,
      productName: '',
      quantity: 1,
      unitPrice: 0,
      remark: ''
    })

    const handleEditItem = (item: any) => {
      editForm.value = {
        id: item.id,
        productName: item.productName,
        quantity: item.quantity,
        unitPrice: item.unitPrice / 100,
        remark: item.remark || ''
      }
      editDialogVisible.value = true
    }

    const submitEdit = async () => {
      try {
        await orderApi.updateOrderItem({
          id: editForm.value.id,
          orderId: Number(route.params.id),
          productName: editForm.value.productName,
          quantity: editForm.value.quantity,
          unitPrice: Math.round(editForm.value.unitPrice * 100),
          remark: editForm.value.remark
        })
        ElMessage.success('更新成功')
        editDialogVisible.value = false
        await Promise.all([getItemList(), getOrderInfo()])
      } catch (error) {
        ElMessage.error('更新失败')
      }
    }

    const handleCancel = async () => {
      try {
        await ElMessageBox.confirm(
          '确定要取消该订单吗？',
          '提示',
          {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning'
          }
        )
        
        await orderApi.cancelOrder(Number(route.params.id))
        ElMessage.success('订单已取消')
        await getOrderInfo()
      } catch (error) {
        if (error !== 'cancel') {
          ElMessage.error('取消订单失败')
        }
      }
    }

    const store = useStore()
    const isAdmin = computed(() => store.userInfo.value?.role?.includes('admin'))

    const handleClientClick = (clientId: number) => {
      router.push(`/client/${clientId}`)
    }

    const approvalList = ref([])

    const getApprovalList = async () => {
      try {
        const res = await orderApi.getOrderApprovals(Number(route.params.id))
        approvalList.value = res.data
      } catch (error) {
        ElMessage.error('获取审批记录失败')
      }
    }

    const handleComplete = async () => {
      try {
        await orderApi.completeOrder(Number(route.params.id))
        ElMessage.success('订单已完成')
        getOrderInfo()
      } catch (error) {
        ElMessage.error('操作失败')
      }
    }

    onMounted(() => {
      getOrderInfo()
      getFileList()
      getItemList()
      getApprovalList()
    })

    return {
      orderInfo,
      ORDER_STATUS_MAP,
      handleBack,
      formatTime: formatDateTime,
      fileList,
      uploadDialogVisible,
      uploadRef,
      uploadForm,
      handleUpload,
      submitUpload,
      handleDeleteFile,
      handleFileChange,
      httpRequest,
      handleDownload,
      itemList,
      itemDialogVisible,
      itemForm,
      itemRules,
      handleAddItem,
      submitItem,
      handleDeleteItem,
      handleSubmitCheck,
      editDialogVisible,
      editForm,
      handleEditItem,
      submitEdit,
      handleCancel,
      isAdmin,
      handleClientClick,
      approvalList,
      handleComplete
    }
  }
})
</script>

<style scoped>
.header-actions {
  display: flex;
  align-items: center;
  margin-bottom: 20px;
  justify-content: space-between;
}

.title {
  font-size: 18px;
  font-weight: bold;
}

.right-actions {
  display: flex;
  gap: 10px;
}

.file-section {
  margin-top: 20px;
}

.section-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 16px;
}

.section-header h3 {
  margin: 0;
}

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
</style> 