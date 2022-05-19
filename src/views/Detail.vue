<!--
 * @Description: 商品详情页面组件
 * @Author: house-team
 * @Date: 2022/4/25
 * @LastEditors:
 * @LastEditTime: 2022/4/25
 -->
<template>
  <div id="details">
    <!-- 头部 -->
    <div class="page-header">
      <div class="title">
        <p>{{houseDetails.house_title}}</p>
      </div>
    </div>
    <!-- 头部END -->
    <!-- 主要内容 -->
    <div class="main">
      <!-- 左侧房屋轮播图 -->
      <div class="block">
        <el-carousel height="560px">
          <el-carousel-item v-for="item in houseDetails.pictures" :key="item.picture_id">
            <img style="height:560px;" :src="$target + item.src" />
          </el-carousel-item>
        </el-carousel>
      </div>
      <!-- 左侧商品轮播图END -->

      <!-- 右侧内容区 -->
      <div class="content">
        <h1 class="name">{{houseDetails.house_address}}</h1>
        <p class="intro">{{houseDetails.house_description}}</p>
        <p class="store" v-if="houseDetails.bargain === true"><i class="el-icon-circle-check"></i>可议价</p>
        <p class="store" v-else><i class="el-icon-circle-close"></i>不可议价</p>
        <div class="price">
          <span class="total-price">总价：{{houseDetails.house_price}}万元</span>
        </div>
        <div class="house-list">
          <span class="pro-name"><i class="el-icon-user"></i>{{houseDetails.user_name}}</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <span class="pro-name"><i class="el-icon-phone"></i>{{houseDetails.user_tel}}</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <span class="pro-name"><i class="el-icon-map-location"></i>{{houseDetails.user_address}}</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <p class="price-sum"></p>
          <span><i class="el-icon-view"></i>{{houseDetails.viewing_time}}</span>
        </div>
        <!-- 内容区底部按钮 -->
        <div class="button">
          <el-button class="contact" @click="contact">立即联系</el-button>
          <el-button v-if="this.dis === false" class="like" @click="addCollect">收藏</el-button>
          <el-button v-else class="like" @click="removeCollect">取消收藏</el-button>
        </div>
        <!-- 内容区底部按钮END -->
        <div class="pro-policy">
          <ul>
            <li>
              <i class="el-icon-circle-check"></i> 链家保证
            </li>
            <li>
              <i class="el-icon-circle-check"></i> 让您放心
            </li>
            <li>
              <i class="el-icon-circle-check"></i> 专业人士
            </li>
            <li>
              <i class="el-icon-circle-check"></i> 买的放心
            </li>
          </ul>
        </div>
      </div>
      <!-- 右侧内容区END -->
    </div>
    <!-- 主要内容END -->
    <!-- 底部详细内容区 -->
    <div class="base-info">
      <el-descriptions title="详细信息" :column="4" border>
        <el-descriptions-item label="类型">{{this.houseDetails.house_type}}</el-descriptions-item>
        <el-descriptions-item label="面积">{{ this.houseDetails.house_area }}</el-descriptions-item>
        <el-descriptions-item label="户型" :span="2">{{ this.houseDetails.house_type }}</el-descriptions-item>
        <el-descriptions-item label="户型结构">{{ this.houseDetails.house_structure }}</el-descriptions-item>
        <el-descriptions-item label="建筑类型">{{ this.houseDetails.building_type }}</el-descriptions-item>
        <el-descriptions-item label="建筑结构">{{ this.houseDetails.building_structure }}</el-descriptions-item>
        <el-descriptions-item label="房屋朝向">{{ this.houseDetails.house_towards }}</el-descriptions-item>
        <el-descriptions-item label="装修情况">{{ this.houseDetails.house_decoration }}</el-descriptions-item>
        <el-descriptions-item label="梯户比例">{{ this.houseDetails.house_ladder }}</el-descriptions-item>
        <el-descriptions-item label="供暖方式">{{ this.houseDetails.heating_mode }}</el-descriptions-item>
        <el-descriptions-item label="是否配备电梯">{{ this.houseDetails.elevator }}</el-descriptions-item>
        <el-descriptions-item label="交通出行" :span="4">{{ this.houseDetails.transportation }}</el-descriptions-item>
        <el-descriptions-item label="周边设施" :span="4">{{ this.houseDetails.surrounding_facilities }}</el-descriptions-item>
      </el-descriptions>
    </div>
    <!-- 底部详细内容区END -->
  </div>
