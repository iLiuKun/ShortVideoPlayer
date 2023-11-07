import { createApp } from 'vue';
import App from './App.vue';
import router from '@/router/index.js';
import 'video.js/dist/video-js.css'; // 引入video.js的样式
import ElementPlus from 'element-plus';
import 'element-plus/dist/index.css';
import { createPinia } from 'pinia';
import * as ElementPlusIconsVue from '@element-plus/icons-vue';
import vue3videoPlay from 'vue3-video-play' // 引入组件
import 'vue3-video-play/dist/style.css' // 引入css
const app = createApp(App);

// ElementPlus 组件注册
app.use(ElementPlus);
// ElementPlus 图标注册
for (const [key, component] of Object.entries(ElementPlusIconsVue)) {
  app.component(key, component);
}
app.use(vue3videoPlay);
app.use(router);
app.use(createPinia());



app.mount('#app');
