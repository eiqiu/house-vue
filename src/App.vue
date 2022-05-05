<!--
 * @Description: 项目的index
 * @Author: house-team
 * @Date: 2022/4/25
 * @LastEditors:
 * @LastEditTime: 2022/4/25
-->
<template>
  <div id="app">
    <el-container>
      <!-- 顶部导航-->
      <div class="topbar">
        <div class="nav">
          <ul>
<!--            用户是否登陆-->
            <li v-if="!this.$store.getters.getUser">
              <el-button type="text" @click="login">登录</el-button>
              <span class="sep">|</span>
              <el-button type="text" @click="register = true">注册</el-button>
            </li>
            <li v-else>
              <el-popover placement="top" width="180" v-model="visible">
                <p>确定退出登录吗？</p>
                <div style="text-align: right; margin: 10px 0 0">
                  <el-button size="mini" type="text" @click="visible = false">取消</el-button>
                  <el-button type="primary" size="mini" @click="logout">确定</el-button>
                </div>
                <el-button type="text" slot="reference">{{this.$store.getters.getUser.user_name}}</el-button>
              </el-popover>
              <span class="sep">|</span>
              <el-button type="text" @click="myInformation">我的信息</el-button>
            </li>
            <li>
              <router-link to="/collect">我的收藏</router-link>
            </li>
            <li>
              <router-link to="/sellHouse">发布房屋</router-link>
            </li>
            <li class="myHouse">
              <router-link to="/myHouse">
                <i class="el-icon-s-home"></i> 我的发布
              </router-link>
            </li>
          </ul>
        </div>
      </div>
<!--    顶部容器-->
    <el-header>
      <el-menu
          :default-active="activeIndex"
          class="el-menu-demo"
          mode="horizontal"
          active-text-color="#409eff"
          router
      >
        <div class="logo">
          <router-link to="/">
            <img src="./assets/imgs/logo.png" alt />
          </router-link>
        </div>
        <el-menu-item index="/">首页</el-menu-item>
        <el-menu-item index="/house">全部房型</el-menu-item>
        <el-menu-item index="/about">关于我们</el-menu-item>

        <div class="so">
          <el-input placeholder="请输入搜索内容" v-model="search">
            <el-button slot="append" icon="el-icon-search" @click="searchClick"></el-button>
          </el-input>
        </div>
      </el-menu>
    </el-header>
      <MyLogin></MyLogin>
      <MyInformation></MyInformation>
      <MyRegister :register="register" @fromChild="isRegister"></MyRegister>

    <!-- 主体部分-->
    <el-main>
      <keep-alive>
        <router-view/>
      </keep-alive>
    </el-main>

      <!-- 底栏容器 -->
      <el-footer>
        <div class="footer">
          <div class="ng-promise-box">
            <div class="ng-promise">
              <p class="text">
                <a class="icon1" href="javascript:">馨家租房</a>
                <a class="icon2" href="javascript:">请您放心</a>
                <a class="icon3" style="margin-right: 0" href="javascript:">住的安心</a>
              </p>
            </div>
          </div>
          <div class="mod_help">
            <p>
              <router-link to="/">首页</router-link>
              <span>|</span>
              <router-link to="/house">全部租房</router-link>
              <span>|</span>
              <router-link to="/about">关于我们</router-link>
            </p>
            <p class="coty">商城版权所有 &copy; 2022-2099</p>
          </div>
        </div>
      </el-footer>
    </el-container>
  </div>
