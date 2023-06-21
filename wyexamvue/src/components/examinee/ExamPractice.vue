<template>
    <div >
        <div class="title"></div>
            <div class="MainBox">
              <ul class="topOrder">
                  <li class="order">
                    <el-badge :value="tempDateInfo.all" class="item" type="primary">
                      <span>全部</span>
                    </el-badge>
                  </li>
                  <li class="order">
                    <el-badge :value="tempDateInfo.notStarted" class="item" type="primary">
                      <span>未开始</span>
                    </el-badge>
                  </li>
                  <li class="order">
                    <el-badge :value="tempDateInfo.started" class="item" type="primary">
                      <span>已开始</span>
                    </el-badge>
                  </li>
                  <li class="order">
                    <el-badge :value="tempDateInfo.expire" class="item">
                      <span>已过期</span>
                    </el-badge>
                  </li>

                  <!-- <li class="paperList">我的练习</li> -->
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
                    :page-sizes="[ 10, 20]"
                    :page-size="paging.size"
                    layout="total, sizes, prev, pager, next, jumper"
                    :total="paging.totalP">
                    </el-pagination>
                </div>
            </div>
            
        </div>
</template>

<script>
import { mapState,mapMutations } from 'vuex'
    export default{
        data(){
            return{
                loading:false,
                SearchKeyWord:'',//搜索关键字
                paging:{  //分页后的考试信息
                    currentP:1,//当前页
                    totalP:null,//总页数
                    size:10,//每页条数
                    records:null,
                },
                show2:true,
                all:null,
                tempDateInfo:{//辅助存储变量
                  all:null,
                  notStarted:null,
                  started:null,
                  expire:null,
                }
                
                
            }
        },
        created(){
            this.getAllExam()
            this.loading = true
            
        },
        mounted(){

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
                    this.paging = res.data.data;
                    this.paging.currentP = res.data.data.current
                    this.loading = false;
                    this.initExamDateInfo()//获取初始化提示日期变量
                }).catch(error =>{
                    console.log(error)
                })
                
            },
            Search(){
              //因为要满足考生只能考自己班级的试卷，下列代码废除
              //   this.$axios.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded; charset=UTF-8'
              //   this.$axios(`/API/getAllExams`).then(res => {  
              //       if(res.data.code == 200) {
              //       let ExamInfo = res.data.data
              //       let newPage = ExamInfo.filter(itemRecords => {
              //           return itemRecords.courseName.includes(this.SearchKeyWord)
              //       })
              //       this.paging.records = newPage
              //   }
              // })
              let ExamInfo = this.paging.records;
              let newPage = ExamInfo.filter(itemRecords => {
                  return itemRecords.courseName.includes(this.SearchKeyWord)
              })
              this.paging.records = newPage

            },
            getCurrentDate(){
              // 创建一个当前时间的日期对象
              const date = new Date();
              // 获取年、月、日的数字值
              const year = date.getFullYear();
              const month = date.getMonth() + 1;
              const day = date.getDate();
              // 将月份和日期转换为两位数的字符串形式
              const monthStr = month < 10 ? '0' + month : month;
              const dayStr = day < 10 ? '0' + day : day;
              // 拼接成 yy-MM-dd 格式的字符串
              const formattedDate = `${year}-${monthStr}-${dayStr}`;
              return formattedDate;
            },
            initExamDateInfo(){
              if(this.ExamDateInfo == null || this.ExamDateInfo === {} || this.ExamDateInfo == ''){
                //因为要满足考生只能考自己班级的试卷，下列代码废除
                // this.$axios('/API/getExamDateInfo').then(res =>{ //获取日期信息用于显示提醒
                //   if(res.data.code == 200){
                //     // this.tempDateInfo.noStarted = res.data.data.noStarted
                //     // this.tempDateInfo.started = res.data.data.started
                //     // this.tempDateInfo.expire = res.data.data.expire
                //     this.tempDateInfo = {...res.data.data}
                //     this.$store.commit('setExamDateInfo',res.data.data)
                //   }
                // })

                //获取日期信息用于显示提醒
                let temp = this.paging.records;
                console.log(this.paging.records)
                let notStartedParam = 0;//未开始
                let startedParam = 0;//已开始
                let expireParam = 0;//过期
                let nowDate = new Date();//YY-mm-dd格式
                let len = this.paging.records.length;
                for(let i = 0; i < len; i++){

                  const start = new Date(temp[i].examDate)
                  const end = new Date(temp[i].examDeadline)
                  if(start > nowDate){ //未开始
                    notStartedParam += 1;
                  }else if(end < nowDate){ //已结束
                    expireParam += 1;
                  }else if(start <= nowDate && end >= nowDate){ //已开始未结束
                    startedParam += 1;
                  }
                }
                let obj = {
                  all:len,
                  notStarted:notStartedParam,
                  started:startedParam,
                  expire:expireParam,
                }
                this.tempDateInfo.all = len;
                this.tempDateInfo.notStarted = notStartedParam
                this.tempDateInfo.started = startedParam
                this.tempDateInfo.expire = expireParam
                this.$store.commit('setExamDateInfo',obj)
              }else{
                console.log(this.ExamDateInfo)
                this.tempDateInfo.all = this.ExamDateInfo.all
                this.tempDateInfo.notStarted = this.ExamDateInfo.notStarted
                this.tempDateInfo.started = this.ExamDateInfo.started
                this.tempDateInfo.expire = this.ExamDateInfo.expire
                // this.tempDateInfo = this.ExamDateInfo
              }
            },
            entryExamMsg(id){
              this.$store.commit('changeIsPractice',true)//标记为练习模式
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
            ...mapMutations(['setExamDateInfo'])
        },
        computed:{
          ...mapState(['ExamDateInfo'])
        }
    }

</script>

<style scoped>
.topOrder .btnSearch{
  display:flex;
  margin-right:10vh;
}
.topOrder .paperList{
  display:flex;
  margin-left: auto;
}
.topOrder .search-li {
  margin-left: auto;
}
.topOrder li{
  display:flex;
  align-items: center;
  margin: 20px;
  cursor:default;
  border-bottom: 2px solid transparent;
}

.topOrder .order:hover{
  color: #0195ff;
  border-bottom: 5px solid #0195ff;
  transition:1s ease;
}

.topOrder{
  display:flex;
  list-style-type: none;
  border-bottom:1px solid #d5d5d5;
}
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
    display:inline-block; /* 使用该注解使得可以变换长度和宽度 */
    background-color:#d5d5d5;
    box-shadow: 0 0 4px 2px rgba(217,222,234,0.3);
    transition: all 0.6s ease;
    padding:10px;
}
.MainBox .topBar {
  border-bottom: 1px solid rgb(255, 253, 253);
  margin-bottom: 20px;
  display: flex;
  justify-content:center;
  width:100%;
  height:100px;
}
.topBar li{
    display:flex;
    margin-right:auto;/* 为什么无效？ */
    align-items: center;
}
.testPaper h3{
    color:#344058e8;
    cursor: pointer;
    display:flex;
}

.MainBox  .topBar .paperList {
  cursor: pointer;
}
.MainBox .topBar .paperList:hover {
  color: #0195ff;
  border-bottom: 2px solid #0195ff;
}
.MainBox .topBar .paperList:visited {
  color: #0195ff;
  border-bottom: 2px solid #0195ff;
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
.MainBox .paperList {
  display: flex;
  justify-content: space-around;
  flex-wrap: wrap;
}

.topBar .el-icon-search {
  position: absolute;
  right: 10px;
  top: 10px;
}
.topBar .icon {
  position: relative;
}
.topBar .search-li {
  margin-left: auto;
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