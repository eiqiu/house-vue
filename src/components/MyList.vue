<!--
 * @Description: 自定义的房子列表组件，用于展示传进来的房子列表
 * @Author: house-team
 * @Date: 2022/4/25
 * @LastEditors:
 * @LastEditTime: 2022/4/25
 -->
<template>
  <div id="myList" class="myList">
    <ul>
      <li v-for="item in list" :key="item.house_id">
        <el-popover placement="top">
          <p>确定取消收藏吗？</p>
          <div style="text-align: right; margin: 10px 0 0">
            <el-button type="primary" size="mini" @click="deleteCollect(item.house_id)">确定</el-button>
          </div>
          <i class="el-icon-close delete" slot="reference" v-show="isDelete"></i>
        </el-popover>
        <!-- 我的房子 -->
        <img :src="$target + item.pictures[0].src" alt v-if="myHouse">
        <h2 v-if="myHouse"><i class="el-icon-map-location"></i>{{item.house_title}}</h2>
        <h3 v-if="myHouse">{{item.house_address}}</h3>
        <el-button-group v-if="myHouse">
          <router-link :to="{path: '/house/editMyHouse', query:{houseID:item.house_id}}">
            <i class="el-icon-edit edit-icon" style="padding-left: 90px"></i>
          </router-link>
          <i class="el-icon-delete-solid delete-icon" @click="openDelete(item.house_id)" style="padding-left: 20px"></i>
        </el-button-group>
        <!-- 我的收藏 -->
        <router-link :to="{ path: '/house/details', query: {houseID:item.house_id} }" v-else-if="isDelete">
          <img :src="$target + item.pictures[0].src" alt />
          <h2>{{item.house_title}}</h2>
          <h3><i class="el-icon-map-location"></i>{{item.house_address}}</h3>
          <p>
            <span>{{item.house_price}}万元</span>
          </p>
        </router-link>
        <!-- 一般情况 -->
        <router-link :to="{ path: '/house/details', query: {houseID:item.house_id} }" v-else>
          <img :src="$target + item.pictures[0].src" alt />
          <h2>{{item.house_title}}</h2>
          <h3><i class="el-icon-map-location"></i>{{item.house_address}}</h3>
          <p>
            <span>{{item.house_price}}万元</span>
          </p>
        </router-link>
      </li>
      <li v-show="isMore && list.length>=7" id="more">
        <router-link :to="{ path: '/house', query: {categoryID: this.categoryID}}">
          浏览更多
          <i class="el-icon-d-arrow-right"></i>
        </router-link>
      </li>
    </ul>
  </div>
</template>
<script>
export default {
  name: "MyList",
  // list为父组件传过来的商品列表
  // isMore为是否显示“浏览更多”
  // isDelete为我的收藏功能特有，删除该收藏
  props: ["list", "isMore", "isDelete", "myHouse"],
  data() {
    return {};
  },
  computed: {
    // 通过list获取当前显示的商品的分类ID，用于“浏览更多”链接的参数
    // 如果得到的分类ID数组里面只有一个id，说明是在某一个分类里
    // 如果超过了多个，说明当前为热门选项卡下
    categoryID: function() {
      let categoryID = 0;
      let category = [];
      if (this.list !== "") {
        for (let i = 0; i < this.list.length; i++) {
          const id = this.list[i].category_id;
          if (!category.includes(id)) {
            category.push(id);
          }
        }
      }
      if (category.length > 1) {
        // 说明在热门列表里面
        categoryID = 1;
      }else if (category.length === 1){
        categoryID = category[0];
      }
      return categoryID;
    }
  },
  methods: {
    // 删除我的房屋
    deleteMyHouse(house_id) {
      this.axios
          .post("/house/deleteMyHouse", {
            user_id: this.$store.getters.getUser.user_id,
            house_id: house_id
          })
          .then(res => {
            switch (res.data.code) {
              case "200":
                // 删除成功
                // 删除删除列表中的该商品信息
                for (let i = 0; i < this.list.length; i++) {
                  const temp = this.list[i];
                  if (temp.house_id === house_id) {
                    // eslint-disable-next-line vue/no-mutating-props
                    this.list.splice(i, 1);
                  }
                }
                // 提示删除成功信息
                this.notifySucceed(res.data.msg);
                break;
              default:
                // 提示删除失败信息
                this.notifyError(res.data.msg);
            }
          })
          .catch(err => {
            return Promise.reject(err);
          });
    },
    // 我的收藏
    deleteCollect(house_id) {
      this.axios
          .post("/house/deleteCollection", {
            user_id: this.$store.getters.getUser.user_id,
            house_id: house_id
          })
          .then(res => {
            switch (res.data.code) {
              case 200:
                for (let i = 0; i < this.list.length; i++) {
                  const temp = this.list[i];
                  console.log(this.list[i])
                  if (temp.house_id === house_id) {
                    // eslint-disable-next-line vue/no-mutating-props
                    this.list.splice(i, 1);
                  }
                }
                // 提示删除成功信息
                this.notifySucceed(res.data.msg);
                break;
              default:
                // 提示删除失败信息
                this.notifyError(res.data.msg);
            }
          })
          .catch(err => {
            return Promise.reject(err);
          });
    },
    openDelete(house_id) {
      this.$confirm('确定要删除这个房子吗？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.deleteMyHouse(house_id);
        this.$message({
          type: 'success',
          message: '删除成功!'+house_id
        });
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消删除'
        });
      });
    }
  }
};
</script>
<style scoped>
.myList ul li {
  z-index: 1;
  float: left;
  width: 234px;
  height: 280px;
  padding: 10px 0;
  margin: 0 0 14.5px 13.7px;
  background-color: white;
  -webkit-transition: all 0.2s linear;
  transition: all 0.2s linear;
  position: relative;
}
/*浮动效果*/
.myList ul li:hover {
  z-index: 2;
  -webkit-box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
  box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
  -webkit-transform: translate3d(0, -2px, 0);
  transform: translate3d(0, -2px, 0);
}
.myList ul li img {
  display: block;
  width: 160px;
  height: 160px;
  background: url(../assets/imgs/placeholder.png) no-repeat 50%;
  margin: 0 auto;
}
.myList ul li h2 {
  margin: 25px 10px 0;
  font-size: 14px;
  font-weight: 400;
  color: #333;
  text-align: center;
  text-overflow: ellipsis;
  white-space: nowrap;
  overflow: hidden;
}
.myList ul li h3 {
  margin: 5px 10px;
  height: 18px;
  font-size: 12px;
  font-weight: 400;
  color: #b0b0b0;
  text-align: center;
  text-overflow: ellipsis;
  white-space: nowrap;
  overflow: hidden;
}
.myList ul li p {
  margin: 10px 10px 10px;
  text-align: center;
  color: #ff6700;
}
.myList ul li p .del {
  margin-left: 0.5em;
  color: #b0b0b0;
  text-decoration: line-through;
}
.myList #more {
  text-align: center;
  line-height: 280px;
}
.myList #more a {
  font-size: 18px;
  color: #333;
}
.myList #more a:hover {
  color: #ff6700;
}
.myList ul li .delete {
  position: absolute;
  top: 10px;
  right: 10px;
  display: none;
}
.myList ul li:hover .delete {
  display: block
}
.myList ul li .delete:hover {
  color: #ff6700;
}
.myList ul li .delete-icon:hover {
  color: #ff6700;
}
.myList ul li .edit-icon:hover {
  color: #ff6700;
}
</style>
