<template>
    <section class="add">
      <el-form ref="form" :model="form" label-width="80px">
        <el-form-item prop="courseName"  :required="true"  label="试卷名称">
          <el-input v-model="form.courseName"></el-input>
        </el-form-item>
        <el-form-item label="介绍">
          <el-input v-model="form.descriptions"></el-input>
        </el-form-item>
        <el-form-item prop="academe"  :required="true" label="所属学院">
            <el-col :span="11">
                <el-select  v-model="form.academe" placeholder="请选择" @change="changeAca">
                    <el-option 
                    v-for="item in academeOptions"
                    :key="item.value"
                    :label="item.label"
                    :value="item.value">
                    </el-option>
                </el-select>
            </el-col>
        </el-form-item>

        <el-form-item prop="major" :required="true"  label="所属专业">
            <el-col :span="11">
                <el-select v-model="form.major" placeholder="请选择">
                    <el-option
                    v-for="item in tempMajorOption"
                    :key="item.value"
                    :label="item.label"
                    :value="item.value">
                    </el-option>
                </el-select>
            </el-col>
        </el-form-item>

        <el-form-item prop="grade" :required="true" label="年级">
            <el-col :span="11">
                <el-select v-model="form.grade" placeholder="请选择">
                    <el-option
                    v-for="item in gradeOptions"
                    :key="item.value"
                    :label="item.label"
                    :value="item.value">
                    </el-option>
                </el-select>
            </el-col>
        </el-form-item>
        <el-form-item prop="clazz" :required="true" label="班级">
            <el-col :span="11">
              <el-input placeholder="填入班级一班填1" v-model="form.clazz"></el-input>
            </el-col>
        </el-form-item>
        <el-form-item prop="type" :required="true" label="考试类型">
          <el-col :span="11">
                <el-select v-model="form.type" placeholder="请选择">
                    <el-option
                    v-for="item in typeOptions"
                    :key="item.value"
                    :label="item.label"
                    :value="item.value">
                    </el-option>
                </el-select>
            </el-col>
        </el-form-item>

        <el-form-item prop="examDate" :required="true"  label="考试日期">
          <el-col :span="11">
            <el-date-picker value-format="yyyy-MM-dd"  format="yyyy-MM-dd"  placeholder="选择日期" v-model="form.examDate" style="width: 100%;"></el-date-picker>
          </el-col>
        </el-form-item>
        <el-form-item prop="examDeadline" :required="true"  label="截止日期">
          <el-col :span="11">
            <el-date-picker value-format="yyyy-MM-dd"  format="yyyy-MM-dd"  placeholder="选择日期" v-model="form.examDeadline" style="width: 100%;"></el-date-picker>
          </el-col>
        </el-form-item>
        <el-form-item prop="duringTime" :required="true"  label="持续时间">
          <el-input placeholder="填入分钟数" v-model="form.duringTime"></el-input>
        </el-form-item>
        <el-form-item label="总分">
          <el-input placeholder="最终总分将被题型组成影响" v-model="form.totalMark"></el-input>
        </el-form-item>
        
        <el-form-item label="考生提示">
          <el-input type="textarea" v-model="form.tips"></el-input>
        </el-form-item>
       
        <el-form-item>
          <el-button type="primary" @click="onSubmit()">立即创建</el-button>
          <el-button type="text" @click="cancel()">取消</el-button>
        </el-form-item>
      </el-form>
    </section>
  </template>
  
  <script>
  import { mapState } from 'vuex';
  export default {
    data() {
      return {
        form: { //表单数据初始化
          examCode:null,
          courseName: null,
          descriptions: null,
          academe: null,
          major: null,
          grade: null,
          clazz:null,
          examDate: null,
          examDeadline:null,
          duringTime: null,
          totalMark: null,
          type: null,
          tips: null,
          paperId: null,
        },

        tempMajorOption:[],//用于筛选后显示
        typeOptions:[
          {
            value: '开卷',
            label: '开卷'
          },
          {
            value: '闭卷',
            label: '闭卷'
          },
          {
            value: '期末考试',
            label: '期末考试'
          },
          {
            value: '小测',
            label: '小测'
          },
        ]
      };
    },
    methods: {
      // formatTime(date) { //日期格式化
      //   let year = date.getFullYear()
      //   let month= date.getMonth()+ 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
      //   let day=date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
      //   let hours=date.getHours() < 10 ? "0" + date.getHours() : date.getHours();
      //   let minutes=date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes();
      //   let seconds=date.getSeconds() < 10 ? "0" + date.getSeconds() : date.getSeconds();
      //   // 拼接
      //   return year+"-"+month+"-"+day+" "+hours+":"+minutes+":"+seconds;
      // },
      onSubmit() {
        // let examDate = this.formatTime(this.form.examDate)
        // this.form.examDate = examDate.substr(0,10)

        this.$refs['form'].validate((valid) => {
          if (valid) {
            this.$axios(`/API/examManagePaperId`).then(res => {
            this.form.paperId = res.data.data.paperId + 1 //实现paperId自增1
            this.$axios({
              url: '/API/addExam',
              method: 'post',
              data: {
                ...this.form
              }
            }).then(res => {
              if(res.data.code == 200) {
                this.$message({
                  message: '数据添加成功',
                  type: 'success'
                })
                this.$router.push({path: '/manageExam'})
              }
            })
          })
          }else{
            return;
          }
        })
        
      },
      cancel() { //取消按钮
        this.form = {}
      },
      changeAca(){
        this.form.major = '';
      }
    },
    watch:{
      getAcademe(newValue,oldValue){//约束输入，提升健壮性
        if(newValue == '信通学院'){
           this.tempMajorOption = this.majorOptions.filter(i => i.academe == newValue)
        }else if(newValue == '艺术学院'){
           this.tempMajorOption = this.majorOptions.filter(i => i.academe == newValue)
        }else if(newValue == '轮机工程学院'){
           this.tempMajorOption = this.majorOptions.filter(i => i.academe == newValue)
        }else if(newValue == '土木工程学院'){
           this.tempMajorOption = this.majorOptions.filter(i => i.academe == newValue)
        }
      }
    },
    computed:{
      getAcademe(){
        return this.form.academe;
      },
      ...mapState(['gradeOptions','academeOptions','majorOptions'])
    }
        
    
  };
  </script>
  <style scoped>
  .add {
    padding: 0px 40px;
    width: 400px;
  }
  </style>
  
  