<!-- 添加教师 -->
<template>
    <section class="add">
      <el-form ref="form" :model="form" label-width="80px">
        <el-form-item label="可选操作" >
              <el-upload ref="upload"   action="#" 
                :limit="1"
                :on-exceed="onExceed"
                :http-request="httpRequest"
                :before-upload="beforeUpload"  accept=".xlsx"
                :on-success="handleExcelImportSuccess"
                :auto-upload="false">
                <el-button slot="trigger" size="small" type="primary">上传文件</el-button>
                <el-button style="margin-left: 10px;" size="small" type="success" @click="imp">提交到服务器</el-button>
              </el-upload>
        </el-form-item>
        <el-form-item label="姓名">
              <el-input v-model="form.teacherName"></el-input>
            </el-form-item>
            <el-form-item label="学院">
              <el-col :span="11">
                    <el-select  v-model="form.academe" placeholder="请选择">
                        <el-option 
                        v-for="item in academeOptions"
                        :key="item.value"
                        :label="item.label"
                        :value="item.value">
                        </el-option>
                    </el-select>
                </el-col>
            </el-form-item>
            <el-form-item label="性别">
                <el-row>
                <el-col :span="3">
                    <el-radio v-model="form.sex" label="1">男</el-radio>
                </el-col>
                <el-col :span="3">
                    <el-radio v-model="form.sex" label="0">女</el-radio>
                </el-col>
            </el-row>
            </el-form-item>
            <el-form-item label="电话号码">
              <el-input maxlength="11" v-model="form.phoneNum"></el-input>
            </el-form-item>
            <el-form-item label="电子邮箱">
              <el-input  v-model="form.email"></el-input>
            </el-form-item>
            <el-form-item label="密码">
              <el-input  show-password type="password" v-model="form.pwd"></el-input>
            </el-form-item>
            <el-form-item label="身份证号">
              <el-input maxlength="18" v-model="form.cardId"></el-input>
            </el-form-item>
            <el-form-item label="职称">
              <el-input v-model="form.title"></el-input>
            </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="onSubmit()">立即创建</el-button>
          <el-button type="text" @click="cancel()">取消</el-button>
        </el-form-item>
      </el-form>
    </section>
  </template>
  
  <script>
  import {mapState} from 'vuex'
  export default {
    data() {
      return {
        fileList:[],
        form: { //表单数据初始化
          teacherName: null,
          grade: null,
          major: null,
          clazz: null,
          academe: null,
          phoneNum: null,
          email: null,
          pwd: null,
          cardId: null,
          sex: null,
          title:null,
          part: 1
        }
      };
    },
    methods: {
      onSubmit() { //数据提交
        this.$axios({
          url: '/API/addTeacher',
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
            this.$router.push({path: '/manageTeacher'})
          }
        })
      },
      cancel() { //取消按钮
        this.form = {}
      },
      async imp(){
        let files = this.$refs.upload.submit()
        console.log(files)
        // 上面这两行不加会报错 !!!!
        let formData = new FormData();
        this.fileList.forEach((x) => {
          formData.append('file', x.file)
        })
        console.log(formData)
        //导入功能
         await this.$axios({
          method:'post',
          url:'/API/impTeacher',
          data:formData,
          headers: {
            'Content-Type': 'multipart/form-data'
          }
        }).then((res) =>{
          if (res.status === 200) {
            this.$message.success('导入成功')
          } else {
            this.$message.error('导入失败')
          }
        })
      },
      handleExcelImportSuccess(file){
        console.log(file);
      },
      // 上传前
      beforeUpload (file) {
        let fileSize = file.size
        const FIVE_M = 2 * 1024 * 1024
        //不允许上传大于2M
        if (fileSize > FIVE_M) {
          this.$message.error("最大上传2M")
          return false
        }
        //判断文件类型，必须是xlsx格式
        let fileName = file.name
        let reg = /^.+(\.xlsx)$/
        if (!reg.test(fileName)) {
          this.$message.error("只能上传xlsx!")
          return false
        }
        return true
      },
      handleSuccess() {
        this.$message.success("文件上传成功");
      },
      // 覆盖默认的上传行为
      httpRequest (raw) {
        this.fileList.push(raw)
      },
      onExceed(files, fileList) {
        this.$message.error('只能上传一个文件')
      },
    },
    computed:{
      ...mapState(['academeOptions'])
    }
  };
  </script>
  <style lang="less" scoped>
  .add {
    padding: 0px 40px;
    width: 400px;
  }
  </style>
  
  