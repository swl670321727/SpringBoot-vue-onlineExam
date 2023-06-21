<template>
    <div id="examinee">
        <el-container>
            <el-header>
                <el-row>
                <el-col class="MainBox" :span="24">
                    <div class="index-top bg-purple-dark">
                        <el-col :span="4">
                            <div class="titleSpan">
                                <i class="iconfont icon-kaoshi"></i> <span :style="{height:topNavHeight}">无忧Exam考试系统</span>
                            </div></el-col>
                        <el-col :span="6"><div class="navSpan">
                                <el-breadcrumb separator="/">
                                    <el-breadcrumb-item class="breadcrumb" :to="{path: '/'}"><span :style="{ lineHeight:topNavHeight+'px'}">首页</span></el-breadcrumb-item>
                                    <el-breadcrumb-item class="breadcrumb" :to="{path: 'examList'}"><span :style="{ lineHeight:topNavHeight+'px'}" >我的考试</span></el-breadcrumb-item>
                                    <el-breadcrumb-item class="breadcrumb" :to="{path: 'examPractice'}"><a href="javascript:;"><span :style="{ lineHeight:topNavHeight+'px'}" >个人练习</span></a></el-breadcrumb-item>
                                    <el-breadcrumb-item class="breadcrumb" :to="{path: '/markTable'}"><span :style="{ lineHeight:topNavHeight+'px'}" > 成绩</span></el-breadcrumb-item>
                                </el-breadcrumb>
                            </div>
                        </el-col>
                        <el-col :span="2"><div class="InfoSpan"><i class="el-icon-school"></i><span :style="{ lineHeight:topNavHeight+'px'}" >{{Examinee.grade}}届</span></div></el-col>
                        <el-col :span="3"><div class="InfoSpan"><i class="el-icon-user-solid"></i><span :style="{ lineHeight:topNavHeight+'px'}" >{{ Examinee.major }}{{ Examinee.clazz }}班</span></div></el-col>
                    
                        <el-col class="selfClass" :span="6">
                            <el-dropdown>
                                <span class="el-dropdown-link">
                                    <div class="selfSpan">
                                        <i class="el-icon-user"></i><span :style="{ lineHeight:topNavHeight+'px'}" >{{ Examinee.examineeId}}[{{ Examinee.examineeName }}]</span>
                                        <i class="el-icon-arrow-down el-icon--right"></i>
                                    </div>
                                    
                                </span>
                                <el-dropdown-menu slot="dropdown">
                                    <el-dropdown-item @click.native="openPersonal()" icon="el-icon-plus">个人中心</el-dropdown-item>
                                    <!-- <el-dropdown-item icon="el-icon-circle-plus">信息</el-dropdown-item> -->
                                </el-dropdown-menu>
                            </el-dropdown>
                        </el-col>
                    <el-col class="LogOut" :span="3"><div @click="logOut()" class="InfoSpan"><i class="el-icon-switch-button"></i><span :style="{ lineHeight:topNavHeight+'px'}" >退出</span></div></el-col>
                </div>
            </el-col>
        </el-row>
        </el-header>
        
        <el-main>
            <el-row>
            
                <el-col :span="3"><div class="grid-content"></div></el-col>
                <el-col :span="17" class="Main bg- purple-dark">
                
                    <router-view></router-view> <!-- 路由区域 -->
                
                </el-col>
            </el-row>
        </el-main>
            <el-footer><v-footer class="footer"></v-footer></el-footer>
        </el-container>
        
    </div>
</template>

