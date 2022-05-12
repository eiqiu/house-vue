<!--
 * @FileDescription: 我发布的房子
 * @Author: house-team
 * @Date: 2022/4/27
 * @LastEditors:
 * @LastEditTime: 2022/4/27
 -->
<template>
<div id="myHouse" class="myHouse">
  <div class="myHouse-header">
    <div class="myHouse-title">
      <i class="el-icon-s-home" style="color: #7a482a;"></i>
      我的房子
    </div>
  </div>
  <div class="content">
    <div class="myHouse-list" v-if="myHouseList.length>0">
      <MyList :list="myHouseList" :my-house="true"></MyList>
    </div>
    <!-- 没有发布房子 -->
    <div v-else class="myHouse-empty">
      <div class="empty">
        <h2>您还没有发布房子！</h2>
        <p>期待您将爱房上传至本网站，链家为您提供纯真的服务！</p>
      </div>
    </div>
    <!--  没有发布房子END -->
  </div>
</div>
</template>

<script>
export default {
  name: "MyHouse",
  data() {
    return{
      myHouseList: []
    }
  },
  activated() {
    // 获取收藏数据
    this.axios
        .post("/house/getMyHouse", {
          myHouse_user_id: this.$store.getters.getUser.user_id,
          pageNum: 1,
          pageSize: 10
        })
        .then(res => {
          if (res.data.code === 200) {
            this.myHouseList = res.data.data.list;
          }
        })
        .catch(err => {
          return Promise.reject(err);
        });
  }
}
</script>

<style scoped>
#myHouse {
  background-color: #f5f5f5;
}
#myHouse .myHouse-header {
  height: 64px;
  background-color: #fff;
  border-bottom: 2px solid #000000;
}
#myHouse .myHouse-header .myHouse-title {
  width: 1225px;
  margin: 0 auto;
  height: 64px;
  line-height: 58px;
  font-size: 28px;
}
#myHouse .content {
  padding: 20px 0;
  width: 1225px;
  margin: 0 auto;
}
#myHouse .content .myHouse-list {
  margin-left: -13.7px;
  overflow: hidden;
}
/* 收藏列表为空的时候显示的内容CSS */
#myHouse .myHouse-empty {
  width: 1225px;
  margin: 0 auto;
}
#myHouse .myHouse-empty .empty {
  height: 300px;
  padding: 0 0 130px 558px;
  margin: 65px 0 0;
  background: url(../assets/imgs/cart-empty.png) no-repeat 124px 0;
  color: #b0b0b0;
  overflow: hidden;
}
#myHouse .myHouse-empty .empty h2 {
  margin: 70px 0 15px;
  font-size: 36px;
}
#myHouse .myHouse-empty .empty p {
  margin: 0 0 20px;
  font-size: 20px;
}
/* 收藏列表为空的时候显示的内容CSS END */
</style>
