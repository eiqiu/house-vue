<!--
 * @FileDescription: 描述
 * @Author: house-team
 * @Date: 2022/4/29
 * @LastEditors:
 * @LastEditTime: 2022/4/29
 -->
<template>
  <div>
    <el-carousel height="460px">
      <el-carousel-item v-for="item in carousel" :key="item.category_id">
        <img style="height:460px;" :src="$target + item.imgPath" :alt="item.describes" />
      </el-carousel-item>
    </el-carousel>
  </div>
</template>

<script>
export default {
  name: "TestImg",
  data() {
    return{
      carousel: [
        {
          category_id: 1,
          imgPath: 'img01.png',
          describes: '1'
        },
        {
          category_id: 2,
          imgPath: 'img02.png',
          describes: '2'
        },
        {
          category_id: 3,
          imgPath: 'img03.png',
          describes: '3'
        }
      ], // 轮播图数据
    }
  }
}
</script>

<style scoped>

</style>
