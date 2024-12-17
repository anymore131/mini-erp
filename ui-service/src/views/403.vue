<template>
  <div class="forbidden">
    <h1>403</h1>
    <p>抱歉，您没有权限访问此页面</p>
    <a-button type="primary" @click="goBack">返回</a-button>
  </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue'
import { useRouter } from 'vue-router'

export default defineComponent({
  name: '403',
  setup() {
    const router = useRouter()
    
    const goBack = () => {
      router.back()
    }

    return {
      goBack
    }
  }
})
</script>

<style scoped>
.forbidden {
  height: 100%;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}
</style> 