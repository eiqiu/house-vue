<!--
 * @FileDescription: 描述
 * @Author: house-team
 * @Date: 2022/5/5
 * @LastEditors:
 * @LastEditTime: 2022/5/5
 -->
<template>
  <div class="error">
    <div class="main"></div>
  </div>
</template>
<script>
export default {
  // eslint-disable-next-line vue/multi-word-component-names
  name: 'Error'
}
</script>
<style>
.error {
  height: 500px;
  width: 1225px;
  margin: 0 auto;
}
.error .main {
  margin: 0 362.5px;
  height: 500px;
  background: url(../assets/imgs/error.png) no-repeat;
}
</style>
