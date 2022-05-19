import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'
import axios from "axios";
import VueAxios from "vue-axios";
import VueCookies from "vue-cookies"
Vue.config.productionTip = false
Vue.use(ElementUI)
Vue.use(VueAxios,axios)
Vue.use(VueCookies)
axios.defaults.baseURL = "http://localhost:8089/"

// 封装提示成功的弹出框
Vue.prototype.notifySucceed = function (msg) {
  this.$notify({
    title: "成功",
    message: msg,
    type: "success",
    offset: 100
  });
};
// 封装提示失败的弹出框
Vue.prototype.notifyError = function (msg) {
  this.$notify.error({
    title: "错误",
    message: msg,
    offset: 100
  });
};
Vue.prototype.$target = "http://localhost:8089/";

// 全局拦截器，验证用户是否已登陆
router.beforeResolve((to, from, next) => {
  const loginUser = store.state.user.user;
  if (to.meta.requireAuth) {
    if (!loginUser) {
      // 没有登录，显示登录组件
      store.dispatch("setShowLogin", true);
      if (from.name == null) {
        //此时，是在页面没有加载，直接在地址栏输入链接，进入需要登录验证的页面
        next("/");
        return;
      }
      // 终止导航
      next(false);
      return;
    }
  }
  next();
});

// 全局组件
import MyLogin from "@/components/MyLogin";
Vue.component(MyLogin.name, MyLogin)
import MyRegister from "@/components/MyRegister";
Vue.component(MyRegister.name, MyRegister)
import MyList from "@/components/MyList";
Vue.component(MyList.name, MyList)
import MyMenu from "@/components/MyMenu";
Vue.component(MyMenu.name, MyMenu)
new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
