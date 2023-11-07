import { defineStore } from 'pinia';
import { ref } from 'vue';
import {sysVideoApi} from '@/api/video/video.js';

export const useTestStore = defineStore('test', () => {
  const videoList = ref([]);
  const currentVideoIndex = ref(0);

  async function getVideos() {
    const list = await sysVideoApi.getVideoList();
    videoList.value = list;
  }

  return { videoList, currentVideoIndex, getVideos };
});
