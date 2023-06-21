<template>
    <div >
        <div class="title"></div>
            <div class="MainBox">
                <ul class="topBar">
                    <li class="paperList">试卷列表</li>
                    <li class="search-li"><div class="icon">
                        <el-input suffix-icon="el-icon-search"
                        type="text" placeholder="试卷名称"
                        class="search" 
                        v-model="SearchKeyWord"></el-input></div></li>
                    <li><el-button class="btnSearch" type="primary"  @click="Search()">搜索试卷</el-button></li>
                </ul>
                <!-- 用v-for循环每一个考试项 -->
                <ul class="testPaper" v-loading= "loading" >
                    <li class="testItem" v-for="(item,index) in  paging.records" :key="index" >
                        <h3 @click="entryExamMsg(item.examCode)">{{item.courseName}}</h3>
                        <p class="curseName">{{item.courseName}}-{{item.descriptions}}</p>
                        <div class="Info">
                            <i class="el-icon-loading"></i><span>{{item.examDate.substr(0,10)}}</span>
                            <i class="iconfont icon-icon-time"></i><span v-if="item.duringTime != null">限时{{item.duringTime}}分钟</span>
                            <i class="iconfont icon-fenshu"></i><span>满分{{item.totalMark}}分</span>
                        </div>
                    </li>
                </ul><br>
                
                <div class="pagination">
                    <el-pagination
                    @size-change="SizeChangeFunc"
                    @current-change="CurrentChangeFunc"
                    :current-page="paging.currentP"
                    :page-sizes="[6, 10, 20, 40]"
                    :page-size="paging.size"
                    layout="total, sizes, prev, pager, next, jumper"
                    :total="paging.totalP">
                    </el-pagination>
                </div>
            </div>
        </div>
</template>

<script>

    export default{
        data(){
            return{
                loading:false,
                SearchKeyWord:'',//搜索关键字
                paging:{  //分页后的考试信息
                    currentP:1,//当前页
                    totalP:null,//总页数
                    size:6//每页条数
                }
            }
        },
        created(){
            this.getAllExam()
            this.loading = true
        },
        methods:{
            getAllExam(){
                // 第一套代码逻辑
                // var _this = this;
                // this.$axios({
                // url:'API/getAllExams4Param',
                // method:'post',
                // data:
                //     qs.stringify({
                //         currentP:_this.paging.currentP,
                //         size:_this.paging.size
                //     })
                // }).then(function(resp){
                //     console.log(resp.data);
                // })
                
                //第二套
                let info = this.$cookies.get('uInfo')
                // this.$axios.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded; charset=UTF-8'
                this.$axios({
                  url:'/API/getAllExams4Param',
                  method:'POST',
                  data:{
                    currentP:this.paging.currentP,
                    size:this.paging.size,
                    clazz:info.clazz,
                    major:info.major,
                    grade:info.grade,
                  }
                }).then(res =>{
                    //根据信息过滤,分页插件无法过滤后的无奈之举  2023年5月10日17:20:09
                    this.paging = res.data.data
                    this.paging.currentP = res.data.data.current
                    this.loading = false;
                }).catch(error =>{
                    console.log(error)
                })
            },
            Search(){
                //请求头不要乱加
                // this.$axios.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded; charset=UTF-8'
                let info = this.$cookies.get('uInfo')
                this.$axios({
                  url:'/API/getAllExams4Param',
                  method:'POST',
                  data:{
                    currentP:this.paging.currentP,
                    size:this.paging.size,
                    clazz:info.clazz,
                    major:info.major,
                    grade:info.grade,
                  }
                }).then(res =>{
                    //根据信息过滤,分页插件无法过滤后的无奈之举  2023年5月10日17:20:09
                    let ExamInfo = res.data.data.records
                    let newPage = ExamInfo.filter(itemRecords => {
                          return itemRecords.courseName.includes(this.SearchKeyWord) 
                      
                    })
                    this.paging.records = newPage
                })
            },
            entryExamMsg(id){
                //
                this.$router.push({path:`/examMsg`,query:{examCode:id}})
            },
            SizeChangeFunc(val){
                this.paging.size = val;
                this.getAllExam();
            }, 
            CurrentChangeFunc(val){
                this.paging.currentP = val;
                this.getAllExam();
            },
            
        },
    }

</script>

<style scoped>

.el-input{
    width:70%;
  }
.MainBox{
    width:100%;
    height:100%;
    /* display:block; */
}
.MainBox .topBar{
    list-style-type: none;
    display:flex;
    padding:0;
    margin-left:5vh;
}
.MainBox .testPaper{
    list-style-type: none;
    display:flex;
    flex-wrap: wrap;
    
}
.MainBox .search-li{
    margin-left: auto;
}

.testPaper .testItem{
    margin:10px;
    width:28%;
    display:block;
    background-color:#d5d5d5;
    box-shadow: 0 0 4px 2px rgba(217,222,234,0.3);
    transition: all 0.6s ease;
    padding:10px;
}
.MainBox .topBar {
  border-bottom: 1px solid #d5d5d5;
  margin-bottom: 20px;
  display: flex;
  justify-content:center;
  width:100%;
  height:100px;
}
.topBar li{
    display:flex;
    align-items: center;
}
.testPaper h3{
    display:flex;
    font-family:"Helvetica Neue", Helvetica, "PingFang SC", Tahoma, Arial, sans-serif;
    cursor: pointer;
}

.MainBox  .topBar .paperList {
  cursor: pointer;
  display: flex;
  margin-right:auto;
  border-bottom: 2px solid transparent;
}
.MainBox .topBar .paperList:hover {
  color: #0195ff;
  border-bottom: 5px solid #0195ff;
  transition:1s ease;
}
.MainBox .topBar .btnSearch{
  display:flex;
  margin-right:15vh;
}

.testItem .Info i {
  margin-right: 5px;
  color: #0195ff;
}
.testItem .Info span {
  margin-right: 14px;
}
.testPaper .testItem {
  width: 380px;
  border-radius: 4px;
  padding: 20px 30px;
  border: 1px solid #eee;
  box-shadow: 0 0 4px 2px rgba(217,222,234,0.3);
  transition: all 0.6s ease;
}
.testPaper .testItem:hover {
  box-shadow: 0 0 4px 2px rgba(140, 193, 248, 0.45);
  transform: scale(1.03);
}
.testPaper .testItem .Info {
  font-size: 14px;
  color: #88949b;
}
.testPaper .testItem .curseName {
    position:relative;
    left:10px;
  font-size: 14px;
  color: #88949b;
}
.testPaper * {
  margin: 20px 0;
}

.topBar .el-icon-search {
  position: absolute;
  right: 10px;
  top: 10px;
}
.topBar .icon {
  position: relative;
}

.topBar .search {
  margin-left: auto;
  border-radius: 2px;
  box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
  transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
}
.topBar .el-input:hover {
  color: #0195ff;
  border-color: #0195ff;
}

.MainBox .topBar li {
  margin: 20px;
}
.transition-box {
    margin-bottom: 10px;
    width: 200px;
    height: 100px;
    border-radius: 4px;
    background-color: #409EFF;
    text-align: center;
    color: #fff;
    padding: 40px 20px;
    box-sizing: border-box;
    margin-right: 20px;
  }
.pagination{
    display: flex;
    left:75vh;
    position:absolute;
    bottom:4vh;
}
</style>