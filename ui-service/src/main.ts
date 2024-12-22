import { createApp } from 'vue'
import ElementPlus from 'element-plus'
import 'element-plus/dist/index.css'
import { User, Setting, Odometer, Document } from '@element-plus/icons-vue'
import App from './App.vue'
import router from './router'
import store from './store'

const app = createApp(App)

// 注册需要的图标
app.component('User', User)
   .component('Setting', Setting)
   .component('Odometer', Odometer)
   .component('Document', Document)

app.use(ElementPlus)
   .use(router)
   .use(store)
   .mount('#app')