</template>
<script>
import {mapActions} from "vuex";
import {mapGetters} from "vuex";
import MyInformation from "@/components/MyInformation";
export default {
  components: {MyInformation},
  beforeCreate() {
    this.activeIndex = this.$route.path;
    this.axios.post('/test',{
      user_name: 'admin123',
      user_password: 'password123456'
    }).then(res =>{
      if (res.data.code === 200) {
        this.setCategoryList(res.data.data);
      }
    })
  },
  data() {
    return {
      testList: [],
      activeIndex: "/", // 头部导航栏选中的标签
      search: "", // 搜索条件
      register: false, // 是否显示注册组件
      visible: false // 是否退出登录
    }
  },
  created() {
    // 获取浏览器localStorage，判断用户是否已经登录
    if (localStorage.getItem("user")){
      // 如果已经登录，设置vuex登录状态
      this.setUser(JSON.parse(localStorage.getItem("user")));
    }
  },
  computed: {
    ...mapGetters(["getUser", "getCategoryList"])
  },
  methods: {
    ...mapActions(["setUser", "setShowLogin", "setCategoryList", "setShowInformation"]),
    // 登陆
    login() {
      this.setShowLogin(true);
    },
    // 我的个人信息
    myInformation() {
      this.setShowInformation(true);
    },
    // 退出登录
    logout() {
      this.visible = false;
      // 清空本地登录信息
      localStorage.setItem("user", "");
      // 清空vuex登录信息
      this.setUser("");
      this.notifySucceed("成功退出登录");
    },
    // 接收注册子组件传过来的数据
    isRegister(val) {
      this.register = val;
    },
    // 点击搜索按钮
    searchClick() {
      if (this.search !== "") {
        // 跳转到全部商品页面,并传递搜索条件
        // 首先确定位置
        this.$router.push({ path: "/house", query: { search: this.search } });
        this.search = "";
      }
    }
  }
}
</script>
<style>
/* 全局CSS */
* {
  padding: 0;
  margin: 0;
  border: 0;
  list-style: none;
}
#app .el-header {
  padding: 0;
}
#app .el-main {
  min-height: 300px;
  padding: 20px 0;
}
#app .el-footer {
  padding: 0;
}
a,
a:hover {
  text-decoration: none;
}
/* 全局CSS END */

/* 顶部导航栏CSS */
.topbar {
  height: 40px;
  background-color: #3d3d3d;
  margin-bottom: 20px;
}
.topbar .nav {
  width: 1225px;
  margin: 0 auto;
}
.topbar .nav ul {
  float: right;
}
.topbar .nav li {
  float: left;
  height: 40px;
  color: #b0b0b0;
  font-size: 14px;
  text-align: center;
  line-height: 40px;
  margin-left: 20px;
}
.topbar .nav .sep {
  color: #b0b0b0;
  font-size: 12px;
  margin: 0 5px;
}
.topbar .nav li .el-button {
  color: #b0b0b0;
}
.topbar .nav .el-button:hover {
  color: #fff;
}
.topbar .nav li a {
  color: #b0b0b0;
}
.topbar .nav a:hover {
  color: #fff;
}
.topbar .nav .myHouse:hover a {
  color: #fff;
}
.topbar .nav .myHouse {
  width: 120px;
  background: #595656;
}
.topbar .nav .myHouse a {
  color: white;
}
/* 顶部导航栏CSS END */

/* 顶栏容器CSS */
.el-header .el-menu {
  max-width: 1225px;
  margin: 0 auto;
}
.el-header .logo {
  height: 60px;
  width: 189px;
  float: left;
  margin-right: 100px;
}
.el-header .so {
  margin-top: 10px;
  width: 300px;
  float: right;
}
/* 顶栏容器CSS END */

/* 底栏容器CSS */
.footer {
  width: 100%;
  text-align: center;
  background: #2f2f2f;
  padding-bottom: 20px;
}
.footer .ng-promise-box {
  border-bottom: 1px solid #3d3d3d;
  line-height: 145px;
}
.footer .ng-promise-box {
  margin: 0 auto;
  border-bottom: 1px solid #3d3d3d;
  line-height: 145px;
}
.footer .ng-promise-box .ng-promise p a {
  color: #fff;
  font-size: 20px;
  margin-right: 210px;
  padding-left: 44px;
  height: 40px;
  display: inline-block;
  line-height: 40px;
  text-decoration: none;
  background: url("./assets/imgs/us-icon.png") no-repeat left 0;
}
.footer .mod_help {
  text-align: center;
  color: #888888;
}
.footer .mod_help p {
  margin: 20px 0 16px 0;
}

.footer .mod_help p a {
  color: #888888;
  text-decoration: none;
}
.footer .mod_help p a:hover {
  color: #fff;
}
.footer .mod_help p span {
  padding: 0 22px;
}
/* 底栏容器CSS END */
</style>
