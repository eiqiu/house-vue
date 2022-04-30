<!--
 * @FileDescription: 文件上传测试
 * @Author: house-team
 * @Date: 2022/4/29
 * @LastEditors:
 * @LastEditTime: 2022/4/29
 -->
<template>
<div>
    <el-upload
        action="https://localhost:8089/upload"
        list-type="picture-card"
        :on-preview="handlePictureCardPreview"
        :on-remove="handleRemove"
        :http-request="test">
      <i class="el-icon-plus"></i>
    </el-upload>
    <el-dialog :visible.sync="dialogVisible">
      <img width="100%" :src="dialogImageUrl" alt="">
    </el-dialog>
</div>
</template>

<script>
export default {
  name: 'TestUpload',
  data() {
    return {
      dialogImageUrl: '',
      dialogVisible: false
    };
  },
  methods: {
    test () {

    },
    handleRemove(file, fileList) {
      console.log(file, fileList);
    },
    handlePictureCardPreview(file) {
      this.dialogImageUrl = file.url;
      this.dialogVisible = true;
    }
  }
}
</script>

<style scoped>

</style>
