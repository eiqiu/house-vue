<!--
 * @Description: 登录组件
 * @Author: house-team
 * @Date: 2022/4/25
 * @LastEditors:
 * @LastEditTime: 2022/4/25
 -->
<template>
  <div id="myLogin">
    <el-dialog title="登录" width="300px" center :visible.sync="isLogin">
      <el-form :model="LoginUser" :rules="rules" status-icon ref="ruleForm" class="demo-ruleForm">
        <el-form-item prop="account">
          <el-input prefix-icon="el-icon-user-solid" placeholder="请输入账号" v-model="LoginUser.account"></el-input>
        </el-form-item>
        <el-form-item prop="password">
          <el-input
              prefix-icon="el-icon-view"
              type="password"
              placeholder="请输入密码"
              v-model="LoginUser.password"
          ></el-input>
        </el-form-item>
        <el-form-item>
          <el-button size="medium" type="primary" @click="Login" style="width:100%;">登录</el-button>
        </el-form-item>
      </el-form>
    </el-dialog>
  </div>
</template>
<script>
import { mapActions } from "vuex";

export default {
  name: "MyLogin",
  data() {
    // 用户名的校验方法
    let validateAccount = (rule, value, callback) => {
      if (!value) {
        return callback(new Error("请输入用户名"));
      }
      // 用户名为手机号
      const userAccountRule = /^(13[0-9]|14[0-9]|15[0-9]|16[0-9]|17[0-9]|18[0-9]|19[0-9])\d{8}$/;
      if (userAccountRule.test(value)) {
        return callback();
      } else {
        return callback(new Error("请输入正确的手机号！"));
      }
    };
    // 密码的校验方法
    let validatePass = (rule, value, callback) => {
      if (value === "") {
        return callback(new Error("请输入密码"));
      }
      // 密码以字母开头,长度在6-18之间,允许字母数字和下划线
      const passwordRule = /^[a-zA-Z]\w{5,17}$/;
      if (passwordRule.test(value)) {
        return callback();
      } else {
        return callback(
            new Error("字母开头,长度6-18之间,允许字母数字和下划线")
        );
      }
    };
    return {
      LoginUser: {
        account: "",
        password: ""
      },
      // 用户信息校验规则,validator(校验方法),trigger(触发方式),blur为在组件 Input 失去焦点时触发
      rules: {
        account: [{validator: validateAccount, trigger: "blur"}],
        password: [{validator: validatePass, trigger: "blur"}],
      },
    };
  },
  computed: {
    // 获取vuex中的showLogin，控制登录组件是否显示
    isLogin: {
      get() {
        return this.$store.getters.getShowLogin;
      },
      set(val) {
        this.$refs["ruleForm"].resetFields();
        this.setShowLogin(val);
      }
    }
  },
  methods: {
    ...mapActions(["setUser", "setShowLogin"]),
    Login() {
      // 通过element自定义表单校验规则，校验用户输入的用户信息
      this.$refs["ruleForm"].validate(valid => {
        //如果通过校验开始登录
        if (valid) {
          this.axios
              .post("/user/login", {user_account: this.LoginUser.account, user_password: this.LoginUser.password})
              .then(res => {
                // “200”代表登录成功，其他的均为失败
                if (res.data.code === 200) {
                  // 隐藏登录组件
                  this.isLogin = false;
                  // 登录信息存到本地
                  let user = JSON.stringify(res.data.data);
                  localStorage.setItem("user", user);
                  // 登录信息存到vuex
                  this.setUser(res.data.data);
                  // 弹出通知框提示登录成功信息
                  this.notifySucceed(res.data.msg);
                } else {
                  // 弹出通知框提示登录失败信息
                  this.notifyError(res.data.msg);
                }
              })
              .catch(err => {
                return Promise.reject(err);
              });
        } else {
          return false;
        }
      });
    }
  }
};
</script>
<style>
</style>
