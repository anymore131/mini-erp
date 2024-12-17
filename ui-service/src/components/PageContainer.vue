<template>
  <div class="app-container">
    <el-card v-if="showCard" class="box-card">
      <template #header v-if="title">
        <div class="card-header">
          <span>{{ title }}</span>
          <slot name="header-right"></slot>
        </div>
      </template>
      <slot></slot>
    </el-card>
    <slot v-else></slot>
  </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue'

export default defineComponent({
  name: 'PageContainer',
  props: {
    title: {
      type: String,
      default: ''
    },
    showCard: {
      type: Boolean,
      default: true
    }
  }
})
</script>

<style scoped>
.app-container {
  padding: 20px;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.box-card {
  width: 100%;
}
</style> 