//查询所有题库
<template>
  <div class="exam">
    <el-table :data="pagination.records"   border :row-class-name="tableRowClassName">
      <el-table-column fixed="left" prop="subject" label="试卷名称" width="180"></el-table-column>
      <el-table-column prop="question" label="题目信息" width="490"></el-table-column>
      <el-table-column prop="chapter" label="所属章节" width="200"></el-table-column>
      <el-table-column prop="type" label="题目类型" width="200"></el-table-column>
      <el-table-column prop="mark" label="试题分数" width="150"></el-table-column> 
      <el-table-column prop="difficulty"   label="难度等级" width="133"></el-table-column>
    </el-table>
    <el-pagination
      @size-change="handleSizeChange"
      @current-change="handleCurrentChange"
      :current-page="pagination.current"
      :page-sizes="[10,14]"
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
        current: 1, //当前页
        total: null, //记录条数
        size: 10 //每页条数
      }
    };
  },
  created() {
    this.getAnswerInfo();
  },
  methods: {
    getAnswerInfo() {
      //分页查询所有试卷信息
      this.$axios(
        `/API/answers/${this.pagination.current}/${this.pagination.size}`
      ).then(res => {
          this.pagination = res.data.data;
          
        })
        .catch(error => {});
    },
    tableRowClassName({row,rowIndex}){
        //根据试题难度更改颜色
        switch(row.difficulty){
            case '1'://一级难度
                return 'first-row' ;
            case '2':
                return 'second-row' ;    
            case '3':
                return 'third-row' ; 
            default:
                return 'four-row';
            
        }
    },
    //改变当前记录条数
    handleSizeChange(val) {
      this.pagination.size = val;
      this.getAnswerInfo();
    },
    //改变当前页码，重新发送请求
    handleCurrentChange(val) {
      this.pagination.current = val;
      this.getAnswerInfo();
    },
    
  }
};
</script>
<style >
.exam {
  padding: 0px 40px;
  

}
.page {
    margin-top: 20px;
    display: flex;
    justify-content: center;
    align-items: center;
  }
  .edit {
    margin-left: 20px;
  }
  
   /* .el-table tr {
     background-color: #DD5862 !important;
   } */
  .el-table .one-row {
    background: oldlace ;
  }
  .el-table .second-row {
    background: #ebe8f5;
  }
  .el-table .third-row {
    background: oldlace;
  }
  .el-table .four-row {
    background: #f0f9eb;
  }
  
</style>
