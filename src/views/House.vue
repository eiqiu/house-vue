<!--
 * @Description: 所有房子
 * @Author: house-team
 * @Date: 2022/4/25
 * @LastEditors:
 * @LastEditTime: 2022/4/25
 -->
<template>
  <div class="house" id="house">
    <!-- 面包屑 -->
    <div class="breadcrumb">
      <el-breadcrumb separator-class="el-icon-arrow-right">
        <el-breadcrumb-item to="/">首页</el-breadcrumb-item>
        <el-breadcrumb-item>全部商品</el-breadcrumb-item>
        <el-breadcrumb-item v-if="search">搜索</el-breadcrumb-item>
        <el-breadcrumb-item v-else>分类</el-breadcrumb-item>
        <el-breadcrumb-item v-if="search">{{search}}</el-breadcrumb-item>
      </el-breadcrumb>
    </div>
    <!-- 面包屑END -->

    <!-- 分类标签 -->
    <div class="nav">
      <div class="house-nav">
        <div class="title">分类</div>
        <el-tabs v-model="activeName">
          <el-tab-pane label="全部" name="0"></el-tab-pane>
          <el-tab-pane label="热门" name="1"></el-tab-pane>
          <el-tab-pane v-for="item in categoryList" :key="item.category_id" :label="item.category_name" :name="''+item.category_id"/>
        </el-tabs>
      </div>
    </div>
    <!-- 分类标签END -->

    <!-- 主要内容区 -->
    <div class="main">
      <div class="list">
        <MyList :list="houseList" v-if="houseList.length>0"></MyList>
        <div v-else class="none-house">抱歉没有找到相关的房子，请试试换种方式搜索。</div>
      </div>
      <!-- 分页 -->
      <div class="pagination">
        <el-pagination
            background
            layout="prev, pager, next"
            :page-size="pageSize"
            :total="total"
            @current-change="currentChange"
        ></el-pagination>
      </div>
      <!-- 分页END -->
    </div>
    <!-- 主要内容区END -->
  </div>
</template>
<script>
import {mapGetters} from "vuex";
export default {
  // eslint-disable-next-line vue/multi-word-component-names
  name: 'House',
  data() {
    return {
      categoryList: "", //分类列表
      categoryID: -1, // 分类id
      houseList: [],// 房子列表
      activeName: "-1", // 分类列表当前选中的id
      total: 0, // 房子总量
      pageSize: 10, // 每页显示的商品数量
      currentPage: 1, //当前页码
      search: "" // 搜索条件
    };
  },
  created() {
    // 获取分类列表
    this.categoryList = this.getCategoryList();
  },
  activated() {
    this.backTop();
    this.activeName = "-1";
    this.total = 0; // 初始化房子总量为0
    this.currentPage = 1; //初始化当前页码为1
    // 如果路由没有传递参数，默认为显示全部房子
    if (Object.keys(this.$route.query).length === 0) {
      this.categoryID = 0;
      this.activeName = "0";
      return;
    }
    // 如果路由传递了categoryID，则显示对应的分类房子
    if (this.$route.query.categoryID !== undefined) {
      this.categoryID = this.$route.query.categoryID;
      this.activeName = '' + this.categoryID;
      return;
    }
    // 如果路由传递了search，则为搜索，显示对应的分类房子
    if (this.$route.query.search !== undefined) {
      this.search = this.$route.query.search;
    }
  },
  watch: {
    // 监听点击了哪个分类标签，通过修改分类id，响应相应的房子
    activeName: function(val) {
      this.categoryID = val;
      // 初始化商品总量和当前页码
      this.total = 0;
      this.currentPage = 1;
      // 更新地址栏链接，方便刷新页面可以回到原来的页面
      this.$router.push({
        path: "/house",
        query: { categoryID: this.categoryID }
      });
    },
    // 监听分类ID，响应相应的房子
    categoryID: function() {
      this.getData();
      this.search = "";
    },
    // 监听搜索条件，响应相应的商品
    search: function(val) {
      if (val !== "") {
        this.getHouseBySearch(val);
      }
    },
    // 监听路由变化，更新路由传递了搜索条件
    $route: function(val) {
      // 如果路由变化了，那么就在当前页面的分类中进行搜索，而不是搜索全部
      if (val.path == "/house") {
        if (val.query.search !== undefined) {
          this.currentPage = 1;
          this.total = 0;
          this.search = val.query.search;
        }
      }
    }
  },
  methods: {
    ...mapGetters(["getCategoryList"]),
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
    // 页码变化调用currentChange方法
    currentChange(currentPage) {
      this.currentPage = currentPage;
      if (this.search !== "") {
        this.getHouseBySearch();
      } else {
        this.getData();
      }
      this.backTop();
    },
    // 向后端请求全部房子或者分类房子
    getData() {
      // 0:全部房子 1:热门房子 2~...
      this.axios
          .post('/house/getHouse', {
            categoryID: this.categoryID,
            pageNum: this.currentPage,
            pageSize: this.pageSize
          })
          .then(res => {
            this.houseList = res.data.data.list;
            this.total = res.data.data.total;
          })
          .catch(err => {
            return Promise.reject(err);
          });
    },
    // 通过搜索条件向后端请求商品数据
    getHouseBySearch() {
      // console.log('调用了搜索方法'+this.search)
      this.axios
          .post("/house/getHouseBySearch", {
            search: this.search,
            currentPage: this.currentPage,
            pageSize: this.pageSize
          })
          .then(res => {
            this.houseList = res.data.data;
            this.total = res.data.total;
          })
          .catch(err => {
            return Promise.reject(err);
          });
    }
  }
};
</script>

<style scoped>
.house {
  background-color: #f5f5f5;
}
/* 面包屑CSS */
.house .breadcrumb {
  height: 50px;
  background-color: white;
}
.house .breadcrumb .el-breadcrumb {
  width: 1225px;
  line-height: 30px;
  font-size: 16px;
  margin: 0 auto;
}
/* 面包屑CSS END */

/* 分类标签CSS */
.house .nav {
  background-color: white;
}
.house .nav .house-nav {
  width: 1225px;
  height: 40px;
  line-height: 40px;
  margin: 0 auto;
}
.nav .house-nav .title {
  width: 50px;
  font-size: 16px;
  font-weight: 700;
  float: left;
}
/* 分类标签CSS END */

/* 主要内容区CSS */
.house .main {
  margin: 0 auto;
  max-width: 1225px;
}
.house .main .list {
  min-height: 650px;
  padding-top: 14.5px;
  margin-left: -13.7px;
  overflow: auto;
}
.house .main .pagination {
  height: 50px;
  text-align: center;
}
.house .main .none-house {
  color: #333;
  margin-left: 13.7px;
}
/* 主要内容区CSS END */
</style>
