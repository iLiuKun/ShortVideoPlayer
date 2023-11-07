<template>
  <div class="container">
    <Navbar :routes="routes" />
    <div class="search-container">
      
      <el-input v-model="input" placeholder="搜索" class="responsive-input" @keyup.enter="handleSearch">
        <template #prepend>
        <el-button :icon="Search" @click="handleSearch" />
      </template>
      </el-input>
    </div>  
    <VideoUploader />
    <router-view></router-view> 

    <el-dropdown class="dropdown-position" :hide-on-click="false">
    <span class="el-dropdown-link">
      选项<el-icon class="el-icon--right"><arrow-down /></el-icon>
    </span>
    <template #dropdown>
      <el-dropdown-menu>
        <el-dropdown-item @click="handleLogout">退出登录</el-dropdown-item>
        
      </el-dropdown-menu>
    </template>
  </el-dropdown>
  </div>
  
</template>

<script lang="ts" setup>
import { ref } from 'vue';
import { Search } from '@element-plus/icons-vue'
import Navbar from './components/NavbarB.vue';
import { useUserStore } from './store/modules/user';
import { ArrowDown } from '@element-plus/icons-vue';
import VideoUploader from './components/upload.vue';
import { sysVideoApi } from './api/video/video';
import { useRouter } from 'vue-router';

const input = ref('')
const userStore = useUserStore();
const router = useRouter();
const storedIsLogin = sessionStorage.getItem('isLogin');
const storedUserInfo = JSON.parse(sessionStorage.getItem('userInfo') || '{}');
if (storedIsLogin === 'true') {
    userStore.isLogin = true;
    userStore.userInfo = storedUserInfo;
}
const handleLogout = async () => {
    userStore.logout();
}

const handleSearch = () => {
  if (input.value.trim()) { // 确保输入不是空白字符
    // 使用router.push方法导航到index页面，并附带查询参数
    router.push({ name: 'index', query: { search: input.value } });
    input.value = ''; // 清空搜索栏
  }
};

</script>

<style scoped>
.container {
  position: relative;
}

.search-container {
  position: absolute;  
  top: 20px;              
  right: 40%;       
}

.responsive-input {
  max-width: 500px;
  width: 100%;
}

.example-showcase .el-dropdown + .el-dropdown {
  margin-right: 15px;
}
.example-showcase .el-dropdown-link {
  cursor: pointer;
  color: var(--el-color-primary);
  display: flex;
  align-items: center;
}
.dropdown-position {
  position: absolute;
  top: 10px;
  right: 10px;
}
</style>
