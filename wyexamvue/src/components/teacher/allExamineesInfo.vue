<!-- 展示所有学生信息 -->
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

      <el-table-column fixed="right" label="查看成绩" width="150">
        <template slot-scope="scope">
          <el-button @click="checkGrade(scope.row.examineeId)" type="primary" size="small">查看成绩</el-button>
        </template>
      </el-table-column>
    </el-table>
    <el-pagination
      @size-change="handleSizeChange"
      @currentP-change="handleCurrentChange"
      :currentP-page="pagination.currentP"
      :page-sizes="[6, 10]"
      :page-size="pagination.size"
      layout="total, sizes, prev, pager, next, jumper"
      :total="pagination.total"
      class="page"
    ></el-pagination>
  </div>
</template>

<script>
export default {
  data() {
    return {
      pagination: {
        //分页后的考试信息
        currentP: 1, //当前页
        total: null, //记录条数
        size: 6 //每页条数api
      }
    };
  },
  created() {
    this.getAnswerInfo();
  },
  methods: {
    getAnswerInfo() {
      //分页查询所有试卷信息
      this.$axios(`/API/examinees/${this.pagination.currentP}/${this.pagination.size}`).then(res => {
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
      this.getAnswerInfo();
    },
    //改变当前页码，重新发送请求
    handleCurrentChange(val) {
      this.pagination.currentP = val;
      this.getAnswerInfo();
    },
    checkGrade(examineeId) {
      console.log(examineeId)
      this.$router.push({ path: "/mark", query: { examineeId: examineeId } });
    }
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
