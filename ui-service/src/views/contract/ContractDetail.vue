<template>
  <page-container>
    <div class="header-actions">
      <el-button @click="handleBack">返回</el-button>
      <div class="title">合同详情</div>
      <div class="right-actions">
        <el-button 
          v-if="['draft'].includes(contractInfo.status)"
          type="danger" 
          @click="handleCancel"
        >
          取消合同
        </el-button>
        <el-button 
          v-if="['draft', 'rejected'].includes(contractInfo.status)"
          type="primary" 
          @click="handleSubmitCheck"
        >
          提交审核
        </el-button>
      </div>
    </div>

    <!-- 合同基本信息 -->
    <el-descriptions :column="2" border>
      <el-descriptions-item label="合同编号">
        {{ contractInfo.id }}
      </el-descriptions-item>
      <el-descriptions-item label="合同状态">
        <span 
          class="status-tag"
          :class="{
            'status-draft': contractInfo.status === 'draft',
            'status-pending': contractInfo.status === 'pending',
            'status-approved': contractInfo.status === 'approved',
            'status-rejected': contractInfo.status === 'rejected',
            'status-completed': contractInfo.status === 'completed',
            'status-cancelled': contractInfo.status === 'cancelled'
          }"
        >
          {{ contractInfo.status ? CONTRACT_STATUS_MAP[contractInfo.status] : '-' }}
        </span>
      </el-descriptions-item>
      <el-descriptions-item label="客户名称">
        <el-button 
          link 
          type="primary" 
          @click="handleClientClick(contractInfo.clientId)"
        >
          {{ contractInfo.clientName }}
        </el-button>
      </el-descriptions-item>
      <el-descriptions-item label="负责人">
        {{ contractInfo.userName }}
      </el-descriptions-item>
      <el-descriptions-item label="总金额">
        {{ contractInfo.totalAmount !== undefined ? `¥${contractInfo.totalAmount}` : '-' }}
      </el-descriptions-item>
      <el-descriptions-item label="创建时间">
        {{ contractInfo.createTime ? formatTime(contractInfo.createTime) : '-' }}
      </el-descriptions-item>
      <el-descriptions-item label="合同内容" :span="2">
        {{ contractInfo.content || '-' }}
      </el-descriptions-item>
    </el-descriptions>

    <!-- 合同文件 -->
    <div class="file-section">
      <div class="section-header">
        <h3>合同文件</h3>
        <el-button 
          v-if="['draft', 'rejected'].includes(contractInfo.status)"
          type="primary" 
          @click="handleUpload"
        >
          添加文件
        </el-button>
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
            <el-button 
              v-if="['draft', 'rejected'].includes(contractInfo.status)"
              link 
              type="danger" 
              @click="handleDeleteFile(row)"
            >
              删除
            </el-button>
          </template>
        </el-table-column>
      </el-table>
    </div>

    <!-- 审批记录 -->
    <div class="section">
      <div class="section-header">
        <h3>审批记录</h3>
      </div>

      <el-table :data="approvalList" style="width: 100%">
        <el-table-column prop="userName" label="审批人" />
        <el-table-column prop="status" label="审批结果">
          <template #default="{ row }">
            <el-tag :type="row.status === 1 ? 'success' : 'danger'">
              {{ row.status === 1 ? '通过' : '不通过' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="approvalOpinion" label="审批意见" />
        <el-table-column prop="createTime" label="审批时间">
          <template #default="{ row }">
            {{ formatTime(row.createTime) }}
          </template>
        </el-table-column>
      </el-table>
    </div>

    <!-- 合同进度 -->
    <div class="section">
      <div class="section-header">
        <h3>合同进度</h3>
        <el-button 
          v-if="['approved', 'completed'].includes(contractInfo.status)"
          type="primary" 
          @click="handleAddProgress"
        >
          更新进度
        </el-button>
      </div>

      <el-table :data="progressList" style="width: 100%">
        <el-table-column prop="progress" label="进度" width="120">
          <template #default="{ row }">
            {{ row.progress }}%
          </template>
        </el-table-column>
        <el-table-column prop="description" label="进度说明" />
        <el-table-column prop="createTime" label="更新时间" width="180">
          <template #default="{ row }">
            {{ formatTime(row.createTime) }}
          </template>
        </el-table-column>
        <el-table-column label="操作" width="150" v-if="isAdmin">
          <template #default="{ row }">
            <el-button link type="primary" @click="handleEditProgress(row)">
              编辑
            </el-button>
            <el-button link type="danger" @click="handleDeleteProgress(row)">
              删除
            </el-button>
          </template>
        </el-table-column>
      </el-table>
    </div>

    <!-- 文件上传对话框 -->
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

    <!-- 添加进度对话框 -->
    <el-dialog 
      v-model="progressDialogVisible" 
      :title="progressForm.id ? '编辑进度' : '添加进度'"
      width="500px"
    >
      <el-form 
        ref="progressFormRef"
        :model="progressForm"
        :rules="progressRules"
        label-width="100px"
      >
        <el-form-item label="完成进度" prop="progress">
          <el-input-number
            v-model="progressForm.progress"
            :min="0"
            :max="100"
            :step="10"
          />
          <span class="ml-2">%</span>
        </el-form-item>
        <el-form-item label="进度说明" prop="description">
          <el-input
            v-model="progressForm.description"
            type="textarea"
            :rows="3"
            placeholder="请输入进度说明"
          />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="progressDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="submitProgress">确定</el-button>
      </template>
    </el-dialog>
  </page-container>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import { contractApi } from '../../api/contract'
import type { ContractInfo } from '../../api/contract'
import ContractApproval from './ContractApproval.vue'

const route = useRoute()
const id = route.params.id
const contract = ref<ContractInfo>()

const CONTRACT_STATUS_MAP = {
  draft: '草稿',
  pending: '待审核',
  approved: '已通过',
  rejected: '已驳回',
  completed: '已完成',
  cancelled: '已取消'
}

// 获取合同详情
const getContract = async () => {
  try {
    const res = await contractApi.getContract(Number(id))
    contract.value = res.data
  } catch (error) {
    console.error(error)
  }
}

// 获取状态样式
const getStatusType = (status?: string) => {
  if (!status) return ''
  const map: Record<string, string> = {
    draft: 'info',
    pending: 'warning',
    approved: 'success',
    rejected: 'danger',
    completed: 'success',
    cancelled: 'info'
  }
  return map[status]
}

onMounted(() => {
  getContract()
})
</script> 