<script>
import indexFooter from '@/components/examinee/indexFooter.vue' 
import { mapMutations, mapState } from 'vuex'
    export default{
        components:{ //这里写少了一个s导致一直无法正常显示
            'v-footer':indexFooter
        },
        data(){
            return{
                Examinee:{
                    academe:'',//学院
                    grade:'',//年级
                    clazz:null,//班级
                    examineeId:'',//学号
                    examineeName:'',//姓名
                    major:''//专业
                },
                topNavHeight:(document.documentElement.clientHeight) * 0.055,//计算顶端栏自适应高度
            }
        },
        methods:{
            //跳转
            toMain(){
                //
                // this.$router.push('/')
            },
            getUserInfo(){
                //判断是否记住密码，否则刷新即退出
                // let flag = this.$cookies.get('IsRemember');
                // if(flag == 'false'){//记住密码
                //     this.$cookies.remove('uid')
                //     this.$cookies.remove('uname')
                //     this.$cookies.remove('uInfo')
                //     this.$cookies.remove('IsRemember')
                //     this.$router.push('/')//返回登录页面
                //     return;
                // }
                //判空
                if(this.$cookies.get("uInfo") != null){
                    let obj = this.$cookies.get("uInfo")
                    this.Examinee.academe       = obj.academe
                    this.Examinee.grade         = obj.grade
                    this.Examinee.clazz         = obj.clazz
                    this.Examinee.examineeId    = obj.examineeId
                    this.Examinee.examineeName  = obj.examineeName
                    this.Examinee.major         = obj.major
                }
            },
            logOut(){
                this.$confirm("是否退出登录?","友情提示",{
                    confirmButtonText: '坚持退出',
                    cancelButtonText: '再停留一会',
                    type: 'warning'
                }).then(() =>{
                    this.$cookies.remove('uid')
                    this.$cookies.remove('uname')
                    this.$cookies.remove('uInfo')
                    this.$cookies.remove('IsRemember')
                    const h = this.$createElement;
                    this.$message({
                            message: h('p', null, [
                                h('span', null, ' 嘿！'),
                                h('i', { style: 'color: teal' }, '您已退出登录')
                            ])
                        });
                    this.$router.push('/')
                    return;
                })
            },
            openPersonal(){//打开个人中心
                this.$router.push('/personal')

            },
            // initExamDateInfo(){
            //     if(this.ExamDateInfo == null ){ //说明日期参数信息还未初始化，获取一次
            //         this.$axios('/API/getExamDateInfo').then(res =>{ //获取日期信息用于显示提醒
            //         if(res.data.code == 200){
            //             this.$store.commit('setExamDateInfo',res.data.data)//获取成功，修改vuex内的值
            //             }
            //         })
            //     }
            // }
        },
        created(){
            this.getUserInfo()
            // this.initExamDateInfo()
            this.$router.push('/examList')
        },
        
        computed:{
            ...mapState(["IsPractice"])
        },
    }

</script>

<style lang="less" scoped>
#examinee{
    background-color: #d5d5d5;
    display:flex;
    flex-direction:column;
    min-height:100%;
} 
.MainBox{
    line-height:50px;
    background-color:#354159;
}
.footer{
    width:100%;
    /* position:absolute;
    bottom:0; */
}
/* 整体布局 */
.el-header{
    padding:0;
}
.el-footer{
    padding:0;
}
/* 整体布局 */
.el-dropdown{
    width:100%;
}
.Navigation{
    width:100%;
    list-style-type: none;
    height:100%;
}
.Navigation li{
    margin-left:10px;
    display:inline;
    text-align: center;
    line-height:40px;
}

.Navigation a{
    color:white;
    font-weight:bold;
    font-size:20px;
    text-decoration:none;
}
.Main{
    display:flex;
    height:85vh;
    overflow-x:hidden;
    overflow-y:scroll;
    background-color:#f6f6f6;
}
.el-row {
    margin-bottom: 20px;
}
  .el-col {
    border-radius: 4px;
  }
  .bg-purple-dark {
    background: #99a9bf;
  }
  .bg-purple {
    background: #d3dce6;
  }
  .bg-purple-light {
    background: #e5e9f2;
  }
  .grid-content {
    border-radius: 4px;
    min-height: 36px;
  }
  .row-bg {
    padding: 10px 0;
    background-color: #f9fafc;
  }
    /* 设计顶端栏 */
.titleSpan{
    display:flex;
    justify-content:center;
    align-items:center;

}
.titleSpan span{
    font-weight:bold !important;
    font-family: "Helvetica Neue";
    font-size:16px;
    line-height:60px;
    text-align: center;
    color:rgb(241, 234, 234);
}
.titleSpan i{
    font-size:50px;
    color:rgb(241, 234, 234);
}
.navSpan{
    display:flex;
    justify-content:center;
    align-items:center;
}

/* 重写面包屑样式 */

.breadcrumb span{
    color:#e5e9f2;
    line-height:60px;
    margin-right:20px;
    cursor:pointer;
    font-weight:bold;
}
.breadcrumb span:hover{
    color:#20b2aa;
    // color:#5e78b3;
    transition:0.5s;
}
.InfoSpan{

    font-weight:bold;
    /* font-family: "Helvetica Neue"; */
    font-family: "微软雅黑";
    color:rgb(241, 234, 234);
}

.InfoSpan span{
    font-size:16px;
    text-align: center;
    line-height:0px;
}
.InfoSpan i{
    font-size:25px;
    margin:10px;
}
.LogOut .InfoSpan{
    cursor:pointer;
}
.LogOut .InfoSpan:hover{
    border-bottom:5px solid #20b2aa;
    transition: 1s;
}
.LogOut .InfoSpan:hover span{
    color:#20b2aa;
    transition:ease 0.2s;
}
.LogOut .InfoSpan:hover i{
    color:#20b2aa;
    transition:ease 0.2s;
}
.selfSpan{
    font-weight:bold;
    /* font-family: "Helvetica Neue"; */
    font-family: "微软雅黑";
    color:rgb(241, 234, 234);
    cursor: pointer;
}
.selfSpan .el-icon-user{
    font-size:25px;
    margin:10px;
}
.selfSpan:hover{
    transition:0.5s;
    color:#20b2aa;
}
</style>