<template>
    <div >
        <div v-if="showPagination">
                <el-table  class="huanhang" :data="pagination.records" border>
                <el-table-column prop="examCode" label="考试代码" width="200"></el-table-column>
                <el-table-column prop="subject" label="科目" width="200"></el-table-column>
                <el-table-column prop="question" label="题干" width="200"></el-table-column>
                <el-table-column prop="appAnswer" label="考生答案" width="300"></el-table-column>
                <el-table-column  prop="referenceAns" label="参考答案" width="320">
                    <template slot-scope="scope">
                        <p>{{scope.row.referenceAns}}</p>
                    </template>
                </el-table-column>
                
                <el-table-column fixed="right" label="操作" width="250">
                    <template slot-scope="scope">
                            <el-select class="selectMark" v-model="scope.row[scope.column.property]" placeholder="请打分">
                                <el-option
                                :key="index"
                                v-for="(item,index) in MarkOptions"
                                :label="item.label"
                                :value="item.value">
                                </el-option>
                            </el-select>
                        <el-button @click="sendMark(scope.row,scope.row[scope.column.property])" type="primary" size="big">给分</el-button>
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
        </div>
        <div v-if="showPagination == false">
            <el-empty description="当前试卷没有应用题需要批改哦~"></el-empty>
        </div>
    </div>
</template>

<script>
    export default{
        data(){
            return{
                examCode:null,
                pagination:{
                    current:1,
                    size:6,
                    total:null
                },
                MarkOptions: [
                    {
                    value: '0',
                    label: '0分'
                    },
                    {
                    value: '1',
                    label: '1分'
                    }, {
                    value: '2',
                    label: '2分'
                    }, {
                    value: '3',
                    label: '3分'
                    }, {
                    value: '4',
                    label: '4分'
                    }, {
                    value: '5',
                    label: '5分'
                    },
                    {
                    value: '6',
                    label: '6分'
                    },
                    {
                    value: '7',
                    label: '7分'
                    },
                    {
                    value: '8',
                    label: '8分'
                    },
                    {
                    value: '9',
                    label: '9分'
                    },
                    {
                    value: '10',
                    label: '10分'
                    },
                ],
                showPagination:true,
            }
        },
        methods:{
            //分页获取应用题阅卷信息
            getCorrectPaper(){
                this.$axios(`/API/getCorrectPaperByExamCode/${this.examCode}/${this.pagination.current}/${this.pagination.size}`).then(res =>{
                    if(res.data.code == 200){
                        this.pagination = res.data.data
                        console.log(this.pagination.records)
                        if(this.pagination.records.length === 0){
                            this.showPagination = false;
                            console.log("空了")
                        }
                    }
                })
                
            },
            //给某道题分
            sendMark(row,mark){
                console.log("得分："+mark)
                if(mark == '' || mark == undefined ){
                    mark = -1;
                }
                let obj = {
                    correctId:row.correctId,
                    examCode:row.examCode,
                    examineeId:row.examineeId,
                    subject:row.subject,
                    appMark:mark,
                    question:row.question,
                }
                this.$axios({
                    method:'POST',
                    url:`/API/sendMark`,
                    data:{
                        ...obj
                    }
                }).then(res =>{
                    if(res.data.code == 200){
                        this.$message({
                            message:'给分已生效',
                            type:'success'
                        })
                        this.getCorrectPaper()  
                    }
                })
            },
            //获取examCode
            initExamCode(){
                this.examCode = this.$route.query.examCode
            },
            


            handleSizeChange(val){
                this.size = val;
                this.getCorrectPaper();
            },
            handleCurrentChange(val){
                this.current = val;
                this.getCorrectPaper();
            }

        },
        created(){
            this.initExamCode()//先获取考试代码
            this.getCorrectPaper()     
        }
    }

</script>

<style>
.el-table .cell {
  white-space: pre-wrap;   /*这是重点。文本换行*/
}
.selectMark{
    width:100px;
    margin-right:16px;
}
</style>