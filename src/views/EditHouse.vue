<!--
 * @Description: 编辑房子
 * @Author: house-team
 * @Date: 2022/4/28
 * @LastEditors:
 * @LastEditTime: 2022/4/28
 -->
<template>
  <div id="sell-house">
    <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-width="100px">
      <span style="font-weight: bold;line-height: 50px">基本资料：</span>
      <el-form-item label="标题">
        <el-input v-model="ruleForm.house_title" style="width: 480px"></el-input>
      </el-form-item>
      <el-form-item label="地址">
        <el-cascader style="width: 200px" v-model="ruleForm.house_address" :options="citydata" :props="{ expandTrigger: 'hover' }"></el-cascader>
        &nbsp;详细地址：<el-input v-model="ruleForm1.house_address_detail" style="width: 200px"></el-input>
      </el-form-item>
      <el-row>
        <el-col :span="8">
          <el-form-item label="价格">
            <el-input v-model="ruleForm.house_price" style="width: 200px"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="8">
          <el-form-item label="是否可议价">
            <el-switch v-model="ruleForm.bargain"></el-switch>
          </el-form-item>
        </el-col>
      </el-row>

      <el-row>
        <el-col :span="7">
          <el-form-item label="类型">
            <el-select v-model="ruleForm.category_id" placeholder="请选择房屋分类" style="width: 200px">
              <el-option
                  v-for="item in this.getCategoryList"
                  :key="item.category_id"
                  :label="item.category_name"
                  :value="item.category_id">
              </el-option>
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="面积">
            <el-input v-model="ruleForm.house_area" style="width: 200px"></el-input>
          </el-form-item>
        </el-col>
      </el-row>
      <el-form-item label="看房时间">
        <el-input v-model="ruleForm.viewing_time" style="width: 480px"></el-input>
      </el-form-item>
      <el-form-item label="房屋描述">
        <el-input type="textarea" v-model="ruleForm.house_description" style="width: 480px"></el-input>
      </el-form-item>
      <el-form-item label="图片信息">
        <el-carousel style="height: 300px;width: 300px">
          <el-carousel-item v-for="item in house_picture" :key="item.picture_id">
            <img style="height:300px;" :src="$target + item.src" />
          </el-carousel-item>
        </el-carousel>
        <el-button @click="change">修改</el-button>
      </el-form-item>
      <el-form-item v-show="this.changePic">
        <el-upload
            action=""
            list-type="picture-card"
            :on-preview="handlePictureCardPreview"
            :http-request="httpRequest">
          <i class="el-icon-plus"></i>
        </el-upload>
        <el-dialog :visible.sync="dialogVisible">
          <img width="100%" :src="dialogImageUrl" alt="">
        </el-dialog>
      </el-form-item>
      <span style="font-weight: bold;line-height: 50px">详细资料：</span>
      <el-row>
        <el-form-item label="房屋户型">
          <el-input-number v-model="ruleForm1.num_shi" controls-position="right" :min="0" style="width: 100px"></el-input-number><el-tag>室</el-tag>&nbsp;
          <el-input-number v-model="ruleForm1.num_ting" controls-position="right" :min="0" style="width: 100px"></el-input-number><el-tag>厅</el-tag>&nbsp;
          <el-input-number v-model="ruleForm1.num_chu" controls-position="right" :min="0" style="width: 100px"></el-input-number><el-tag>厨</el-tag>&nbsp;
          <el-input-number v-model="ruleForm1.num_wei" controls-position="right" :min="0" style="width: 100px"></el-input-number><el-tag>卫</el-tag>&nbsp;
          <el-input-number v-model="ruleForm1.num_else" controls-position="right" :min="0" style="width: 100px"></el-input-number><el-tag>其他</el-tag>&nbsp;
        </el-form-item>
      </el-row>

      <el-row>
        <el-col :span="6">
          <el-form-item label="户型结构">
            <el-input v-model="ruleForm.house_structure" style="width: 150px"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="建筑类型">
            <el-input v-model="ruleForm.building_type" style="width: 150px"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="建筑结构">
            <el-input v-model="ruleForm.building_structure" style="width: 150px"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="房屋朝向">
            <el-input v-model="ruleForm.house_towards" style="width: 150px"></el-input>
          </el-form-item>
        </el-col>
      </el-row>
      <el-row>
        <el-col :span="6">
          <el-form-item label="装修情况">
            <el-input v-model="ruleForm.house_decoration" style="width: 150px"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="梯户比例">
            <el-input v-model="ruleForm.house_ladder" style="width: 150px"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="供暖方式">
            <el-input v-model="ruleForm.heating_mode" style="width: 150px"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="电梯配备">
            <el-switch v-model="ruleForm.elevator"></el-switch>
          </el-form-item>
        </el-col>
      </el-row>
      <el-form-item label="交通出行">
        <el-input type="textarea" v-model="ruleForm.transportation" style="width: 835px"></el-input>
      </el-form-item>
      <el-form-item label="周边设施">
        <el-input type="textarea" v-model="ruleForm.surrounding_facilities" style="width: 835px"></el-input>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="submitForm">立即发布</el-button>
        <el-button @click="resetForm">重置</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
