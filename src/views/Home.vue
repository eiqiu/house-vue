<!--
 * @Description: 首页组件
 * @Author: house-team
 * @Date: 2022/4/25
 * @LastEditors:
 * @LastEditTime: 2022/4/25
 -->
<template>
  <div class="home" id="home" name="home">
    <!-- 轮播图 -->
    <div class="block">
      <el-carousel height="460px">
        <el-carousel-item v-for="item in carousel" :key="item.carousel_id">
          <img style="height:460px;" :src="item.imgPath" :alt="item.describes" />
        </el-carousel-item>
      </el-carousel>
    </div>
    <!-- 轮播图END -->
    <div class="main-box">
      <div class="main">
        <!-- 二手房区域 -->
        <div class="appliance" id="promo-menu">
          <div class="box-hd">
            <div class="title">精品待售房</div>
            <div class="more" id="more">
              <MyMenu :val="3" @fromChild="getChildMsg">
                <span slot="1">热门</span>
                <span slot="2">学区房</span>
                <span slot="3">医院房</span>
              </MyMenu>
            </div>
          </div>
          <div class="box-bd">
            <div class="promo-list">
              <ul>
                <li>
                  <img src="../assets/imgs/secondhandHouse1.jpg" alt="图片区域"/>
                </li>
                <li>
                  <img src="../assets/imgs/secondhandHouse1.jpg" alt="图片区域"/>
                </li>
              </ul>
            </div>
            <div class="list">
              <MyList :list="houseList" :isMore="true"></MyList>
            </div>
          </div>
        </div>
        <!-- 二手房区域end -->
      </div>
    </div>
  </div>
</template>

<script>
export default {
  // eslint-disable-next-line vue/multi-word-component-names
  name: 'Home',
  created() {
    // 获取房数据
    this.carousel = [
      {
        carousel_id: 1,
        imgPath: require('../assets/imgs/xinjia.png'),
        describes: '房子1'
      },
      {
        carousel_id: 2,
        imgPath: require('../assets/imgs/xinjia2.png'),
        describes: '房子2'
      }
    ];
    this.houseList = [
      {
        house_id: 1,
        category_id: 1,
        house_title: '吉房出租',
        house_price: 36.5,
        house_address: '莱山区开心小区',
        house_sort: '学区房',
        house_picture: require("../assets/imgs/img01.png")
      },
      {
        house_id: 2,
        category_id: 2,
        house_title: '吉房出租',
        house_price: 75,
        house_address: '莱山区快乐小区',
        house_sort: '医院房',
        house_picture: require("../assets/imgs/img01.png")
      },
      {
        house_id: 3,
        category_id: 1,
        house_title: '吉房出租',
        house_price: 75,
        house_address: '莱山区快乐小区',
        house_sort: '医院房',
        house_picture: require("../assets/imgs/img01.png")
      },
      {
        house_id: 4,
        category_id: 1,
        house_title: '吉房出租',
        house_price: 75,
        house_address: '莱山区快乐小区',
        house_sort: '医院房',
        house_picture: require("../assets/imgs/img01.png")
      },{
        house_id: 5,
        category_id: 1,
        house_title: '吉房出租',
        house_price: 75,
        house_address: '莱山区快乐小区',
        house_sort: '医院房',
        house_picture: require("../assets/imgs/img01.png")
      },{
        house_id: 6,
        category_id: 1,
        house_title: '吉房出租',
        house_price: 75,
        house_address: '莱山区快乐小区',
        house_sort: '医院房',
        house_picture: require("../assets/imgs/img01.png")
      },{
        house_id: 7,
        category_id: 1,
        house_title: '吉房出租',
        house_price: 75,
        house_address: '莱山区快乐小区',
        house_sort: '医院房',
        house_picture: require("../assets/imgs/img01.png")
      }
    ]
    this.getHouse("allHouse","houseList");
    this.getHouse("hotHouse","hotHouseList");
  },
  data() {
    return {
      carousel: "", // 轮播图数据
      houseList: "", // 二手房列表
      hotHouseList: "", // 热门二手房列表
      schoolHouseList: "", // 学区房列表
      hospitalHouseList: "",// 医院房
      houseActive: 1, // 选中的房屋分类
    }
  },
  watch: {
    houseActive: function (val){
      // 页面初始化的时候直接把hotHouseList赋值给houseList
      // 所以在切换列表时判断hotHouseList是否为空,为空则是第一次切换,把houseList赋值给hotHouseList
      if (this.hotHouseList === "") {
        this.hotHouseList = this.houseList;
      }
      if (val === 1) {
        // 1热门商品
        this.houseList = this.hotHouseList;
        return;
      }
      if (val === 2) {
        // 2学区房
        this.houseList = this.schoolHouseList;
        return;
      }
      if (val ===3){
        this.houseList = this.hospitalHouseList;
      }
    }
  },
  methods: {
    // 获取家电模块子组件传过来的数据
    getChildMsg(val) {
      this.houseActive = val;
    },
    // 获取各类房子封装，只要7个！！！
    getHouse(categoryName, val) {
      this.axios
          .post('/house/getHouse', {
            categoryName
          })
          .then(res => {
            this[val] = res.data.data;
          })
          .catch(err => {
            return Promise.reject(err);
          });
    }
  }
}
</script>

<style scoped>
@import "../assets/css/index.css";
</style>
