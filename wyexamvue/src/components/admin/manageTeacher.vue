<template>
  <div class="all">
    <el-table :data="pagination.records" border>
      <el-table-column fixed="left" prop="teacherName" label="姓名" width="180"></el-table-column>
      <el-table-column prop="academe" label="学院" width="200"></el-table-column>
      <el-table-column prop="sex" label="性别" width="120"></el-table-column>
      <el-table-column prop="phoneNum" label="联系方式" width="120"></el-table-column>
      <el-table-column prop="email" label="邮箱" width="120"></el-table-column>
      <el-table-column prop="pwd" label="密码" width="120"></el-table-column>
      <el-table-column prop="cardId" label="身份证号" width="120"></el-table-column>
      <el-table-column prop="title" label="职称" width="120"></el-table-column>
      <el-table-column fixed="right" label="操作" width="170">

        <template slot-scope="scope">
          <el-button @click="checkGrade(scope.row.teacherId)" type="primary" size="small">编辑</el-button>
          <el-button @click="deleteById(scope.row.teacherId)" type="danger" size="small">删除</el-button>
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
      title="编辑试卷信息"
      :visible.sync="dialogVisible"
      width="30%"
      :before-close="handleClose">
      <section class="update">
        <el-form ref="form" :model="form" label-width="80px">
          <el-form-item  :required="true" prop="teacherName" label="姓名">
            <el-input v-model="form.teacherName"></el-input>
          </el-form-item>
          <el-form-item label="学院">
            <el-col :span="11">
                <el-select v-model="form.academe" placeholder="请选择">
                    <el-option
                    v-for="item in academeOptions"
                    :key="item.value"
                    :label="item.label"
                    :value="item.value">
                    </el-option>
                </el-select>
            </el-col>
          </el-form-item>
          <el-form-item  label="性别">
            <el-col :span="11">
              <el-radio  v-model="form.sex" :label="1">男</el-radio>
              <el-radio  v-model="form.sex" :label="0">女</el-radio>
            </el-col>
          </el-form-item>
          <el-form-item label="电话号码">
            <el-input v-model="form.phoneNum"></el-input>
          </el-form-item>
          <el-form-item :required="true" prop="pwd" label="密码">
            <el-input type="password" :show-password="true" v-model="form.pwd"></el-input>
          </el-form-item>
          <el-form-item label="身份证号">
            <el-input v-model="form.cardId"></el-input>
          </el-form-item>
          <el-form-item label="职称">
            <el-input v-model="form.title"></el-input>
          </el-form-item>
        </el-form>
      </section>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="submit('form')">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
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
      form: {}, //保存点击以后当前试卷的信息
    };
  },
  created() {
    this.getTeacherInfo();
  },
  methods: {
    getTeacherInfo() {
      //分页查询所有试卷信息
      this.$axios(`/API/teachers/${this.pagination.current}/${this.pagination.size}`).then(res => {
        this.pagination = res.data.data;
        //性别数字-》字符
        this.pagination.records.forEach(function(value,index){
            if(value.sex == 1){
                value.sex = '男'
            }else if(value.sex == 0){
                value.sex = '女'
            }else
                console.log("function:getTeacherInfo(),error:性别出错")
        })
      }).catch(error => {});
    },
    //改变当前记录条数
    handleSizeChange(val) {
      this.pagination.size = val;
      this.getTeacherInfo();
    },
    //改变当前页码，重新发送请求
    handleCurrentChange(val) {
      this.pagination.current = val;
      this.getTeacherInfo();
    },
    checkGrade(teacherId) { //修改教师信息
      this.dialogVisible = true
      this.$axios(`/API/teacher/${teacherId}`).then(res => {
        this.form = res.data.data
      })
    },
    deleteById(teacherId) { //删除当前学生
      this.$confirm("确定删除当前教师吗？删除后无法恢复","Warning",{
        confirmButtonText: '确定删除',
        cancelButtonText: '仍保留',
        type: 'danger'
      }).then(()=> { //确认删除
        this.$axios({
          url: `/API/teacher/${teacherId}`,
          method: 'delete',
        }).then(res => {
          this.getTeacherInfo()
        })
      }).catch(() => {

      })
    },
    submit(formName) { //提交更改
      this.$refs[formName].validate((valid) => {
          if (valid) {
            this.dialogVisible = false
            this.$axios({
              url: '/API/updateTeacher',
              method: 'put',
              data: {
                ...this.form
              }
            }).then(res => {
              if(res.data.code ==200) {
                this.$message({
                  message: '更新成功',
                  type: 'success'
                })
              }
              this.getTeacherInfo()
            })
          }else{//输入无效
            return;
          }
        })
      
    },
    handleClose(done) { //关闭提醒
      this.$confirm('确认关闭？')
        .then(_ => {
          done();
        }).catch(_ => {});
    },
  },
  computed:{
    ...mapState(['academeOptions'])
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
