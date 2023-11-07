<template>
  <div class="container">
    <vue3-video-play v-if="currentVideoUrl" :src="currentVideoUrl"></vue3-video-play>
    <div class="video-controls" v-if="currentVideoUrl">
      <!-- 添加收藏和取消收藏按钮 -->
      <el-button  @click="favoriteCurrentVideo">收藏视频</el-button>
      <el-button  @click="unfavoriteCurrentVideo">取消收藏</el-button>
    </div>
    <div class="content">
      <div class="funny-videos">
        <div v-for="video in funnyVideos" :key="video.id" @click="playVideo(video.videoUrl)" class="video-thumbnail">
          <img :src="video.thumbnailUrl" alt="视频封面" />
        </div>
      </div>
    </div>
    
  </div>
  
</template>

<script lang="ts" setup>
import { ref, onMounted ,onUnmounted} from 'vue';
import { useUserStore } from "../../store/modules/user";
import { sysVideoApi } from "../../api/video/video";
import { sysUserApi } from "../../api/user/user";
import { ElMessage } from 'element-plus';

const isFavorite = ref(false);
const categoryId = 4;
const username = ref('未登录');
const userStore = useUserStore();

username.value = userStore.userInfo.username;

const funnyVideos = ref([]);
const currentVideoUrl = ref(''); // 用于存储当前播放视频的URL
const currentVideoIndex = ref(0);
onMounted(async () => {
  try {
    const response = await sysVideoApi.getVideoList(categoryId);
    funnyVideos.value = response.data.data; // 假设返回的数据在response.data里面
  } catch (error) {
    console.error("获取搞笑视频失败:", error);
  }

  const handleKeyDown = (event: KeyboardEvent) => {
    

    if (event.key === 'ArrowUp' || event.key === 'w') {
      // 按下了上箭头键
      currentVideoIndex.value = (currentVideoIndex.value - 1 + funnyVideos.value.length) % funnyVideos.value.length;
      currentVideoUrl.value = funnyVideos.value[currentVideoIndex.value].videoUrl;
    } else if (event.key === 'ArrowDown' || event.key === 's') {
      // 按下了下箭头键
      currentVideoIndex.value = (currentVideoIndex.value + 1) % funnyVideos.value.length;
      currentVideoUrl.value = funnyVideos.value[currentVideoIndex.value].videoUrl;
    }
  };

  window.addEventListener('keydown', handleKeyDown);  

  onUnmounted(() => {
  window.removeEventListener('keydown', handleKeyDown); // 清理事件监听器
});
});



// 模拟视频播放的方法
const playVideo = (videoUrl) => {
  // currentVideoUrl.value = videoUrl; // 更新当前播放的视频URL
  const index = funnyVideos.value.findIndex((video) => video.videoUrl === videoUrl);
  if (index !== -1) {
    currentVideoIndex.value = index;
    currentVideoUrl.value = videoUrl;
  }
};
// 增加收藏当前视频的方法
const favoriteCurrentVideo = async () => {
  const videoId = funnyVideos.value[currentVideoIndex.value].id;
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
  const videoId = funnyVideos.value[currentVideoIndex.value].id;
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
