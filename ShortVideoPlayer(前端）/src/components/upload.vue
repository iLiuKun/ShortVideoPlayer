<template>
    <el-button @click="visible = true"> 上传视频 </el-button>
    <el-drawer v-model="visible" :show-close="false">
      <template #header="{ close, titleId, titleClass }">
        <h4 :id="titleId" :class="titleClass">上传视频</h4>
        <el-button type="danger" @click="close">
          <el-icon class="el-icon--left"><CircleCloseFilled /></el-icon>
          关闭
        </el-button>
      </template>
      <el-select v-model="categoryId" placeholder="请选择类别">
      <el-option
        v-for="category in categories"
        :key="category.id"
        :label="category.name"
        :value="category.id">
      </el-option>
    </el-select>
      <el-upload ref="upload" v-model:file-list="fileList" class="upload-demo" drag action="#" :limit="1" :before-upload="beforeUpload" :auto-upload="false" :on-change="handleChange">
        <!-- :http-request="handleFileUpload" -->
        <el-icon class="el-icon--upload"><upload-filled /></el-icon>
        <div class="el-upload__text">Drop file here or <em>click to upload</em></div>
        <template #tip>
          <div class="el-upload__tip"></div>
          <el-divider content-position="center"> <el-text class="mx-1" size="large">video files only</el-text></el-divider>
          <el-progress v-if="progress !== 0 && progress !== 100" class="c-upload__progress" :percentage="progress" />
        </template>
      </el-upload>
      <el-input v-model="textarea" placeholder="分享生活，发现精彩！" :rows="5" type="textarea" />
      <el-button @click="visible = false">取 消</el-button>
      <el-button type="primary" @click="confirmUpload()">上 传</el-button>
    </el-drawer>
  </template>
  <!-- <el-button size="small" type="primary" @click="submitUpload">上传</el-button> -->



  
  <script setup>
  import { ref } from 'vue';
  import * as qiniu from 'qiniu-js';
  import { sysVideoApi } from '../api/video/video';
  import { useUserStore } from '../store/modules/user';
  
// 假设这里是用户信息和类别数据，实际情况中你可能需要从store中获取或者通过api调用
  const userStore = useUserStore();
  const userId = userStore.userInfo.userId; // 用户ID
  const visible = ref(false);
  const token = ref('cRmYPEHlq_MXaaXDumyuSAytL0JXd_5AKIyS9KyU:7EzWFabljY2GqLttCq1U0UxPeEM=:eyJzY29wZSI6InhpYW9odXRlYW0iLCJkZWFkbGluZSI6MjA1OTM3MjU4MH0=');
  // const dialogOfUpload = ref(false);
  const fileList = ref([]);
  const progress = ref(0);
  const textarea = ref('');
  const key = ref('');
  const categoryId = ref(null);
  const categories = [
  { id: 1, name: '运动' },
  { id: 2, name: '情感' },
  { id: 3, name: '娱乐' },
  { id: 4, name: '搞笑' },
  { id: 5, name: '风景' },
];


  

  async function beforeUpload() {
    token.value = 'cRmYPEHlq_MXaaXDumyuSAytL0JXd_5AKIyS9KyU:7EzWFabljY2GqLttCq1U0UxPeEM=:eyJzY29wZSI6InhpYW9odXRlYW0iLCJkZWFkbGluZSI6MjA1OTM3MjU4MH0=';
    if (token.value == '') {
      return false;
    }
    if (!categoryId.value) {
    alert('请选择视频类别');
    return false;
  }
  }
  
  function handleChange(file, fileList) {
    console.log('liuuu', file, fileList);
    //文件数量改变
    fileList.value = fileList;
  }
  
  async function confirmUpload() {
    const observer = {
      next(res) {
        console.log(res);
        progress.value = res.total.percent;
      },
      error(err) {
        console.log(err);
      },

      complete: async (res) => {
      const videoUrl = `http://xiaohu.hanshubo.com/${res.key}`; // 替换为七牛云返回的URL

      const dataToSave = {
        userId: userId,
        categoryId: categoryId.value,
        title: res.key,
        description: textarea.value,
        videoUrl: videoUrl,
        thumbnailUrl: videoUrl+'?vframe/jpg/offset/0', // 需要有缩略图URL时填充
        // 其他可能需要的字段...
      };

      try {
        console.log(dataToSave);
        const response = await sysVideoApi.add(dataToSave);
        alert('视频上传成功');
        console.log('上传数据保存成功', response);
        visible.value = false; // 关闭drawer
        // 清除表单
        fileList.value = [];
        description.value = '';
        categoryId.value = null;
        progress.value = 0;
      } catch (error) {
        console.error('上传数据保存失败', error);
      }
    },
  };
    var file = fileList.value[0].raw;
    if (textarea.value == '') {
      key.value = file.name;
      // console.log('liuuuuu', file);
    } else {
      key.value = file.name;
    }
    const observable = qiniu.upload(file, key.value, token.value, {}, { useCdnDomain: true, region: qiniu.region.z2 });
    const subscription = await observable.subscribe(observer);
    // 上传开始
    // subscription.unsubscribe() // 上传取消
    console.log('liu', fileList.value, subscription);
  }
  </script>