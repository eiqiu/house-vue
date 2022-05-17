import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'
import axios from "axios";
import VueAxios from "vue-axios";
import VueCookies from "vue-cookies"
import LemonIMUI from "lemon-imui";
import "lemon-imui/dist/index.css";
Vue.config.productionTip = false
Vue.use(ElementUI)
Vue.use(LemonIMUI)
Vue.use(VueAxios,axios)
Vue.use(VueCookies)
axios.defaults.baseURL = "http://localhost:8089/"

//  配置axios拦截器
axios.interceptors.request.use(config => {
  //  为请求头添加token验证的Authorization字段
  config.headers.token = window.$cookies.get('token')
  return config
})

//  配置response拦截器
axios.interceptors.response.use(config => {
  if (config.data.code === 422) {
    window.$cookies.remove('token')
    Vue.prototype.tokenAlert()
    router.push({name: 'login'})
  } else {
    return config
  }
})

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
