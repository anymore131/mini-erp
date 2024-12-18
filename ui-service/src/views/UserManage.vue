<template>
  <div class="user-manage">
    <page-loading :loading="loading" text="加载用户数据..." />
    <!-- 添加查询条件 -->
    <el-form :inline="true" class="search-form">
      <el-form-item label="用户名">
        <el-input
          v-model="searchForm.userName"
          placeholder="请输入用户名"
          clearable
          @clear="handleSearch"
        />
      </el-form-item>
      <el-form-item label="真实姓名">
        <el-input
          v-model="searchForm.realName"
          placeholder="请输入真实姓名"
          clearable
          @clear="handleSearch"
        />
      </el-form-item>
      <el-form-item label="角色">
        <el-select
          v-model="searchForm.role"
          placeholder="请选择角色"
          clearable
          style="width: 120px"
        >
          <el-option 
            v-for="item in roleOptions" 
            :key="item.value" 
            :label="item.label" 
            :value="item.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="handleSearch">查询</el-button>
      </el-form-item>
    </el-form>

    <el-button 
      v-permission="['admin']"
      type="primary" 
      @click="showAddModal"
    >
      添加用户
    </el-button>

    <el-table
      :data="userList"
      :loading="loading"
      style="width: 100%; margin-top: 20px"
      @sort-change="handleSortChange"
    >
      <el-table-column prop="userName" label="用户名" sortable="custom" />
      <el-table-column prop="realName" label="真实姓名" sortable="custom" />
      <el-table-column prop="email" label="邮箱" />
      <el-table-column prop="phone" label="手机号" />
      <el-table-column prop="role" label="角色" sortable="custom">
        <template #default="{ row }">
          {{ row.role === 'admin' ? '管理员' : '普通用户' }}
        </template>
      </el-table-column>
      <el-table-column prop="lastUpdate" label="最后更新时间" sortable="custom" />
      <el-table-column label="操作" width="200">
        <template #default="{ row }">
          <el-button type="primary" size="small" @click="handleEdit(row)">
            编辑
          </el-button>
          <el-popconfirm
            title="确定要删除此用户吗？"
            @confirm="handleDelete(row.id)"
          >
            <template #reference>
              <el-button type="danger" size="small">删除</el-button>
            </template>
          </el-popconfirm>
        </template>
      </el-table-column>
    </el-table>

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

    <!-- 添加/编辑用户弹窗 -->
    <el-dialog
      v-model="modalVisible"
      :title="modalType === 'add' ? '添加用户' : '编辑用户'"
      width="500px"
    >
      <el-form :model="userForm" label-width="100px">
        <el-form-item label="用户名" required>
          <el-input v-model="userForm.userName" :disabled="modalType === 'edit'" />
        </el-form-item>
        <el-form-item label="真实姓名" required>
          <el-input v-model="userForm.realName" />
        </el-form-item>
        <el-form-item label="邮箱" required>
          <el-input v-model="userForm.email" />
        </el-form-item>
        <el-form-item label="手机号" required>
          <el-input v-model="userForm.phone" />
        </el-form-item>
        <el-form-item label="角色">
          <el-select v-model="userForm.role" style="width: 100%">
            <el-option label="普通用户" value="user" />
            <el-option label="管理员" value="admin" />
          </el-select>
        </el-form-item>
        <el-form-item v-if="modalType === 'add'" label="初始密码">
          <el-input value="666666" disabled />
          <div class="el-form-item__tip">默认密码为：666666</div>
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="modalVisible = false">取消</el-button>
        <el-button 
          v-if="modalType === 'edit'" 
          type="warning" 
          @click="handleResetPassword"
        >
          重置密码
        </el-button>
        <el-button type="primary" @click="handleModalOk">确定</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script lang="ts">
import { defineComponent, ref, reactive, onMounted } from 'vue'
import { ElMessage } from 'element-plus'
import { userApi } from '../api/user'
import type { UserForm, UserInfo } from '../types'
import PageLoading from '../components/PageLoading.vue'

