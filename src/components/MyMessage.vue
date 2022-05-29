<!--
 * @FileDescription: 描述
 * @Author: house-team
 * @Date: 2022/5/26
 * @LastEditors:
 * @LastEditTime: 2022/5/26
 -->
<template>
  <div id="myMessage" class="myMessage">
    <el-dialog title="我的消息" width="500px" :visible.sync="isMessage">
      <p v-if="messageList.length === 0">您的消息列表为空！</p>
        <ul v-for="item in messageList" :key="item.message_id">
          <li>
            <h3 style="color: black">{{item.message_time | dateFormat}}</h3>
              {{item.message_content}}
            <i v-if="item.message_state === 2" class="el-icon-circle-check" style="float: right;color: green;"/>
            <i v-if="item.message_state === 1" class="el-icon-bell" style="float: right;color: red;"/>
            <div class="messageLine"></div>
          </li>
        </ul>
    </el-dialog>
  </div>
</template>

<script>
import { mapActions } from "vuex";
export default {
  name: "MyMessage",
  props:["messageList"],
  data() {
    return {};
  },
  computed: {
    isMessage: {
      get() {
        return this.$store.getters.getShowMessage;
      },
      set(val) {
        this.setShowMessage(val);
      }
    }
  },
  methods: {
    ...mapActions(["setShowMessage"]),
    formatDate(data) {
      let datetime = data;
      if (datetime) {
        datetime = new Date(datetime);
        let y = datetime.getFullYear() + "-";
        let mon = (datetime.getMonth() + 1).toString().padStart(2, "0") + "-";
        let d = datetime.getDate().toString().padStart(2, "0");
        return y + mon + d;
      }
      return "";
    }
  }
}
</script>

<style scoped>
.myMessage ul{
  padding-left: 30px;
}
.myMessage ul li {
  width: 400px;
  height: 50px;
  margin-right: 13px;
  margin-bottom: 13px;
  float: top;
}
.myMessage ul li .messageLine{
  background-color: #fff;
  border-bottom: 2px solid #000000;
}
</style>
