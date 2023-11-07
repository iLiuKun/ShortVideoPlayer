<template>
  <div class="common-layout">
    <el-container class="info">
      <el-header class="header-section">
        <div class="block">
          <el-avatar :size="50" :src="userAvatarUrl" />
        </div>
        <div class="user-details">
          <!-- 当用户未登录时，用户名是可点击的，并且点击后会弹出登录对话框 -->
          <el-button v-if="loggedInUser === '未登录'" type="text" plain @click="centerDialogVisible = true">{{
            loggedInUser }}</el-button>

          <!-- 当用户已登录时，用户名是不可点击的 -->
          <el-button v-else type="text" plain disabled>{{ loggedInUser }}</el-button>

          <div class="buttons-row">
            <el-button type="text" plain @click="showFollowList">关注</el-button>
            <el-button type="text" plain @click="showFansList">粉丝</el-button>
          </div>
        </div>
      </el-header>

      <el-main class="main-section">
        <el-menu :default-active="activeIndex" class="el-menu-demo" mode="horizontal" :ellipsis="false"
          @select="handleSelect">
          <el-menu-item class="user_video" index="0" @click="fetchUserVideos">作品</el-menu-item>

          <el-menu-item class="user_favorite" index="1" @click="fetchFavorites">收藏</el-menu-item>
        </el-menu>
        <vue3-video-play v-if="currentVideoUrl" :src="currentVideoUrl"></vue3-video-play>
        <div class="videos-section" v-if="activeIndex === '0'">
          <div v-for="video in videos" :key="video.id" @click="playVideo(video.videoUrl)">
            <img :src="video.thumbnailUrl" alt="用户视频封面" />
          </div>
          
        </div>
        <div class="videos-section" v-if="activeIndex === '1'">
            <div v-for="video in videos" :key="video.id"
              @click="playVideo(video.videoUrl)">
              <img :src="video.thumbnailUrl" alt="收藏视频封面" />
            </div>
          </div>
        
      </el-main>
    </el-container>
  </div>
  <el-dialog v-model="centerDialogVisible" title="登录" width="30%" destroy-on-close center>
    <el-form :label-position="labelPosition" label-width="100px" :model="formLabelAlign" style="max-width: 460px">
      <el-form-item label="用户名">
        <el-input v-model="formLabelAlign.username" />
      </el-form-item>
      <el-form-item label="密码">
        <el-input type="password" v-model="formLabelAlign.password" />
      </el-form-item>

    </el-form>
    <template #footer>
      <span class="dialog-footer">
        <el-button @click="centerDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="handleLogin">
          确认
        </el-button>
      </span>
    </template>
  </el-dialog>
  <!-- 关注列表对话框 -->
  <el-dialog v-model="followDialogVisible" title="关注列表" width="50%">
    <ul>
      <li v-for="follow in followList" :key="follow.id">
        <el-avatar :src="follow.avatarUrl" />
        {{ follow.username }}
      </li>
    </ul>
  </el-dialog>

  <!-- 粉丝列表对话框 -->
  <el-dialog v-model="fansDialogVisible" title="粉丝列表" width="50%">
    <ul>
      <li v-for="fan in fansList" :key="fan.id">
        <el-avatar :src="fan.avatarUrl" /> <!-- 使用 avatarUrl 属性展示头像 -->
        {{ fan.username }} <!-- 展示用户名 -->
      </li>
    </ul>
  </el-dialog>
</template>

<script lang="ts" setup>
import { reactive, ref } from 'vue'
import type { FormProps } from 'element-plus'
import { useUserStore } from "../../store/modules/user";
import { onMounted } from 'vue';
import { ElMessage } from 'element-plus';
import { sysUserApi } from '../../api/user/user'

