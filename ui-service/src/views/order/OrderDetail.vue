<template>
  <page-container>
    <div class="header-actions">
      <el-button @click="handleBack">返回</el-button>
      <div class="title">订单详情</div>
    </div>

    <el-descriptions :column="2" border>
      <el-descriptions-item label="订单编号">
        {{ orderInfo.orderNo }}
      </el-descriptions-item>
      <el-descriptions-item label="订单状态">
        {{ orderInfo.status ? ORDER_STATUS_MAP[orderInfo.status] : '-' }}
      </el-descriptions-item>
      <el-descriptions-item label="客户名称">
        {{ orderInfo.clientName }}
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
  </page-container>
</template>

<script lang="ts">
import { defineComponent, ref, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import type { UploadInstance } from 'element-plus'
import { orderApi } from '../../api/order'
import { ORDER_STATUS_MAP } from '../../types'
import type { OrderInfo } from '../../types'
import { formatDateTime } from '../../utils/format'

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

    const fileData = ref<any>(null)

    const handleFileChange = (file: any) => {
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
      if (fileVo?.url) {
        const link = document.createElement('a')
        link.href = fileVo.url
        link.download = fileVo.fileName
        document.body.appendChild(link)
        link.click()
        document.body.removeChild(link)
      }
    }

    onMounted(() => {
      getOrderInfo()
      getFileList()
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
      handleDownload
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
</style> 