import citydata from "@/assets/cityDate/citydata";
import {mapGetters} from "vuex";
export default {
  name: 'EditHouse',
  activated() {
    this.axios.post('/house/getHouseByID',{
      house_id: this.$route.query.houseID
    }).then(res => {
      if (res.data.code === 200) {
        // 基本赋值
        this.ruleForm.owner_id = res.data.data.owner_id;
        this.ruleForm.bargain = res.data.data.bargain;
        this.ruleForm.building_structure = res.data.data.building_structure;
        this.ruleForm.building_type = res.data.data.building_type;
        this.ruleForm.elevator = res.data.data.elevator;
        this.ruleForm.heating_mode = res.data.data.heating_mode;
        this.ruleForm.house_address = res.data.data.house_address;
        this.ruleForm.house_area = res.data.data.house_area;
        this.ruleForm.house_decoration = res.data.data.house_decoration;
        this.ruleForm.house_description = res.data.data.house_description;
        this.ruleForm.house_ladder = res.data.data.house_ladder;
        this.ruleForm.house_id = res.data.data.house_id;
        this.ruleForm.house_price = res.data.data.house_price;
        this.ruleForm.house_structure = res.data.data.house_structure;
        this.ruleForm.house_title = res.data.data.house_title;
        this.ruleForm.house_towards = res.data.data.house_towards;
        this.ruleForm.surrounding_facilities = res.data.data.surrounding_facilities;
        this.ruleForm.transportation = res.data.data.transportation;
        this.ruleForm.viewing_time = res.data.data.viewing_time;
        this.ruleForm.category_id = res.data.data.category_id;
        // 复杂赋值
        this.ruleForm1.num_shi = res.data.data.house_type[0];
        this.ruleForm1.num_ting = res.data.data.house_type[2];
        this.ruleForm1.num_chu = res.data.data.house_type[4];
        this.ruleForm1.num_wei = res.data.data.house_type[6];
        // 地址赋值
        let arr = res.data.data.house_address.split(',');
        let address_detail = arr.pop();
        this.ruleForm1.house_address_detail = address_detail;
        this.ruleForm.house_address = arr;
        // 图片赋值
        this.house_picture = res.data.data.pictures;
      }else {
        this.notifyError(res.data.msg);
      }
    }).catch(err => {
      return Promise.reject(err);
    });
  },
  data() {
    return {
      dialogImageUrl: '',
      dialogVisible: false,
      fileList: [],
      house_picture: [],
      ruleForm1: {
        num_shi: 0,
        num_ting: 0,
        num_chu: 0,
        num_wei: 0,
        num_else: 0,
        house_address_detail: "",
      },
      ruleForm: {
        house_id: '',
        owner_id: '',
        category_id: '',
        house_title: "",
        house_address: "",
        house_price: '',
        bargain: false,
        publish_time: "",
        house_area: "",
        house_type: "",
        house_structure: "",
        building_type: "",
        building_structure: "",
        house_towards: "",
        house_decoration: "",
        house_ladder: "",
        heating_mode: "",
        elevator: false,
        viewing_time: "",
        transportation: "",
        surrounding_facilities: "",
        house_description: "",
        house_state: false,
      },
      rules: {
        house_title: [
          {
            required: true,
            message: "请输入标题名称",
            trigger: "blur",
          },
          {
            min: 3,
            max: 5,
            message: "长度在 3 到 5 个字符",
            trigger: "blur",
          },
        ],
        house_address: {
          required: true,
          message: "请输入房子地址",
          trigger: "change"
        },
        region: [
          {
            required: true,
            message: "请选择活动区域",
            trigger: "change",
          },
        ],
        type: [
          {
            type: "array",
            required: true,
            message: "请至少选择一个活动性质",
            trigger: "change",
          },
        ],
        desc: [
          {
            required: true,
            message: "请填写活动形式",
            trigger: "blur",
          },
        ],
      },
      citydata,
      changePic: false
    }
  },
  computed: {
    ...mapGetters(["getCategoryList"]),
    house_type: function (){
      return  ''+this.ruleForm1.num_shi+'室'+this.ruleForm1.num_ting+'厅'+this.ruleForm1.num_chu+'厨'+this.ruleForm1.num_wei+'卫'+this.ruleForm1.num_else+'其他';
    }
  },
  methods: {
    // 重置表单
    resetForm() {
      console.log("submit!")
    },
    httpRequest (option) {
      console.log(option)
      this.fileList.push(option)
    },
    handlePictureCardPreview(file) {
      this.dialogImageUrl = file.url;
      this.dialogVisible = true;
    },
    change() {
      this.changePic = true;
    },
    // 上传表单
    submitForm() {
      // 使用formData
      const formData = new FormData();
      // 零碎数据合并
      this.ruleForm.house_address += ","+this.ruleForm1.house_address_detail;
      this.ruleForm.house_type = this.house_type;
      this.ruleForm.publish_time = new Date();
      formData.append('house',new Blob([JSON.stringify(this.ruleForm)], { type: 'application/json' }));
      this.fileList.forEach((it) => {
        formData.append('file', it.file)
      });
      this.$refs["ruleForm"].validate(valid => {
        if (valid) {
          this.axios.post('/house/modifyHouse',formData).then(res => {
            if (res.data.code === 200) {
              this.notifySucceed(res.data.msg);
            }else {
              this.notifyError(res.data.msg);
            }
          }).catch(err => {
            return Promise.reject(err);
          });
        }else {
          return false;
        }
      })
    }
  }
}
</script>

<style scoped>
#sell-house {
  margin-left: 300px;
  margin-right: 300px;
}
</style>
