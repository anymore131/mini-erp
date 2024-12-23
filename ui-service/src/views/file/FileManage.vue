<template>
  <div class="file-manage">
    <page-loading :loading="loading" text="加载文件数据..." />
    
    <!-- 搜索表单 -->
    <el-form :inline="true" class="search-form">
      <div class="form-header">
        <div class="left">
          <el-form-item label="文件名">
            <el-input
              v-model="searchForm.fileName"
              placeholder="请输入文件名"
              clearable
              @clear="handleSearch"
            />
          </el-form-item>
          <el-form-item label="文件类型">
            <el-select
              v-model="searchForm.contentType"
              placeholder="请选择文件类型"
              clearable
              style="width: 150px"
            >
              <el-option label="图片" value="IMAGE" />
              <el-option label="文档" value="application" />
              <el-option label="音频" value="AUDIO" />
              <el-option label="视频" value="VIDEO" />
              <el-option label="其他" value="OTHER" />
            </el-select>
          </el-form-item>
          <el-form-item>
            <el-button type="primary" @click="handleSearch">查询</el-button>
          </el-form-item>
        </div>
        <div class="right">
          <el-button type="primary" @click="handleViewAll">
            <el-icon><View /></el-icon>查看所有文件
          </el-button>
        </div>
      </div>
    </el-form>
    
    <!-- 文件列表 -->
    <el-table
      :data="fileList"
      :loading="loading"
      style="width: 100%; margin-top: 20px"
      @sort-change="handleSortChange"
    >
      <el-table-column prop="fileName" label="文件名" min-width="200" show-overflow-tooltip sortable="custom" />
      <el-table-column prop="contentType" label="文件类型" width="150">
        <template #default="{ row }">
          {{ row.contentType.split('/')[1].toUpperCase() }}
        </template>
      </el-table-column>
      <el-table-column prop="createTime" label="上传时间" sortable="custom">
        <template #default="{ row }">
          {{ formatTime(row.createTime) }}
        </template>
      </el-table-column>
      <el-table-column label="操作" width="150">
        <template #default="{ row }">
          <el-button link type="primary" @click="handleDownload(row)">
            <el-icon><Download /></el-icon>下载
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

<script lang="ts" setup>
import { ref, reactive } from 'vue'
import { ElMessage } from 'element-plus'
import { Download, View } from '@element-plus/icons-vue'
import { formatDateTime } from '../../utils/format'
import { fileApi } from '../../api/file'
import type { FileInfo } from '../../types'

const loading = ref(false)
const fileList = ref<FileInfo[]>([])
const searchForm = reactive({
  fileName: undefined as string | undefined,
  contentType: undefined as string | undefined,
  sortBy: undefined as string | undefined,
  asc: undefined as boolean | undefined
})
const pagination = reactive({
  pageNum: 1,
  pageSize: 10,
  total: 0
})

const fetchFileList = async () => {
  loading.value = true
  try {
    const res = await fileApi.getFiles({
      ...pagination,
      ...searchForm
    })
    fileList.value = res.data.list
    pagination.total = res.data.total
  } catch (error) {
    ElMessage.error('获取文件列表失败')
  } finally {
    loading.value = false
  }
}

const handleSearch = () => {
  pagination.pageNum = 1
  fetchFileList()
}

const handleSortChange = ({ prop, order }: { prop: string, order: string | null }) => {
  searchForm.sortBy = order ? prop.replace(/([A-Z])/g, '_$1').toLowerCase() : undefined
  searchForm.asc = order === 'ascending'
  fetchFileList()
}

const handleCurrentChange = (page: number) => {
  pagination.pageNum = page
  fetchFileList()
}

const handleSizeChange = (size: number) => {
  pagination.pageSize = size
  fetchFileList()
}

const formatTime = (time: string) => formatDateTime(time)

const handleDownload = (file: FileInfo) => {
  // 创建一个隐藏的a标签来下载文件
  const link = document.createElement('a')
  link.href = file.url
  link.download = file.fileName
  document.body.appendChild(link)
  link.click()
  document.body.removeChild(link)
}

const handleViewAll = () => {
  window.open('http://47.99.150.135:9001/login', '_blank')
}

fetchFileList()
</script>

<style scoped>
.file-manage {
  padding: 24px;
}

.search-form {
  margin-bottom: 20px;
}

.form-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.left {
  display: flex;
  align-items: center;
}

.right {
  margin-right: 20px;
}

.pagination {
  margin-top: 20px;
  text-align: right;
}
</style> 