const videos = ref([]);  // 存储视频数据的响应式变量
const centerDialogVisible = ref(false)
const labelPosition = ref<FormProps['labelPosition']>('right')
const userAvatarUrl = ref('');  // 默认值为一个空字符串，或者可以是一个默认的头像URL
const followList = ref([]);  // 用于存储关注列表的数据
const fansList = ref([]);    // 用于存储粉丝列表的数据
const activeIndex = ref('0');  // 默认选中“作品”
const videoOptions = ref({
  // 这里可以设置 video.js 的播放器选项
});
const videoPlayer = ref(null);
const formLabelAlign = reactive({
  username: '',
  password: '',
})
const currentVideoUrl = ref(''); // 用于存储当前播放视频的URL
const followDialogVisible = ref(false)
const fansDialogVisible = ref(false)
// 新增一个响应式变量存储登录的用户名
const loggedInUser = ref('未登录')
const userStore = useUserStore();
const handleLogin = async () => {

  const result = await userStore.login(formLabelAlign.username, formLabelAlign.password);
  if (result && result.code === 20000) {
    centerDialogVisible.value = false;
    // 登录成功后，设置 loggedInUser 为登录的用户名
    loggedInUser.value = userStore.userInfo.username;
    userAvatarUrl.value = userStore.userInfo.avatar_url;
    fetchUserVideos();  // 登录成功后，获取视频数据
  } else {
    ElMessage.error('用户名或者密码错误！');
    centerDialogVisible.value = false;

  }

};
const showFollowList = async () => {
  try {

    // 使用API函数获取关注列表
    const response = await sysUserApi.getFollowsByUserId(userStore.userInfo.userId);
    if (response.data) {
      followList.value = response.data.data;
    }
    followDialogVisible.value = true;
  } catch (error) {
    ElMessage.error('获取关注列表失败！');
  }
};

const showFansList = async () => {
  try {
    // 使用API函数获取粉丝列表
    const response = await sysUserApi.getFansByUserId(userStore.userInfo.userId);
    if (response.data) {
      fansList.value = response.data.data;
    }
    fansDialogVisible.value = true;
  } catch (error) {
    ElMessage.error('获取粉丝列表失败！');
  }
};

const handleSelect = (index) => {
  activeIndex.value = index;
};

const fetchUserVideos = async () => {
  try {
    const response = await sysUserApi.getVideosByUserId(userStore.userInfo.userId);
    if (response.data) {
      videos.value = response.data.data;
      console.log(videos.value)
      // console.log(response.data.data)
    }
  } catch (error) {
    ElMessage.error('获取视频数据失败！');
  }
};
const fetchFavorites = async () => {
  try {
    const response = await sysUserApi.getFavoritesByUserId(userStore.userInfo.userId);
    if (response.data) {
      videos.value = response.data.data;  // 将收藏的视频设置为当前展示的视频
      console.log(videos.value)
    }
  } catch (error) {
    ElMessage.error('获取收藏视频数据失败！');
  }
};


const playVideo = (videoUrl) => {
  // 确保 videoOptions 包含正确的视频URL
  currentVideoUrl.value = videoUrl;
};


onMounted(() => {
  // 检查用户是否已经登录
  if (userStore.isLogin) {
    loggedInUser.value = userStore.userInfo.username;
    userAvatarUrl.value = userStore.userInfo.avatar_url;
    fetchUserVideos();  // 如果已登录，获取视频数据
  } else {
    loggedInUser.value = '未登录';

  }
});

</script>

<style scoped>
.info {
  position: absolute;
  display: flex;
  left: 15%;
  top: 20%;
}

.header-section {
  display: flex;
  flex-direction: row;
}

.user-details {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  margin-left: 20px;
  /* 根据需要调整间距 */
}

.buttons-row {
  display: flex;
  flex-direction: row;
  align-items: center;
}

.user_video {
  width: 100px;
}

.user_favorite {
  width: 100px;
}

.main-section {
  display: flex;
  flex-direction: column;
}

.video-container {
  max-width: 100%;
  padding: 10px;
}

video {
  max-width: 100%;
  height: auto;
}

.dialog-footer button:first-child {
  margin-right: 10px;
}

.videos-section {
  display: flex;
  flex-wrap: wrap; 
  overflow-x: auto;  
  align-items: center;
  white-space: nowrap;
  margin-top: 20px;
  /* 设置与上面内容的间距 */
}

.videos-section img {
  width: 240px;
  height: auto;
  cursor: pointer;
  margin-right: 20px;
  /* 设置每个视频之间的间距 */
  transition: transform 0.3s;
}

.videos-section img:last-child {
  margin-right: 0;
  /* 最后一个视频封面不需要右边距 */
}

.videos-section img:hover {
  transform: scale(1.1);
  /* 鼠标悬停时放大 */
}</style>
