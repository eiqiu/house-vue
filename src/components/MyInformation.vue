<!--
 * @FileDescription: 描述
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
            <el-cascader style="width: 200px" v-model="UserInformation.user_address" :options="citydata" :props="{ expandTrigger: 'hover' }"></el-cascader>
          </el-form-item>
        </el-col>
        <el-col :span="10">
          &nbsp;&nbsp;&nbsp;<el-input v-model="UserInformation.user_address_detail" style="width: 200px"></el-input>
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
        <el-upload
            class="avatar-uploader"
            action=""
            :http-request="httpRequest"
            :show-file-list="false"
            :on-success="handleAvatarSuccess"
            :before-upload="beforeAvatarUpload">
          <img v-if="imageUrl" :src="imageUrl" class="avatar">
          <i v-else class="el-icon-plus avatar-uploader-icon"></i>
        </el-upload>
      </el-form-item>
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
    this.UserInformation.user_address = adddress.slice(0,3);
    this.UserInformation.user_address_detail = adddress.pop();
    this.UserInformation.user_age = user.user_age;
    this.UserInformation.user_name = user.user_name;
    this.UserInformation.user_tel = user.user_tel;
    this.UserInformation.user_sex = user.user_sex;
  },
  data () {
    return{
      UserInformation: {
        user_name: '',
        user_address: [],
        user_address_detail: '',
        user_sex: '',
        user_tel: '',
        user_age: 0,
      },
      rules: {},
      citydata,
      imageUrl: ''
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
          this.axios.post("/user/modifyInformation",this.UserInformation)
          .then(res => {
            if (res.data.code === 200){
              this.isInformation = false;
              this.notifySucceed(res.data.msg);
            }
          }).catch(err => {
            return new Promise.reject(err);
          });
    },
    httpRequest(file) {
      console.log("http")
      console.log(file)
    },
    handleAvatarSuccess(res, file) {
      console.log("res")
      console.log(file)
      this.imageUrl = URL.createObjectURL(file.raw);
    },
    beforeAvatarUpload(file) {
      const isJPG = file.type === 'image/jpeg';
      const isLt2M = file.size / 1024 / 1024 < 2;

      if (!isJPG) {
        this.$message.error('上传头像图片只能是 JPG 格式!');
      }
      if (!isLt2M) {
        this.$message.error('上传头像图片大小不能超过 2MB!');
      }
      return isJPG && isLt2M;
    }
  }
}
</script>

<style scoped>
.avatar-uploader .el-upload {
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}
.avatar-uploader .el-upload:hover {
  border-color: #409EFF;
}
.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 178px;
  height: 178px;
  line-height: 178px;
  text-align: center;
}
.avatar {
  width: 178px;
  height: 178px;
  display: block;
}
</style>
