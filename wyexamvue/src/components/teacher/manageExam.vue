//查询所有考试
<template>
  <div class="exam">
    <el-table :data="pagination.records" border>
      <el-table-column fixed="left" prop="courseName" label="试卷名称" width="180"></el-table-column>
      <el-table-column prop="descriptions" label="介绍" width="200"></el-table-column>
      <el-table-column prop="academe" label="所属学院" width="120"></el-table-column>
      <el-table-column prop="major" label="所属专业" width="200"></el-table-column>
      <el-table-column prop="grade" label="年级" width="100"></el-table-column>
      <el-table-column prop="clazz" label="班级" width="100"></el-table-column>
      <el-table-column prop="examDate" label="考试日期" width="120"></el-table-column>
      <el-table-column prop="examDeadline" label="截止日期" width="120"></el-table-column>
      <el-table-column prop="duringTime" label="持续时间" width="120"></el-table-column>
      <el-table-column prop="totalMark" label="总分" width="120"></el-table-column>
      <el-table-column prop="type" label="试卷类型" width="120"></el-table-column>
      <el-table-column prop="tips" label="考生提示" width="400"></el-table-column>
      <el-table-column fixed="right" label="操作" width="220">
        <template slot-scope="scope">
          <el-button @click="edit(scope.row.examCode)" type="primary" size="small">编辑</el-button>
          <el-button @click="deleteRecord(scope.row.examCode)" type="danger" size="small">删除</el-button>
          <el-button size="small" type="success" @click="correctPaper(scope.row.examCode)">阅卷</el-button>
        </template>
      </el-table-column>
    </el-table>
    <el-pagination
      @size-change="handleSizeChange"
      @current-change="handleCurrentChange"
      :current-page="pagination.currentP"
      :page-sizes="[4, 8, 10, 20]"
      :page-size="pagination.size"
      layout="total, sizes, prev, pager, next, jumper"
      :total="pagination.total" class="page">
    </el-pagination>
    <!-- 编辑对话框-->
    <el-dialog
      title="编辑试卷信息"
      :visible.sync="dialogVisible"
      width="30%"
      :before-close="handleClose">
      <section class="update">
        <el-form ref="form" :model="form" label-width="80px">
          <el-form-item label="试卷名称">
            <el-input v-model="form.courseName"></el-input>
          </el-form-item>
          <el-form-item label="介绍">
            <el-input v-model="form.descriptions"></el-input>
          </el-form-item>
          <el-form-item label="所属学院">
              <el-col :span="13">
                  <el-select @change="changeMajor" v-model="form.academe" placeholder="请选择">
                      <el-option
                      v-for="item in academeOptions"
                      :key="item.value"
                      :label="item.label"
                      :value="item.value">
                      </el-option>
                  </el-select>
              </el-col>
          </el-form-item>

          <el-form-item label="所属专业">
              <el-col :span="13">
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

          <el-form-item label="年级">
              <el-col :span="13">
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
          
          <el-form-item label="考试类型">
            <el-col :span="13">
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
          <el-form-item label="班级">
            <el-input v-model="form.clazz"></el-input>
          </el-form-item>
          <el-form-item label="考试日期">
            <el-col :span="13">
              <el-date-picker value-format="yyyy-MM-dd"  format="yyyy-MM-dd" type="date" placeholder="选择日期" v-model="form.examDate" style="width: 100%;"></el-date-picker>
            </el-col>
          </el-form-item>
          <el-form-item label="截止日期">
            <el-col :span="13">
              <el-date-picker value-format="yyyy-MM-dd"  format="yyyy-MM-dd" type="date" placeholder="选择日期" v-model="form.examDeadline" style="width: 100%;"></el-date-picker>
            </el-col>
          </el-form-item>
          <el-form-item label="持续时间">
            <el-input v-model="form.duringTime"></el-input>
          </el-form-item>
          
          <el-form-item label="总分">
            <el-input v-model="form.totalMark"></el-input>
          </el-form-item>
          
          <el-form-item label="考生提示">
            <el-input type="textarea" v-model="form.tips"></el-input>
          </el-form-item>
        </el-form>
      </section>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="submit()">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
import { mapState } from 'vuex';
export default {
  data() {
    return {
      form: {
        courseName: null,
          descriptions: null,
          academe: null,
          major: null,
          grade: null,
          examDate: null,
          examDeadline:null,
          clazz:null,
          duringTime: null,
          totalMark: null,
          type: null,
          tips: null,
          paperId: null,
      }, //保存点击以后当前试卷的信息
      pagination: { //分页后的考试信息
        currentP: 1, //当前页
        total: null, //记录条数
        size: 4 //每页条数
      },
      dialogVisible: false,

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
      
    }
  },
  created() {
    this.getExamInfo()
  },
  methods: {
    
    edit(examCode) { //编辑试卷
      this.dialogVisible = true
      this.$axios(`/API/getExamByExamCode/${examCode}`).then(res => { //根据试卷id请求后台
        if(res.data.code == 200) {
          this.form = res.data.data
        }
      })
    },
    handleClose(done) { //关闭提醒
      this.$confirm('确认关闭？')
        .then(_ => {
          done();
        }).catch(_ => {});
    },
    submit() { //提交修改后的试卷信息
      this.dialogVisible = false
      this.$axios({
        url: '/API/updateExam',
        method: 'put',
        data: {
          ...this.form
        }
      }).then(res => {
        if(res.data.code == 200) {
          this.$message({ //成功修改提示
            message: '更新成功',
            type: 'success'
          })
          this.getExamInfo()
        }else{
          this.$message.error('更新失败')
        }
      })
    },
    deleteRecord(examCode) {
      this.$confirm("确定删除该记录吗,该操作不可逆！！！","删除提示",{
        confirmButtonText: '确定删除',
        cancelButtonText: '算了,留着',
        type: 'danger'
      }).then(()=> { //确认删除
        this.$axios({
          url: `/API/deleteExamByExamCode/${examCode}`,
          method: 'delete',
        }).then(res => {
          this.getExamInfo()
        })
      }).catch(() => {

      })
    },
    getExamInfo() { //分页查询所有试卷信息
      this.$axios(`/API/getAllExams4Param/${this.pagination.currentP}/${this.pagination.size}`).then(res => {
        this.pagination = res.data.data
        this.pagination.currentP = res.data.data.current
      }).catch(error => {
        console.log(error)
      })
    },
    //改变当前记录条数
    handleSizeChange(val) {
      this.pagination.size = val
      this.getExamInfo()
    },
    //改变当前页码，重新发送请求
    handleCurrentChange(val) {
      this.pagination.currentP = val
      this.getExamInfo()
    },
    changeMajor(){
      this.form.major = '';
    },
    correctPaper(examCode){
      //阅卷
      this.$router.push({path:'/correctPaper',query:{'examCode':examCode}})
    }
  },
  watch:{
      getAcademe(newValue,oldValue){//约束输入，提升健壮性
        if(newValue == '信通学院'){
           this.tempMajorOption = this.majorOptions.filter(i => i.academe == newValue)
        }else if(newValue == '艺术学院'){
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
<style lang="less" scoped>
.exam {
  padding: 0px 40px;
  .page {
    margin-top: 20px;
    display: flex;
    justify-content: center;
    align-items: center;
  }
  .edit{
    margin-left: 20px;
  }
}
</style>
