<!--
 * @Description: 聊天界面，未开发
 * @Author: house-team
 * @Date: 2022/5/17
 * @LastEditors:
 * @LastEditTime: 2022/5/17
 -->
<template>
  <div class="chat">
    <div class="chat-content">
      <!-- recordContent 聊天记录数组-->
      <div v-for="(itemc,indexc) in recordContent" :key="indexc">
        <!-- 对方 -->
        <div class="word" v-if="!itemc.mineMsg">
          <img :src="itemc.headUrl">
          <div class="info">
            <p class="time">{{itemc.nickName}}  {{chatTime(itemc.timestamp)}}</p>
            <div class="info-content">{{itemc.contactText}}</div>
          </div>
        </div>
        <!-- 我的 -->
        <div class="word-my" v-else>
          <div class="info">
            <p class="time">{{itemc.nickName}}  {{chatTime(itemc.timestamp)}}</p>
            <div class="info-content">{{itemc.contactText}}</div>
          </div>
          <img :src="itemc.headUrl">
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  // eslint-disable-next-line vue/multi-word-component-names
  name: "Chat"
}
</script>

<style scoped>

</style>
