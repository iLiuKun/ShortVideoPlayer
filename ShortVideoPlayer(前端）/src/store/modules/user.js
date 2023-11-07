import { defineStore } from 'pinia';
import { sysUserApi } from '../../api/user/user';
import { ref } from 'vue'
const initialState = () => ({
    isLogin: false,
    token: '',
    userInfo: {
        userId: '',
        username: '',
        avatar_url: '',
    },
});
export const useUserStore = defineStore('user', () => {

    let state = ref(initialState());
    let isLogin = ref(false);
    let token = ref('');
    let userInfo = ref({
        userId: '',
        username: '',
        avatar_url: '',
        // ... 可能还有其他字段
    });
    // 登录
    async function login(username, password) {
        if (isLogin.value) {
            return;
        }

        let result = await sysUserApi.login({
            username: username,
            password: password,
        }); //失败情况未处理

        if (result && result.data.code == 20000) {
            userInfo.value.userId = result.data.data.userId;
            userInfo.value.username = result.data.data.username;
            userInfo.value.avatar_url = result.data.data.avatar_url;

            sessionStorage.setItem('isLogin', 'true');
            sessionStorage.setItem('userInfo', JSON.stringify(userInfo.value));

        }
        
        return result.data;
        // token.value = result.data;
        // getUserInfoById(userId);

    }

    // 退出登录
    function logout() {
        
        Object.assign(state.value, initialState());
        window.localStorage.clear();
        window.sessionStorage.clear();
        location.reload(); // 强制刷新页面
    }

    // 获取用户信息
    // async function getUserInfoById(userId) {
    //     let result = await sysUserApi.getUserInfoById(userId);
    //     userInfo.value = result.data;
    // }

    return { isLogin, login, logout, userInfo,state };
});
// 你可以对 `defineStore()` 的返回值进行任意命名，但最好使用 store 的名字，同时以 `use` 开头且以 `Store` 结尾。(比如 `useUserStore`，`useCartStore`，`useProductStore`)
// 第一个参数是你的应用中 Store 的唯一 ID。
export const useCounterStore = defineStore('counter', {
    state: () => ({
        token: '',
        userInfo: {},
        isLogin: false,
    }),
    getters: {
        double: (state) => state.isLogin * 2,
    },
    actions: {
        async getUserInfo() {
            let result = await sysUserApi.getUserInfo();
            userInfo = result.data;
        },
        async login(username, password) {
            if (this.isLogin) {
                return;
            }
            let result = await sysUserApi.login({
                username: username,
                password: password,
            });
            isLogin = true;
            token = result.data;
            getUserInfo();
        },

    },
});