</template>
<script>
export default {
  // eslint-disable-next-line vue/multi-word-component-names
  name: 'Detail',
  data() {
    return {
      dis: false, // 检查是否是已收藏，默认是false
      houseID: "", // 商品id
      houseDetails: "", // 商品详细信息
    };
  },
  // 通过路由获取商品id
  activated() {
    this.backTop();
    if (this.$route.query.houseID !== undefined) {
      this.houseID = this.$route.query.houseID;
    }
    if (!this.$store.getters.getUser){
      this.dis = true;
    }else {
      this.ifCollected();
    }
    this.axios.post("/house/addClick",{house_id: this.houseID});
  },
  watch: {
    // 监听商品id的变化，请求后端获取商品数据
    houseID: function(val) {
      this.getDetails(val);
    }
  },
  methods: {
    // 返回顶部
    backTop() {
      const timer = setInterval(function() {
        const top = document.documentElement.scrollTop || document.body.scrollTop;
        const speed = Math.floor(-top / 5);
        document.documentElement.scrollTop = document.body.scrollTop =
            top + speed;

        if (top === 0) {
          clearInterval(timer);
        }
      }, 20);
    },
    // 获取房子详细信息
    getDetails(val) {
      this.axios
          .post("/house/getHouseByID", {house_id: val})
          .then(res => {
            this.houseDetails = res.data.data;
          })
          .catch(err => {
            return Promise.reject(err);
          });
    },
    // 收藏
    addCollect() {
      // 判断是否登录,没有登录则显示登录组件
      if (!this.$store.getters.getUser) {
        this.$store.dispatch("setShowLogin", true);
        return;
      }
      this.axios
          .post("/house/addCollection", {
            user_id: this.$store.getters.getUser.user_id,
            house_id: this.houseID
          })
          .then(res => {
            if (res.data.code === 200) {
              // 添加收藏成功
              this.notifySucceed(res.data.msg);
              this.dis = true;
            } else {
              // 添加收藏失败
              this.notifyError(res.data.msg);
            }
          })
          .catch(err => {
            return Promise.reject(err);
          });
    },
    // 取消收藏
    removeCollect(){
      this.axios.post('/house/deleteCollection',{
        user_id: this.$store.getters.getUser.user_id,
        house_id: this.houseID
      }).then(res => {
        if (res.data.code === 200) {
          // 取消收藏成功
          this.notifySucceed(res.data.msg);
          this.dis = false;
        } else {
          // 取消收藏失败
          this.notifyError(res.data.msg);
        }
      }).catch(err => {
        return Promise.reject(err);
      })
    },
    // 判断是否在用户的收藏里面
    ifCollected() {
      this.axios.post('/house/ifCollected',{
        user_id: this.$store.getters.getUser.user_id,
        house_id: this.houseID
      }).then(res => {
        this.dis = res.data.data;
      }).catch(err => {
        return Promise.reject(err);
      })
    },
    contact() {
      this.notifySucceed("功能还未完善");
    }
  }
};
</script>
<style>
/* 头部CSS */
#details .page-header {
  height: 64px;
  margin-top: -20px;
  z-index: 4;
  background: #fff;
  border-bottom: 1px solid #e0e0e0;
  -webkit-box-shadow: 0px 5px 5px rgba(0, 0, 0, 0.07);
  box-shadow: 0px 5px 5px rgba(0, 0, 0, 0.07);
}
#details .page-header .title {
  width: 1225px;
  height: 64px;
  line-height: 64px;
  font-size: 18px;
  font-weight: 400;
  color: #212121;
  margin: 0 auto;
}
#details .page-header .title p {
  float: left;
}
#details .page-header .title .list {
  height: 64px;
  float: right;
}
#details .page-header .title .list li {
  float: left;
  margin-left: 20px;
}
#details .page-header .title .list li a {
  font-size: 14px;
  color: #616161;
}
#details .page-header .title .list li a:hover {
  font-size: 14px;
  color: #ff6700;
}
/* 头部CSS END */

/* 主要内容CSS */
#details .main {
  width: 1225px;
  height: 560px;
  padding-top: 30px;
  margin: 0 auto;
}
#details .main .block {
  float: left;
  width: 560px;
  height: 560px;
}
#details .main .content {
  float: left;
  margin-left: 25px;
  width: 640px;
}
#details .main .content .name {
  height: 30px;
  line-height: 30px;
  font-size: 24px;
  font-weight: normal;
  color: #212121;
}
#details .main .content .intro {
  color: #b0b0b0;
  padding-top: 10px;
}
#details .main .content .store {
  height: 30px;
  line-height: 30px;
  color: #ff6700;
  padding-top: 10px;
}
#details .main .content .price {
  display: block;
  font-size: 18px;
  border-bottom: 1px solid #e0e0e0;
  padding: 25px 0 25px;
}
#details .main .content .price .total-price{
  font-size: 20px;
  font-weight: bold;
}
#details .main .content .house-list {
  background: #f9f9fa;
  padding: 30px 60px;
  margin: 50px 0 50px;
}
#details .main .content .house-list span {
  line-height: 30px;
  color: #616161;
}
#details .main .content .house-list .price-sum {
  color: #ff6700;
  font-size: 24px;
  padding-top: 20px;
}
#details .main .content .button {
  height: 55px;
  margin: 10px 0 20px 0;
}
#details .main .content .button .el-button {
  float: left;
  height: 55px;
  font-size: 16px;
  color: #fff;
  border: none;
  text-align: center;
}
#details .main .content .button .contact {
  width: 340px;
  background-color: #ff6700;
}
#details .main .content .button .contact:hover {
  background-color: #f25807;
}
#details .main .content .button .like {
  width: 260px;
  margin-left: 40px;
  background-color: #b0b0b0;
}
#details .main .content .button .like:hover {
  background-color: #757575;
}
#details .main .content .pro-policy li {
  float: left;
  margin-right: 20px;
  color: #b0b0b0;
}
/* 主要内容CSS END */
/* 详细内容CSS */
#details el-descriptions{
  background-color: #212121;
}
#details .base-info{
  margin-top: 40px;
  margin-left: 100px;
  margin-right: 100px;
}
/* 详细内容CSS END */
</style>
