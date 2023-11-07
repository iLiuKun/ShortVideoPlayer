import request from '@/utils/request';

const BASE_API = '/user';

const sysUserApi = {
  login(data) {
    return request({
      url: 'user/login',
      method: 'post',
      data,
      // headers: {
      // },
    });
  },
  // 注销
  logout() {
    return request({
      url: '/web/api/auth/logout',
      method: 'delete',
    });
  },

  add(data) {
    return request({
      url: BASE_API,
      method: 'post',
      data,
    });
  },
  delete(id) {
    return request({
      url: BASE_API,
      method: 'delete',
      params: { userId: id },
    });
  },

  getUserInfoById(userId) {
    return request({
      url: BASE_API + '',
      method: 'get',
      params: {
        userId: userId,
      },
    });
  },
   // 获取关注列表
   getFollowsByUserId(userId) {
    return request({
      url: `${BASE_API}/followeds`,
      method: 'get',
      headers: { 'userId': userId },
    });
  },

  // 获取粉丝列表
  getFansByUserId(userId) {
    return request({
      url: `${BASE_API}/followers`,
      method: 'get',
      headers: { 'userId': userId },
    });
  },
  getVideosByUserId(userId) {
    return request({
      url: 'video/user',
      method: 'get',
      headers: { 'userId': userId },
    });
  },
  getFavoritesByUserId(userId) {
    return request({
      url: 'video/userfavorites',
      method: 'get',
      headers: { 'userId': userId },
    });
  },

  favoriteVideo(userId, videoId) {
    return request({
      url: `${BASE_API}/favorite/${videoId}`,
      method: 'post',
      headers: { 'userId': userId },
    });
  },

  // 取消收藏视频
unfavoriteVideo(userId, videoId) {
  return request({
    url: `${BASE_API}/unfavorite/${videoId}`,
    method: 'post',
    headers: { 'userId': userId },
  });
}
};

    
    
export { sysUserApi }
