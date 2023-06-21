// 考生管理页面
<template>
  <div class="all">
    
    <el-table :data="pagination.records" border>
      <el-table-column fixed="left" prop="examineeName" label="姓名" width="180"></el-table-column>
      <el-table-column prop="academe" label="学院" width="200"></el-table-column>
      <el-table-column prop="major" label="专业" width="200"></el-table-column>
      <el-table-column prop="grade" label="年级" width="200"></el-table-column>
      <el-table-column prop="clazz" label="班级" width="100"></el-table-column>
      <el-table-column prop="sex" label="性别" width="120"></el-table-column>
      <el-table-column prop="phoneNum" label="联系方式" width="120"></el-table-column>
      <el-table-column fixed="right" label="操作" width="150">
        <template slot-scope="scope">
          <el-button @click="checkGrade(scope.row.examineeId)" type="primary" size="small">编辑</el-button>
          <el-button @click="deleteById(scope.row.examineeId)" type="danger" size="small">删除</el-button>
        </template>
      </el-table-column>
    </el-table>
    <el-pagination
      @size-change="handleSizeChange"
      @current-change="handleCurrentChange"
      :current-page="pagination.current"
      :page-sizes="[6, 10]"
      :page-size="pagination.size"
      layout="total, sizes, prev, pager, next, jumper"
      :total="pagination.total"
      class="page">
    </el-pagination>
    <!-- 编辑对话框-->

    <el-dialog
      title="编辑考生信息"
      :visible.sync="dialogVisible"
      width="30%"
      :before-close="handleClose">
      <section class="update">
        <el-form ref="formRef"  :model="form" label-width="80px">
          <el-form-item prop="examineeName" :rules="[
            { required:true, message: '姓名不能为空',trigger: 'blur'},
          ]" label="姓名">
            <el-input v-model="form.examineeName"></el-input>
          </el-form-item>
          <el-form-item prop="academe" :required="true" label="学院">
            <el-col :span="11">
                    <el-select @change="changeMajor($event)" v-model="form.academe" placeholder="请选择">
                        <el-option
                        v-for="item in academeOptions"
                        :key="item.value"
                        :label="item.label"
                        :value="item.value">
                        </el-option>
                    </el-select>
                </el-col>
          </el-form-item>
          <el-form-item :required="true" label="专业">
            <el-col :span="11">
                    <el-select  v-model="form.major" placeholder="请选择">
                        <el-option
                        v-for="item in majorInfo"
                        :key="item.value"
                        :label="item.label"
                        :value="item.value">
                        </el-option>
                    </el-select>
                </el-col>
          </el-form-item>
          <el-form-item :required="true" label="年级">
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
            <el-input v-model="form.clazz"></el-input>
          </el-form-item>
          <el-form-item  label="性别">
            <el-row>
                <el-col :span="4">
                    <el-radio v-model="form.sex" :label="1">男</el-radio>
                </el-col>
                <el-col :span="4">
                    <el-radio v-model="form.sex" :label="0">女</el-radio>
                </el-col>
            </el-row>
          </el-form-item>
          <el-form-item  label="电话号码">
            <el-input v-model="form.phoneNum"></el-input>
          </el-form-item>          
        </el-form>
      </section>
            <span slot="footer" class="dialog-footer">
              <el-button @click="cancel()">取 消</el-button>
              <el-button type="primary" @click="submit('formRef')">确 定</el-button>
            </span>
    </el-dialog>
  </div>
</template>

<script >
import {mapState} from 'vuex'
export default {
  data() {
    return {
      pagination: {
        //分页后的考试信息
        current: 1, //当前页
        total: null, //记录条数
        size: 6, //每页条数
      },
      dialogVisible: false, //对话框
      form: {
        examineeName:null,
        academe:null,
        major:null,
        grade:null,
        clazz:null,
        sex:null,
        phoneNum:null,

      }, //保存点击以后当前试卷的信息
      majorInfo:null
    };
  },
  created() {
    this.getStudentInfo();
  },
  methods: {
    getStudentInfo() {
      //分页查询所有考生信息
      this.$axios(`/API/examinees/${this.pagination.current}/${this.pagination.size}`).then(res => {
        this.pagination = res.data.data;
        for(let i=0;i < this.pagination.records.length;i++){
            if(this.pagination.records[i].sex == 1){
                this.pagination.records[i].sex = '男'
            }else
            this.pagination.records[i].sex = '女'
        }
      }).catch(error => {});
    },
    //改变当前记录条数
    handleSizeChange(val) {
      this.pagination.size = val;
      this.getStudentInfo();
    },
    //改变当前页码，重新发送请求
    handleCurrentChange(val) {
      this.pagination.current = val;
      this.getStudentInfo();
    },
    checkGrade(examineeId) { //修改考生信息
      this.dialogVisible = true;
      this.$axios(`/API/getexamineeByID/${examineeId}`).then(res => {
        this.form = res.data.data
      })
    },
    cancel(){
      this.dialogVisible = false
      
    },
    deleteById(examineeId) { //删除当前考生
      this.$confirm("确定删除当前考生吗？删除后无法恢复","Warning",{
        confirmButtonText: '确定删除',
        cancelButtonText: '仍保留',
        type: 'danger'
      }).then(()=> { //确认删除
        this.$axios({
          url: `/API/deleteExaminee/${examineeId}`,
          method: 'delete',
        }).then(res => {
          this.getStudentInfo()
          if(res.data.code == 200){
            this.$message({
              message:'已删除',
              type:'success'
            })
          }
          
        })
      }).catch(() => {
      })
    },
    //修改专业
    changeMajor(event){
      if(this.form.major != null)
        this.form.major = null;
        let temp = this.majorOptions
        this.majorInfo = temp.filter( i => i.academe == event)
    },
    submit(formName) { //提交更改
      this.$refs[formName].validate((valid) => {
          if (valid) {
            //有效
            this.dialogVisible = false
            this.$axios({
              url: '/API/updateExaminee',
              method: 'POST',
              data: {
                ...this.form
              }
            }).then(res => {
              if(res.data.code == 200){
                this.$message({
                  message:'已更新',
                  type:'success'
                })
              }else if(res.data.code == 400){
                this.$message.error({
                  message:'更新失败，请重试',
                })
              }
              this.getStudentInfo()
            })
          } else {
            return;
          }
        });
      
    },
    handleClose(done) { //关闭提醒
      this.$confirm('确认关闭？')
        .then(_ => {
          done();
        }).catch(_ => {});
    },
  },
  computed:{
    ...mapState(['majorOptions','gradeOptions','academeOptions'])
  }
};
</script>
<style lang="less" scoped>
.all {
  padding: 0px 40px;
  .page {
    margin-top: 20px;
    display: flex;
    justify-content: center;
    align-items: center;
  }
  .edit {
    margin-left: 20px;
  }
  .el-table tr {
    background-color: #dd5862 !important;
  }
}
.el-table .warning-row {
  background: #000 !important;
}

.el-table .success-row {
  background: #dd5862;
}
</style>
