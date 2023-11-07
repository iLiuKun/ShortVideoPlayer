import { createRouter, createWebHistory } from 'vue-router';

// 引入你的页面组件
import CategoryEmotion from '@/views/category/emotion.vue';
import CategoryEntertainment from '@/views/category/entertainment.vue';
import CategorySports from '@/views/category/sports.vue';
import CategoryScenery from '@/views/category/scenery.vue';
import CategoryFunny from '@/views/category/funny.vue';
import Login from '@/views/login/index.vue';
import Profile from '@/views/profile/profile.vue';
import Recommend from '@/views/recommend/index.vue';
import index from '@/views/index/index.vue'
const routes = [
  {
    path: '/index',
    name: 'index',
    component: index,
  },
  {
    path: '/category/emotion',
    name: 'Category',
    component: CategoryEmotion,
  },
  {
    path: '/category/entertainment',
    name: 'CategoryEntertainment',
    component: CategoryEntertainment,
  },
  {
    path: '/category/sports',
    name: 'CategorySports',
    component: CategorySports,
  },
  {
    path: '/category/scenery',
    name: 'CategoryScenery',
    component: CategoryScenery,
  },
  {
    path: '/category/funny',
    name: 'CategoryFunny',
    component: CategoryFunny,
  },
  {
    path: '/login',
    name: 'Login',
    component: Login,
  },
  {
    path: '/profile',
    name: 'Profile',
    component: Profile,
  },
  {
    path: '/recommend',
    name: 'Recommend',
    component: Recommend,
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;
