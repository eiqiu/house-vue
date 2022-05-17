<!--
 * @Description: 描述
 * @Author: house-team
 * @Date: 2022/5/5
 * @LastEditors:
 * @LastEditTime: 2022/5/5
 -->
<template>
<div id="myInformation">
  <el-dialog title="我的信息" width="600px" center :visible.sync="isInformation">
    <el-form :model="UserInformation" :rules="rules" ref="ruleForm">
      <el-row>
        <el-col :span="14">
          <el-form-item label="姓名：">
            <el-input  v-model="UserInformation.user_name" style="width: 200px"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="10">
          <el-form-item label="性别：">
            <el-radio v-model="UserInformation.user_sex" label="男">男</el-radio>
            <el-radio v-model="UserInformation.user_sex" label="女">女</el-radio>
          </el-form-item>
        </el-col>
      </el-row>
      <el-row>
        <el-col :span="14">
          <el-form-item label="地址：">
            <el-cascader style="width: 200px" v-model="user_address" :options="citydata" :props="{ expandTrigger: 'hover' }"></el-cascader>
          </el-form-item>
        </el-col>
        <el-col :span="10">
          &nbsp;&nbsp;&nbsp;<el-input v-model="user_address_detail" style="width: 200px"></el-input>
        </el-col>
      </el-row>
      <el-row>
        <el-col :span="12">
          <el-form-item label="年龄：">
            <el-input  v-model="UserInformation.user_age" style="width: 200px"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="电话：">
            <el-input  v-model="UserInformation.user_tel" style="width: 200px"></el-input>
          </el-form-item>
        </el-col>
      </el-row>
      <el-form-item>
        <el-button size="medium" type="primary" @click="Modify" style="width:100%;">修改</el-button>
      </el-form-item>
    </el-form>
  </el-dialog>
</div>
</template>

<script>
import citydata from "@/assets/cityDate/citydata";
import { mapActions } from "vuex";
export default {
  name: "MyInformation",
  created() {
    let user = this.$store.getters.getUser;
    let adddress = user.user_address.split(",");
    this.user_address = adddress.slice(0,3);
    this.user_address_detail = adddress.pop();
    this.UserInformation.user_age = user.user_age;
    this.UserInformation.user_name = user.user_name;
    this.UserInformation.user_tel = user.user_tel;
    this.UserInformation.user_sex = user.user_sex;
  },
  data () {
    return{
      user_address: [],
      user_address_detail: '',
      UserInformation: {
        user_id: '',
        user_name: '',
        user_address: '',
        user_sex: '',
        user_tel: '',
        user_age: 0,
      },
      rules: {},
      citydata,
    }
  },
  computed: {
    isInformation: {
      get() {
        return this.$store.getters.getShowInformation;
      },
      set(val) {
        this.setShowInformation(val);
      }
    }
  },
  methods: {
    ...mapActions(["setShowInformation", "setUser"]),
    // 修改信息
    Modify() {
      let address = "";
      for (var i = 0; i <this.user_address.length; i++) {
        address += this.user_address[i]+",";
      }
      address += this.user_address_detail;
      this.UserInformation.user_address = address;
      this.UserInformation.user_id = this.$store.getters.getUser.user_id;
      this.axios.post("/user/modifyUser",this.UserInformation)
          .then(res => {
            if (res.data.code === 200){
              this.isInformation = false;
              this.notifySucceed(res.data.msg);
              // 清除之前的信息
              let user = JSON.stringify(res.data.data);
              localStorage.setItem("user",user);
              this.setUser(res.data.data);
            }
          }).catch(err => {
        return new Promise.reject(err);
      });
    }
  }
}
</script>

<style scoped>

</style>
