<template>
  <page-container>
    <div class="header-actions">
      <el-button @click="handleBack">返回</el-button>
      <div class="title">合同详情</div>
      <div class="right-actions">
        <el-button 
          v-if="['DRAFT', 'PENDING'].includes(contractInfo.status)"
          type="danger" 
          @click="handleCancel"
        >
          取消合同
        </el-button>
        <el-button 
          v-if="['DRAFT', 'REJECTED'].includes(contractInfo.status)"
          type="primary" 
          @click="handleSubmitApproval"
        >
          提交审批
        </el-button>
      </div>
    </div>

    <el-descriptions :column="2" border>
      <el-descriptions-item label="合同编号">
        {{ contractInfo.id }}
      </el-descriptions-item>
      <el-descriptions-item label="合同状态">
        <span 
          class="status-tag"
          :class="{
            'status-draft': contractInfo.status === 'DRAFT',
            'status-pending': contractInfo.status === 'PENDING',
            'status-approved': contractInfo.status === 'APPROVED',
            'status-rejected': contractInfo.status === 'REJECTED',
            'status-completed': contractInfo.status === 'COMPLETED',
            'status-cancelled': contractInfo.status === 'CANCELLED'
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
      <el-descriptions-item label="合同金额">
        {{ contractInfo.amount !== undefined && contractInfo.amount !== null ? 
          `¥${(contractInfo.amount / 100).toFixed(2)}` : '-' }}
      </el-descriptions-item>
      <el-descriptions-item label="创建时间">
        {{ contractInfo.createTime ? formatTime(contractInfo.createTime) : '-' }}
      </el-descriptions-item>
      <el-descriptions-item label="备注" :span="2">
        {{ contractInfo.remark || '-' }}
      </el-descriptions-item>
    </el-descriptions>

    <!-- 合同文件 -->
    <div class="file-section">
      <div class="section-header">
        <h3>合同文件</h3>
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

    <!-- 合同进度 -->
    <div class="section">
      <div class="section-header">
        <h3>合同进度</h3>
        <el-button 
          v-if="['APPROVED', 'COMPLETED'].includes(contractInfo.status)"
          type="primary" 
          @click="handleAddProgress"
        >
          添加进度
        </el-button>
      </div>

      <el-table :data="progressList" style="width: 100%">
        <el-table-column prop="title" label="进度标题" />
        <el-table-column prop="content" label="进度内容" />
        <el-table-column prop="percentage" label="完成度">
          <template #default="{ row }">
            {{ row.percentage }}%
          </template>
        </el-table-column>
        <el-table-column prop="createTime" label="创建时间">
          <template #default="{ row }">
            {{ formatTime(row.createTime) }}
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

    <!-- 上传文件对话框 -->
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
    <el-dialog v-model="progressDialogVisible" title="添加进度" width="500px">
      <el-form ref="progressFormRef" :model="progressForm" :rules="progressRules" label-width="100px">
        <el-form-item label="进度标题" prop="title">
          <el-input v-model="progressForm.title" />
        </el-form-item>
        <el-form-item label="进度内容" prop="content">
          <el-input v-model="progressForm.content" type="textarea" />
        </el-form-item>
        <el-form-item label="完成度" prop="percentage">
          <el-slider v-model="progressForm.percentage" :step="10" show-stops />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="progressDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="submitProgress">确认</el-button>
      </template>
    </el-dialog>
  </page-container>
</template>

<script lang="ts">
import { defineComponent, ref, onMounted, computed } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { ElMessage, ElMessageBox } from 'element-plus'
import type { UploadInstance } from 'element-plus'
import { contractApi } from '../../api/contract'
import { CONTRACT_STATUS_MAP } from '../../types'
import type { ContractInfo } from '../../types'
import { formatDateTime } from '../../utils/format'
import { useStore } from '../../hooks/useStore'

export default defineComponent({
  name: 'ContractDetail',
  setup() {
    // ... 其他代码保持类似,只需要将order相关的变量名和API调用改为contract即可
  }
})
</script>

<style scoped>
/* 样式部分基本保持不变 */
</style> 