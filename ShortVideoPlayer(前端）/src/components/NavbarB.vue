<template>
  <el-radio-group v-model="isCollapse" style="margin-bottom: 20px">
    <el-radio-button :label="false">展开</el-radio-button>
    <el-radio-button :label="true">折叠</el-radio-button>
  </el-radio-group>
  <el-menu
    default-active="1"
    class="el-menu-vertical-demo"
    :collapse="isCollapse"
    :default-openeds="['4']"
    @open="handleOpen"
    @close="handleClose"
  >
    <router-link to="/index">
      <el-menu-item index="1">
        <el-icon><icon-menu /></el-icon>
        <template #title>搜索</template>
      </el-menu-item>
    </router-link>
    
    <router-link to="/recommend">
      <el-menu-item index="2">
        <el-icon><icon-menu /></el-icon>
        <template #title>推荐</template>
      </el-menu-item>
    </router-link>
    
    <router-link to="/profile">
      <el-menu-item index="3">
        <el-icon><document /></el-icon>
        <template #title>我的</template>
      </el-menu-item>
    </router-link>
    
    <el-sub-menu index="4" popper-class="non-clickable-title">
      <template #title>
        <el-icon><location /></el-icon>
        <span>分类</span>
      </template>

        <router-link to="/category/sports">
      <el-menu-item index="1-1">运动</el-menu-item>
    </router-link>

    <router-link to="/category/emotion">
      <el-menu-item index="1-2">情感</el-menu-item>
    </router-link>

    <router-link to="/category/entertainment">
      <el-menu-item index="1-3">娱乐</el-menu-item>
    </router-link>

    <router-link to="/category/funny">
      <el-menu-item index="1-4">搞笑</el-menu-item>
    </router-link>

    <router-link to="/category/scenery">
      <el-menu-item index="1-5">风景</el-menu-item>
    </router-link>
    </el-sub-menu>
  </el-menu>
</template>

<script lang="ts" setup>
import { ref } from 'vue'
import {
  Document,
  Menu as IconMenu,
  Location,
  Setting,
} from '@element-plus/icons-vue'

const isCollapse = ref(false)
const handleOpen = (key: string, keyPath: string[]) => {
  console.log(key, keyPath)
}
const handleClose = (key: string, keyPath: string[]) => {
  console.log(key, keyPath)
}
</script>

<style>
.el-menu-vertical-demo:not(.el-menu--collapse) {
  width: 200px;
  min-height: 400px;
}
/* 添加样式使得分类标题不可点击 */
.non-clickable-title {
  pointer-events: none;
} 
</style>
