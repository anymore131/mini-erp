<template>
  <div class="client-manage">
    <!-- 搜索表单和操作按钮 -->
    <div class="header-actions">
      <el-form :inline="true" class="search-form">
        <el-form-item label="客户名称">
          <el-input
            v-model="searchForm.name"
            placeholder="请输入客户名称"
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
            style="width: 120px"
          >
            <el-option
              v-for="status in CLIENT_STATUS_OPTIONS"
              :key="status"
              :label="status"
              :value="status"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="最低交易额">
          <el-input-number
            v-model="searchForm.sum"
            :min="0"
            :precision="2"
            placeholder="最低交易额"
          />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleSearch">查询</el-button>
        </el-form-item>
      </el-form>
      <div class="right-buttons">
        <el-button type="primary" @click="handleAdd">添加客户</el-button>
        <el-button 
          v-if="$route.params.userId"
          type="warning" 
          @click="showChangeUserDialog"
        >
          修改负责人
        </el-button>
      </div>
    </div>

    <!-- 添加客户对话框 -->
    <el-dialog
      v-model="dialogVisible"
      title="添加客户"
      width="500px"
    >
      <el-form
        ref="formRef"
        :model="form"
        :rules="rules"
        label-width="100px"
      >
        <el-form-item label="客户名称" prop="name">
          <el-input v-model="form.name" />
        </el-form-item>
        <el-form-item label="联系电话" prop="mobile">
          <el-input v-model="form.mobile" />
        </el-form-item>
        <el-form-item label="电子邮箱" prop="email">
          <el-input v-model="form.email" />
        </el-form-item>
        <el-form-item label="联系地址" prop="address">
          <el-input v-model="form.address" />
        </el-form-item>
        <el-form-item label="备注" prop="remark">
          <el-input
            v-model="form.remark"
            type="textarea"
            :rows="3"
          />
        </el-form-item>
      </el-form>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="dialogVisible = false">取消</el-button>
          <el-button type="primary" @click="handleSubmit">确认</el-button>
        </span>
      </template>
    </el-dialog>

    <!-- 客户列表 -->
    <el-table
      :data="clientList"
      :loading="loading"
      style="width: 100%; margin-top: 20px"
      @sort-change="handleSortChange"
    >
      <el-table-column prop="name" label="客户名称">
        <template #default="{ row }">
          <el-button 
            link 
            type="primary" 
            @click="handleNameClick(row.id)"
          >
            {{ row.name }}
          </el-button>
        </template>
      </el-table-column>
      <el-table-column prop="status" label="状态">
        <template #default="{ row }">
          <span 
            class="status-tag" 
            :class="{
              'status-start': row.status === 'START',
              'status-cooperation': row.status === 'COOPERATION',
              'status-waiting': row.status === 'WAITING'
            }"
          >
            {{ CLIENT_STATUS_MAP[row.status] || row.status }}
          </span>
        </template>
      </el-table-column>
      <el-table-column prop="sum" label="交易额" sortable="custom">
        <template #default="{ row }">
          {{ (row.sum / 100).toFixed(2) }}
        </template>
      </el-table-column>
      <el-table-column prop="userName" label="负责人" />
      <el-table-column prop="lastTime" label="最后更新时间" sortable="custom">
        <template #default="{ row }">
          {{ formatTime(row.lastTime) }}
        </template>
      </el-table-column>
    </el-table>

    <!-- 分页 -->
    <el-pagination
      v-model:current-page="pagination.pageNum"
      v-model:page-size="pagination.pageSize"
      :total="pagination.total"
      :page-sizes="[5, 10, 20, 50]"
      layout="total, sizes, prev, pager, next"
      @size-change="handleSizeChange"
      @current-change="handleCurrentChange"
      class="pagination"
    />

    <!-- 修改负责人对话框 -->
    <el-dialog
      v-model="changeUserDialogVisible"
      :title="dialogTitle"
      :width="step === 1 ? '600px' : '400px'"
      @close="handleClose"
    >
      <!-- 第一步：选择客户 -->
      <div v-if="step === 1">
        <el-table
          ref="multipleTable"
          :data="clientList"
          @selection-change="handleSelectionChange"
        >
          <el-table-column type="selection" width="55" />
          <el-table-column prop="name" label="客户名称" />
          <el-table-column prop="status" label="状态">
            <template #default="{ row }">
              {{ CLIENT_STATUS_MAP[row.status] }}
            </template>
          </el-table-column>
        </el-table>
      </div>

      <!-- 第二步：选择用户 -->
      <div v-else-if="step === 2">
        <el-form ref="userFormRef" :model="userForm" :rules="userFormRules">
          <el-form-item label="选择用户" prop="userId">
            <el-select v-model="userForm.userId" placeholder="请选择用户">
              <el-option
                v-for="user in userList"
                :key="user.id"
                :label="user.realName"
                :value="user.id"
              />
            </el-select>
          </el-form-item>
        </el-form>
      </div>

      <!-- 第三步：输入密码 -->
      <div v-else>
        <el-form ref="userFormRef" :model="userForm" :rules="userFormRules">
          <el-form-item label="当前密码" prop="password">
            <el-input
              v-model="userForm.password"
              type="password"
              show-password
              placeholder="请输入当前密码"
            />
          </el-form-item>
        </el-form>
      </div>

      <template #footer>
        <span class="dialog-footer">
          <el-button v-if="step > 1" @click="prevStep">上一步</el-button>
          <el-button @click="changeUserDialogVisible = false">取消</el-button>
          <el-button 
            type="primary" 
            v-if="step < 3"
            @click="nextStep" 
            :disabled="step === 1 && !selectedClients.length"
          >
            下一步
          </el-button>
          <el-button 
            v-else
            type="primary" 
            @click="handleChangeUser"
          >
            完成
          </el-button>
        </span>
      </template>
    </el-dialog>
  </div>
