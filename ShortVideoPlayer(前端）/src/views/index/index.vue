<template>
    <div class="container">
         <!-- 显示搜索关键词 -->
         <div v-if="searchKeyword" class="search-keyword">搜索关键词: "{{ searchKeyword }}"</div>
    <vue3-video-play v-if="currentVideoUrl" :src="currentVideoUrl"></vue3-video-play>
    <div class="video-controls" v-if="currentVideoUrl">
      <!-- 添加收藏和取消收藏按钮 -->
      <el-button  @click="favoriteCurrentVideo">收藏视频</el-button>
      <el-button  @click="unfavoriteCurrentVideo">取消收藏</el-button>
    </div>
    <div class="content">
      <div class="funny-videos">
        <div v-for="video in searchResults" :key="video.id" @click="playVideo(video.videoUrl)" class="video-thumbnail">
          <img :src="video.thumbnailUrl" alt="视频封面" />
        </div>
      </div>
    </div>
    
  </div>
  </template>
  
  <script lang="ts" setup>
  import { ref, onMounted,computed ,watch } from 'vue';
  import { useRoute } from 'vue-router';
  import { sysVideoApi } from '../../api/video/video';
  import { sysUserApi } from "../../api/user/user";
  import { ElMessage } from 'element-plus';
  const searchResults = ref([]);
  const route = useRoute();
  const recommedVideos = ref([]);
const currentVideoUrl = ref(''); // 用于存储当前播放视频的URL
const currentVideoIndex = ref(0);
const isFavorite = ref(false);
const searchKeyword = computed(() => route.query.search as string || '');
// 模拟视频播放的方法
const playVideo = (videoUrl) => {
  // currentVideoUrl.value = videoUrl; // 更新当前播放的视频URL
  const index = searchResults.value.findIndex((video) => video.videoUrl === videoUrl);
  if (index !== -1) {
    currentVideoIndex.value = index;
    currentVideoUrl.value = videoUrl;
  }
};
// 增加收藏当前视频的方法
const favoriteCurrentVideo = async () => {
  const videoId = recommedVideos.value[currentVideoIndex.value].id;
  try {
    const response = await sysUserApi.favoriteVideo(userStore.userInfo.userId, videoId);
    if (response.data.success) {
      isFavorite.value = true;
      ElMessage({
        message: '视频收藏成功',
        type: 'success',
        duration: 3000
      });
    }
  } catch (error) {
    console.error("收藏视频失败:", error);
    ElMessage.error('视频收藏失败');
  }
};
// 增加取消收藏当前视频的方法
const unfavoriteCurrentVideo = async () => {
  const videoId = recommedVideos.value[currentVideoIndex.value].id;
  try {
    const response = await sysUserApi.unfavoriteVideo(userStore.userInfo.userId, videoId);
    if (response.data.success) {
      isFavorite.value = false;
      ElMessage({
        message: '取消收藏成功',
        type: 'info',
        duration: 3000
      });
    }
  } catch (error) {
    console.error("取消收藏视频失败:", error);
    ElMessage.error('取消收藏失败');
  }
};
watch(() => route.query.search, async (newSearchKeyword) => {
  searchKeyword.value = newSearchKeyword as string;
  if (newSearchKeyword) {
    try {
      const response = await sysVideoApi.getSearchVideos(newSearchKeyword);
      searchResults.value = response.data.data;
    } catch (error) {
      console.error("获取搜索结果失败:", error);
      // 这里可以处理错误，比如展示一个消息
    }
  }
});
  onMounted(async () => {
    const searchKeyword = route.query.search;
    if (searchKeyword) {
      try {
        const response = await sysVideoApi.getSearchVideos(searchKeyword as string);
        searchResults.value = response.data.data;
      } catch (error) {
        console.error("获取搜索结果失败:", error);
        // 这里可以处理错误，比如展示一个消息
      }
    }
  });
  </script>
  
  <style scoped>
.container {
  position: absolute;
  top:10%;
  left: 15%;
  display: flex;
  flex-direction: column;
  align-items: flex-start; 
}

.content {
  width: 100%;
}

.funny-videos {
  display: flex;
  flex-wrap: wrap;
  justify-content: flex-start; /* Aligns the thumbnails to the left */
  gap: 16px; /* Adjust the gap as needed */
}

.video-thumbnail {
  cursor: pointer;
}

.video-thumbnail img {
  width: 240px; /* Adjust the width as needed */
  height: auto;
  display: block;
  transition: transform 0.3s ease-in-out; /* Smooth transition for transform property */
}

.video-thumbnail:hover img {
  transform: scale(1.1); /* Adjust scale value as needed */
}

</style>