export default defineComponent({
  name: 'UserManage',
  components: {
    PageLoading
  },
  setup() {
    const loading = ref(false)
    const modalVisible = ref(false)
    const modalType = ref<'add' | 'edit'>('add')
    const userList = ref<UserInfo[]>([])

    const columns = [
      { title: '用户名', dataIndex: 'username' },
      { title: '角色', dataIndex: 'role' },
      { title: '创建时间', dataIndex: 'createTime' },
      { title: '操作', slots: { customRender: 'action' } }
    ]

    const pagination = reactive({
      pageNum: 1,
      pageSize: 10,
      total: 0
    })

    const userForm = reactive<UserForm>({
      id: null,
      userName: '',
      realName: '',
      email: '',
      phone: '',
      role: 'user'
    })

    // 添加查询条件
    const searchForm = reactive({
      userName: undefined as string | undefined,
      realName: undefined as string | undefined,
      role: undefined as string | undefined
    })

    const roleOptions = [
      { label: '管理员', value: 'admin' },
      { label: '普通用户', value: 'user' }
    ]

    // 添加排序状态
    const sortState = reactive({
      sortBy: 'create_time',
      asc: true
    })

    // 前端字段名到后端字段名的映射
    const columnFieldMap: Record<string, string> = {
      userName: 'user_name',
      realName: 'real_name',
      lastUpdate: 'last_update',
      createTime: 'create_time'
    }

    // 查询方法
    const handleSearch = () => {
      pagination.pageNum = 1  // 重置页码
      fetchUserList()
    }

    // 获取用户列表
    const fetchUserList = async () => {
      loading.value = true
      try {
        const response = await userApi.getUsers({
          pageNum: pagination.pageNum,
          pageSize: pagination.pageSize,
          sortBy: sortState.sortBy,
          asc: sortState.asc,
          userName: searchForm.userName,
          realName: searchForm.realName,
          role: searchForm.role
        })
        if (response.code === 200 && response.data) {
          userList.value = response.data.list
          pagination.total = response.data.total
        }
      } catch (error) {
        ElMessage.error('获取用户列表失败')
      } finally {
        loading.value = false
      }
    }

    // 表格分页变化
    const handleTableChange = (pag: any) => {
      pagination.pageNum = pag.current
      pagination.pageSize = pag.pageSize
      fetchUserList()
    }

    // 显示添加用户弹窗
    const showAddModal = () => {
      modalType.value = 'add'
      userForm.id = null
      userForm.userName = ''
      userForm.realName = ''
      userForm.email = ''
      userForm.phone = ''
      userForm.role = 'user'
      modalVisible.value = true
    }

    // 显示编辑用户弹窗
    const handleEdit = (record: UserInfo) => {
      modalType.value = 'edit'
      Object.assign(userForm, record)
      modalVisible.value = true
    }

    // 删除用户
    const handleDelete = async (id: number) => {
      try {
        await userApi.deleteUser(id)
        ElMessage.success('删除成功')
        fetchUserList()
      } catch (error) {
        ElMessage.error('删除失败')
      }
    }

    // 重置密码
    const handleResetPassword = async () => {
      try {
        await userApi.resetPassword({
          userId: userForm.id!,
          newPassword: '666666'
        })
        ElMessage.success('密码重置成功')
      } catch (error) {
        ElMessage.error('密码重置失败')
      }
    }

    // 修改添加用户方法
    const handleModalOk = async () => {
      try {
        if (modalType.value === 'add') {
          await userApi.addUser({
            ...userForm,
            password: '666666'  // 添加默认密码
          })
          ElMessage.success('添加成功')
        } else {
          await userApi.updateUser(userForm)
          ElMessage.success('更新成功')
        }
        modalVisible.value = false
        fetchUserList()
      } catch (error) {
        ElMessage.error(modalType.value === 'add' ? '添加失败' : '更新失败')
      }
    }

    // 处理页码变化
    const handleCurrentChange = (page: number) => {
      pagination.pageNum = page
      fetchUserList()
    }

    // 处理每页条数变化
    const handleSizeChange = (size: number) => {
      pagination.pageSize = size
      fetchUserList()
    }

    // 处理排序变化
    const handleSortChange = ({ prop, order }: { prop?: string, order?: string }) => {
      sortState.sortBy = prop ? (columnFieldMap[prop] || prop) : ''
      sortState.asc = order === 'ascending'
      fetchUserList()
    }

    // 初始化
    onMounted(() => {
      fetchUserList()
    })

    return {
      loading,
      userList,
      columns,
      pagination,
      modalVisible,
      modalType,
      userForm,
      handleTableChange,
      showAddModal,
      handleEdit,
      handleDelete,
      handleModalOk,
      handleCurrentChange,
      handleSizeChange,
      searchForm,
      handleSearch,
      roleOptions,
      handleSortChange,
      handleResetPassword
    }
  }
})
</script>

<style scoped>
.user-manage {
  padding: 24px;
  position: relative;
  min-height: 200px;
}

.operation-bar {
  margin-bottom: 16px;
}

.search-form {
  margin-bottom: 20px;
}
</style> 