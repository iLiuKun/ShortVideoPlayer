<template>
  <div>
    <h1>搜索结果</h1>
    <div v-for="video in searchResults" :key="video.id">
      <!-- 展示视频信息 -->
    </div>
  </div>
</template>

<script lang="ts" setup>
import { ref, onMounted } from 'vue';
import { useRoute } from 'vue-router';
import { sysVideoApi } from '../../api/video/video';

const searchResults = ref([]);
const route = useRoute();

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