</template>

<script lang="ts">
import { defineComponent, ref, reactive, onMounted, watch, computed } from 'vue'
import { ElMessage } from 'element-plus'
import { clientApi } from '../../api/client'
import type { ClientInfo, ClientForm } from '../../types'
import { CLIENT_STATUS_OPTIONS, CLIENT_STATUS_MAP } from '../../types'
import { useStore } from '../../hooks/useStore'
import { useRouter, onBeforeRouteLeave, RouteLocationNormalized, useRoute } from 'vue-router'
import type { FormInstance } from 'element-plus'
import { userApi } from '../../api/user'
import { SimpleUser } from '../../types'
import { formatDateTime } from '../../utils/format'

export default defineComponent({
  name: 'ClientManage',
  setup() {
    const store = useStore()
    const router = useRouter()
    const route = useRoute()
    const loading = ref(false)
    const clientList = ref<ClientInfo[]>([])

    const pagination = reactive({
      pageNum: 1,
      pageSize: 10,
      total: 0
    })

    const searchForm = reactive({
      name: undefined as string | undefined,
      status: undefined as string | undefined,
      sum: undefined as number | undefined
    })

    const sortState = reactive({
      sortBy: '',
      asc: true
    })

    // 前端字段名到后端字段名的映射
    const columnFieldMap: Record<string, string> = {
      name: 'name',
      status: 'status',
      sum: 'sum',
      lastTime: 'last_time'
    }

    // 获取客户列表
    const fetchClientList = async () => {
      loading.value = true
      try {
        const response = await clientApi.getClients({
          pageNum: pagination.pageNum,
          pageSize: pagination.pageSize,
          sortBy: sortState.sortBy,
          asc: sortState.asc,
          name: searchForm.name,
          status: searchForm.status,
          sum: searchForm.sum ? searchForm.sum * 100 : undefined,
          userId: route.params.userId ? Number(route.params.userId) : (store.isAdmin.value ? undefined : store.userInfo.value?.id)
        })

        if (response.code === 200 && response.data) {
          clientList.value = response.data.list
          pagination.total = response.data.total
        }
      } catch (error: any) {
        console.error('获取客户列表失败:', error)
        ElMessage.error(error.response?.data?.msg || error.message || '获取客户列表失败')
      } finally {
        loading.value = false
      }
    }

    // 处理搜索
    const handleSearch = () => {
      pagination.pageNum = 1
      fetchClientList()
    }

    // 处理排序变化
    const handleSortChange = ({ prop, order }: { prop?: string, order?: string }) => {
      sortState.sortBy = prop ? (columnFieldMap[prop] || prop) : ''
      sortState.asc = order === 'ascending'
      fetchClientList()
    }

    // 处理页码变化
    const handleCurrentChange = (page: number) => {
      pagination.pageNum = page
      fetchClientList()
    }

    // 处理每页条数变化
    const handleSizeChange = (size: number) => {
      pagination.pageSize = size
      fetchClientList()
    }

    // 点击客户名称跳转到详情页
    const handleNameClick = (id: number) => {
      router.push(`/client/${id}`)
    }

    // 保存列表状态
    onBeforeRouteLeave((to: RouteLocationNormalized) => {
      if (to.name === 'ClientDetail') {
        sessionStorage.setItem('clientListState', JSON.stringify({
          pageNum: pagination.pageNum,
          pageSize: pagination.pageSize,
          sortBy: sortState.sortBy,
          asc: sortState.asc,
          searchForm: {
            name: searchForm.name,
            status: searchForm.status,
            sum: searchForm.sum
          }
        }))
      } else {
        sessionStorage.removeItem('clientListState')
      }
    })

    onMounted(() => {
      const savedState = sessionStorage.getItem('clientListState')
      if (savedState) {
        const state = JSON.parse(savedState)
        pagination.pageNum = state.pageNum
        pagination.pageSize = state.pageSize
        sortState.sortBy = state.sortBy
        sortState.asc = state.asc
        Object.assign(searchForm, state.searchForm)
      }
      fetchClientList()
    })

    // 添加客户相关
    const dialogVisible = ref(false)
    const formRef = ref<FormInstance>()
    const form = ref<ClientForm>({
      name: '',
      mobile: '',
      email: '',
      address: '',
      remark: '',
      userId: store.userInfo.value?.id || 0
    })

    // 表单校验规则
    const rules = {
      name: [{ required: true, message: '请输入客户名称', trigger: 'blur' }],
      mobile: [{ pattern: /^1[3-9]\d{9}$/, message: '请输入正确的手机号', trigger: 'blur' }],
      email: [{ type: 'email' as const, message: '请输入正确的邮箱地址', trigger: 'blur' }]
    }

    // 打开添加对话框
    const handleAdd = () => {
      form.value = {
        name: '',
        mobile: '',
        email: '',
        address: '',
        remark: '',
        userId: store.userInfo.value?.id || 0
      }
      dialogVisible.value = true
    }

    // 提交添加
    const handleSubmit = async () => {
      if (!formRef.value) return
      
      await formRef.value.validate(async (valid: boolean) => {
        if (valid) {
          try {
            await clientApi.addClient(form.value)
            ElMessage.success('添加成功')
            dialogVisible.value = false
            fetchClientList()
          } catch (error) {
            ElMessage.error('添加失败')
          }
        }
      })
    }

    // 在setup中添加路由参数监听
    watch(
      () => route.params.userId,
      () => {
        // 重置分页
        pagination.pageNum = 1
        // 重新获取列表
        fetchClientList()
      }
    )

    // 修改状态定义
    const step = ref<1 | 2 | 3>(1)  // 添加步骤状态
    const changeUserDialogVisible = ref(false)  // 使用单个对话框
    const selectedClients = ref<ClientInfo[]>([])  // 添加选中的客户列表
    const userList = ref<SimpleUser[]>([])  // 添加用户列表
    const userForm = reactive({
      userId: undefined as number | undefined,
      password: ''
    })

    const userFormRules = {
      userId: [{ required: true, message: '请选择用���', trigger: 'change' }],
      password: [{ required: true, message: '请输入密码', trigger: 'blur' }]
    }

    // 显示修改负责人对话框
    const showChangeUserDialog = () => {
      step.value = 1
      changeUserDialogVisible.value = true
      selectedClients.value = []
    }

    // 下一步
    const nextStep = async () => {
      if (step.value === 1) {
        if (!selectedClients.value.length) {
          ElMessage.warning('请选择要修改的客户')
          return
        }
        try {
          const res = await userApi.getUsers({ 
            pageNum: 1, 
            pageSize: 1000,
            sortBy: 'create_time',
            asc: true
          })
          if (res.code === 200 && res.data) {
            userList.value = res.data.list.map(user => ({
              id: user.id,
              realName: user.realName
            }))
            step.value = 2
          }
        } catch (error) {
          ElMessage.error('获取用户列表失败')
        }
      } else if (step.value === 2) {
        if (!userForm.userId) {
          ElMessage.warning('请选择用户')
          return
        }
        step.value = 3
      }
    }

    // 上一步
    const prevStep = () => {
      if (step.value > 1) {
        step.value--
      }
    }

    // 关闭对话框时重置状态
    const handleClose = () => {
      changeUserDialogVisible.value = false
      step.value = 1
      selectedClients.value = []
      userForm.userId = undefined
      userForm.password = ''
    }

    // 提交
    const handleChangeUser = async () => {
      if (!userForm.userId || !userForm.password) {
        ElMessage.warning('请填写完整信息')
        return
      }

      try {
        // 批量修改客户负责人
        for (const client of selectedClients.value) {
          await clientApi.changeUser(client.id, userForm.userId, userForm.password)
        }
        ElMessage.success('修改成功')
        changeUserDialogVisible.value = false
        fetchClientList()
      } catch (error) {
        ElMessage.error('修改失败')
      }
    }

    // 对话框标题
    const dialogTitle = computed(() => {
      switch (step.value) {
        case 1:
          return '修改负责人 - 选择客户'
        case 2:
          return '修改负责人 - 选择新负责人'
        case 3:
          return '修改负责人 - 输入密码'
        default:
          return '修改负责人'
      }
    })

    // 处理表格选择变化
    const handleSelectionChange = (selection: ClientInfo[]) => {
      selectedClients.value = selection
    }

    const formatTime = (time: string) => formatDateTime(time)

    return {
      CLIENT_STATUS_OPTIONS,
      CLIENT_STATUS_MAP,
      loading,
      clientList,
      pagination,
      searchForm,
      handleSearch,
      handleSortChange,
      handleCurrentChange,
      handleSizeChange,
      handleNameClick,
      dialogVisible,
      formRef,
      form,
      rules,
      handleAdd,
      handleSubmit,
      changeUserDialogVisible,
      selectedClients,
      userList,
      userForm,
      userFormRules,
      showChangeUserDialog,
      handleSelectionChange,
      nextStep,
      prevStep,
      handleChangeUser,
      handleClose,
      step,
      dialogTitle,
      formatTime
    }
  }
})
</script>

<style scoped>
.client-manage {
  padding: 24px;
  position: relative;
  min-height: 200px;
}

.search-form {
  margin-bottom: 20px;
}

.pagination {
  margin-top: 20px;
  text-align: right;
}

.status-tag {
  display: inline-block;
  padding: 2px 8px;
  border-radius: 4px;
  border: 1px solid transparent;
}

.status-start {
  border-color: #67C23A;
  color: #67C23A;
}

.status-cooperation {
  border-color: #F56C6C;
  color: #F56C6C;
}

.status-waiting {
  border-color: #909399;
  color: #909399;
}

.header-actions {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: 20px;
}

.dialog-footer {
  display: flex;
  justify-content: flex-end;
  gap: 10px;
}

.right-buttons {
  display: flex;
  gap: 10px;
}
</style> 