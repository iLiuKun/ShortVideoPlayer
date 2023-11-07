import request from '@/utils/request';

const BASE_API = '/video';

const sysVideoApi = {
  add(data) {
    return request({
      url: 'user' + '/uploadvideo',
      method: 'post',
      data: JSON.stringify(data),
    });
  },
  
  delete(params) {
    return request({
      url: BASE_API + '/delete',
      method: 'delete',
      params: params,
    });
  },
  getVideoList(categoryId) {
    return request({
      url: `${BASE_API}/category/${categoryId}`,
      method: 'get',
    });
  },
  getRecommedVideoList() {
    return request({
      url: `${BASE_API}/getrecommend`,
      method: 'get',
    });
  },
  getSearchVideos(keyword) {
    return request({
      url: `${BASE_API}/search`,
      method: 'get',
      params: { keyword: keyword }
    });
  },
  
};
export { sysVideoApi }