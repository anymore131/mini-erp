<template>
  <div class="not-found">
    <h1>404</h1>
    <p>抱歉，您访问的页面不存在</p>
    <a-button type="primary" @click="goHome">返回首页</a-button>
  </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue'
import { useRouter } from 'vue-router'

export default defineComponent({
  name: '404',
  setup() {
    const router = useRouter()
    
    const goHome = () => {
      router.push('/')
    }

    return {
      goHome
    }
  }
})
</script>

<style scoped>
.not-found {
  height: 100%;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}
</style> 