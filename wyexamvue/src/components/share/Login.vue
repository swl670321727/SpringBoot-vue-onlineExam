<!-- 登录页面 -->
<template>
    <div id="app">
        <!-- <img id = 'bgIndex' :style= "{height:winfullHeight+'px'}" src = '../../../static/img/bgIndex.jpg'/> -->
        <el-row class="topBar">
            <el-col :span="4">
                <div class="titleSpan">
                        <i class="iconfont icon-kaoshi"></i> <span :style="{height:topNavHeight}">无忧Exam考试系统</span>
                </div>
            </el-col>
            <el-col :span="20">
                <div class="titleSpan">
                        <span :style="{height:topNavHeight}"></span>
                </div>
            </el-col>
        </el-row>
        <div class="centerBg">
            <img id = "Scenes" src = '../../assets/Scenes.png'/>
        </div>
        <!-- 登录 -->
        <transition name="el-zoom-in-center">
            <div v-show="showLogin" class="transition-box">
                <el-row class="loginBg">
                    <el-col :span="9">
                        <div class="grid-content bg-purple"></div></el-col>
                    <el-col :span="6"><div :style="{top:loginLocation+'px'}" class="grid-content bg-purple-light">
                        <div class="LoginBox">
                            <el-row>
                                <el-col :span="11">
                                <span>登录</span><br>
                                </el-col>
                            </el-row>
                                <div class = "input-box">
                                    <el-col :span="24">
                                            <el-input 
                                            maxlength="9"
                                            placeholder="请输入账号"
                                            prefix-icon="el-icon-user"
                                            v-model.number="whoYou.loginAccount">
                                            </el-input>
                                    </el-col>
                                </div>
                                
                            <el-row>
                                <div class = "input-box">
                                    <el-col :span="24">
                                        <el-input
                                            placeholder="请输入密码"
                                            prefix-icon="el-icon-lock"
                                            v-model="whoYou.loginPwd"
                                            :show-password="false"
                                            type="password">
                                        </el-input>
                                    </el-col>
                                </div>
                            </el-row>
                            <el-row >
                                <el-col :span="12"><div class="grid-content"></div></el-col>
                                <el-col :span="12">
                                    <el-checkbox v-model="IsRemember">记住密码</el-checkbox>
                                </el-col>
                            </el-row>
                            <el-row >
                                <el-col :span="3"><div class="grid-content"></div></el-col>
                                <el-col :span="18">
                                    <el-radio v-model="whoYou.loginPart" label="2">考生</el-radio>
                                    <el-radio v-model="whoYou.loginPart" label="1">教职工</el-radio>
                                    <el-radio v-model="whoYou.loginPart" label="0">管理员</el-radio>
                                </el-col>
                                <el-col :span="3"><div class="grid-content"></div></el-col>
                            </el-row>
                            <el-row >
                                <el-col :span="14"><div class="grid-content"></div></el-col>
                                <el-col :span="10">
                                    <el-link @click="RegisterAdmin()">前往注册</el-link>
                                </el-col>
                            </el-row>
                            
                            <el-button @click="login()" type="primary">登录</el-button>
                            </div>
                        </div>
                    </el-col>
                </el-row>
            </div>
        </transition>
        <!-- 登录 -->


        <!-- 注册 -->
        <transition name="el-zoom-in-bottom">
            <div v-show="showRegister" class="transition-box">
                <el-row class="loginBg">
                    <el-col :span="9"><div class="grid-content bg-purple"></div></el-col>
                    <el-col :span="6"><div :style="{top:loginLocation+'px'}" class="grid-content bg-purple-light">
                        <div class="LoginBox">
                            <el-row>
                                <el-col :span="11">
                                <span>注册</span><br>
                                </el-col>
                            </el-row>
                                <div class = "reg-box">
                                    <el-col :span="24">
                                            <el-input 
                                            maxlength="9"
                                            placeholder="请输入账号"
                                            prefix-icon="el-icon-user"
                                            v-model.number="RegInfo.regAccount">
                                            </el-input>
                                    </el-col>
                                </div>
                                
                            <el-row>
                                <div class = "reg-box">
                                    <el-col :span="24">
                                        <el-input
                                            placeholder="请输入密码"
                                            prefix-icon="el-icon-lock"
                                            v-model="RegInfo.regPwd1"
                                            :show-password="true"
                                            type="password">
                                        </el-input>
                                    </el-col>
                                </div>
                            </el-row>

                            <el-row>
                                <div class ="reg-box">
                                    <el-col :span="24">
                                        <el-input
                                            placeholder="请再次输入密码"
                                            prefix-icon="el-icon-lock"
                                            v-model="RegInfo.regPwd2"
                                            :show-password="true"
                                            type="password">
                                        </el-input>
                                    </el-col>
                                </div>
                            </el-row>

                            <el-row>
                                <div class = "reg-box">
                                    <el-col :span="24">
                                        <el-input
                                            placeholder="请输入秘钥"
                                            prefix-icon="el-icon-key"
                                            v-model="RegInfo.secretKey"
                                            :show-password="true"
                                            type="password">
                                        </el-input>
                                    </el-col>
                                </div>
                            </el-row>
                            <el-row >
                                <el-col :span="14"><div class="grid-content"></div></el-col>
                                <el-col :span="10">
                                    <el-link @click="GotoLogin()">前往登录</el-link>
                                </el-col>
                            </el-row>
                            
                            <el-button class="el-button-reg" @click="register()" type="primary">注册</el-button>
                            </div>
                        </div>
                    </el-col>
                </el-row>
            </div>
        </transition>
            
        <!-- 注册 -->
        
            <el-col :span="9"><div class="grid-content bg-purple"></div></el-col>
        
    </div>
</template>

<script>
import qs from 'qs'
    export default{
        data(){
            return{
                //保存数据，实现动态渲染
                //注意：这里没有带‘px’单位，在上面添加动态样式时，需要加上px单位！！！
                winfullWidth: document.documentElement.clientWidth,
                winfullHeight: document.documentElement.clientHeight,
                
                //账号密码
                whoYou:{
                    loginAccount:null,
                    loginPwd:null,
                    loginPart:null,
                },
                //注册的账号密码
                RegInfo:{
                    regAccount:'9527',
                    regPwd1:'123456',
                    regPwd2:'123456',
                    secretKey:'111'//秘钥
                },
                topNavHeight:50+'px',
                IsRemember:false,//是否记住密码，默认否
                showLogin:true,
                showRegister:false,
            }
        },
        methods:{
            //获取页面数据
            handleResize () {
                this.winfullWidth = document.documentElement.clientWidth
                this.winfullHeight = document.documentElement.clientHeight
            },
            login(){
                //判空
                if(this.whoYou.loginAccount == '' || this.whoYou.loginPwd == ''||
                this.whoYou.loginAccount == null || this.whoYou.loginPwd == null
                || this.whoYou.loginPart == null || this.whoYou.loginPart == '') {
                    const h = this.$createElement;
                    this.$message({
                        message: h('p', null, [
                            h('span', null, ' 嘿！'),
                            h('i', { style: 'color: teal' }, '登录信息不可为空')
                        ])
                    });
                    return;
                }

                console.log("登录操作执行-------");
                // if(this.whoYou.loginAccount == '201915270206'&& this.whoYou.loginPwd =='123456'){
                //     // 登录成功 ，调试阶段
                //     this.$router.push({path: '/index'})
                //     return;
                // }
                let _this = this;
                this.$axios.defaults.headers.post['Content-Type'] = 'application/json;charset=utf-8' //不加这个会415错误
                this.$axios({
                    url: `/API/login`,
                    method: 'post',
                    data: {
                        ...this.whoYou
                    },
                    // headers:{
                    //     'ContentType':'application/json'
                    // }
                }).then(res=>{
                    let resData = res.data.data
                    // console.log(resData.part)
                    if(resData != null) {
                    switch(resData.part) {
                        case "0":  //管理员
                        this.$cookies.set("cname", resData.adminName,{expires:1})
                        this.$cookies.set("cid", resData.adminId,{expires:1})
                        this.$cookies.set("cInfo", resData,{expires:1})
                        this.$cookies.set("part", 0)
                        this.$router.push({path: '/welcome' }) //跳转到首页
                        break
                        case "1": //教职员
                        this.$cookies.set("cname", resData.teacherName,{expires:1})
                        this.$cookies.set("cid", resData.teacherId,{expires:1})
                        this.$cookies.set("cInfo", resData,{expires:1})
                        this.$cookies.set("part", 1)
                        this.$router.push({path: '/welcome' }) //跳转到教职员用户
                        break
                        case "2": //考生
                            this.$cookies.set("uname", resData.examineeName,{expires:1})
                            this.$cookies.set("uid", resData.examineeId,{expires:1})
                            this.$cookies.set("uInfo", resData,{expires:1})
                            this.$cookies.set("IsRemember", _this.IsRemember)//是否记住密码//7天过期
                            this.$router.push({path: '/examinee'})
                        break
                        }
                        if(this.$cookies?.get("IsRemember") == 'true'){
                            this.$cookies.set("uname", resData.examineeName,{expires:7})
                            this.$cookies.set("uid", resData.examineeId,{expires:7})
                            this.$cookies.set("uInfo", resData,{expires:7})
                        }
                    }
                        if(resData == null) { //输入有误
                        this.$message({
                            showClose: true,
                            type: 'error',
                            message: '用户名或者密码错误'
                        })
                    }
                })
            },
                //管理员注册
            register() {
                //判空
                if(this.RegInfo.regPwd1 == '' || this.RegInfo.regPwd2 == ''||
                this.RegInfo.regAccount == '' || this.RegInfo.secretKey == ''||
                this.RegInfo.regPwd1 == null || this.RegInfo.regPwd2 == null||
                this.RegInfo.regAccount == null || this.RegInfo.secretKey == null){
                    const h = this.$createElement;
                    this.$message({
                        message: h('p', null, [
                            h('span', null, ' 嘿！'),
                            h('i', { style: 'color: teal' }, '注册信息不可为空')
                        ])
                    });
                    return;
                }
                if(this.RegInfo.regPwd2 !== this.RegInfo.regPwd1 ){
                    const h = this.$createElement;
                    this.$message({
                        message: h('p', null, [
                            h('span', null, ' 嘿！'),
                            h('i', { style: 'color: teal' }, '两次密码不一致')
                        ])
                    });
                    return;
                }
                console.log("注册操作执行-------");
                //判断账号是否已经被抢注
                var _this = this
                this.$axios({
                    url: `/API/getAdminByAcc/${_this.RegInfo.regAccount }`
                }).then(res =>{
                    if(res.data.code == 400){//未被注册
                        //更新过程顺带，检查秘钥
                        this.$axios({
                            url:'/API/Key4IsUsed',
                            method:'post',
                            data:_this.RegInfo.secretKey,
                            headers: {
                                'Content-Type': 'application/json;charset=utf-8'
                            }
                        }).then(res =>{
                            if(res.data.code == 200){
                                this.$axios('API/addAdmin',{
                                    method:'post',
                                    data:{
                                        regAccount:_this.RegInfo.regAccount,
                                        regPwd:_this.RegInfo.regPwd2,
                                    },
                                    headers: {
                                        'Content-Type': 'application/json;charset=utf-8'
                                    }
                                }).then(res =>{
                                    if(res.data.code == 200){
                                        this.$message({
                                            message: '注册成功，正在跳转。',
                                            type: 'success'
                                        });
                                        _this.GotoLogin()//跳转
                                    }
                                })
                            }else{
                                this.$alert('该秘钥已过期或无效', '提示', {
                                    confirmButtonText: '确定',
                                    callback: action => {
                                        this.$message({
                                        type: 'info',
                                        message: `action: ${ action }`
                                        });
                                    }
                                })
                            }

                        })
                        
                    }else{
                        this.$alert('该账号名已被占用，请重试', '提示', {
                                    confirmButtonText: '确定',
                                })
                    }


                })
            },
            RegisterAdmin(){
                this.showLogin = !this.showLogin;//关掉登录框
                setTimeout(()  =>{//使用延时不会导致鬼畜
                    this.showRegister = !this.showRegister;
                },500)
                //首先判断
            },
            GotoLogin(){
                this.showRegister = !this.showRegister;//关掉注册框
                setTimeout(()  =>{ //使用延时不会导致鬼畜
                    this.showLogin = !this.showLogin;
                },500)
            },
            IsRememberFunc(){
                if(this.$cookies?.get('IsRemember') === 'true'){
                    let uInfo = this.$cookies.get('uInfo');
                    this.whoYou.loginPwd = uInfo.pwd;
                    this.whoYou.loginAccount = uInfo.examineeId;
                    this.IsRemember = true;
                    this.$notify({
                        title: '欢迎您',
                        message: '已根据记忆的账户自动填入',
                        type: 'success'
                    });
                }
            }

        },
        computed:{
            
            loginLocation(){
                return this.winfullHeight * 0.25; //计算登录框自适应位置
            }
        },
        //监听窗口的大小变化
        created () {
            this.IsRememberFunc()
            window.addEventListener('resize', this.handleResize)//回调函数
        },
        beforeUnmount () {
            window.removeEventListener('resize', this.handleResize)
        }
    }

</script>

<style scoped>

body{
    display:flex;
    justify-content: center;
    flex-direction: column;
    align-items:center;
}
#app{
    background-color:#0154cf;
}
.el-zoom-in-bottom{
    transition:1s ease;
}
#Scenes{
    position:absolute;
    left:0;
    top:20vh;
    z-index:5;
    width:40%;
    display:flex;
}
.LoginBox{
    padding: 30px;
    width:328px;
    height:355px;
    /* border-top:1px solid rgba(255,255,255,0.5);
    border-left:1px solid rgba(255,255,255,0.5);
    border-right:1px solid rgba(70, 47, 47, 0.2);
    border-bottom:1px solid rgba(255,255,255,0.2); */
    box-shadow: 15px 15px 10px #0e0d0d;
    background-color:#FFFFFF;
    /* backdrop-filter: blur(10px); */
    /* 边框变圆角 */
    border-radius:5px;
}
.titleSpan{
    display:flex;
    justify-content:center;
    align-items:center;
    background-color:#ffffff; 
    box-shadow:10px 0 10px #0e0d0d;
}
.titleSpan span{
    font-weight:bold !important;
    font-family: "Helvetica Neue";
    font-size:16px;
    line-height:60px;
    min-height:60px;
    text-align: center;
    background: linear-gradient(to right, #0154cf,#26af5b, rgb(226, 226, 23),#0154cf,#0154cf,#0154cf);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    /* color:#0154cf; */

}
.titleSpan i{
    font-size:50px;
    color:#0154cf;
}
.el-col {
    border-radius: 4px;
  }
  .bg-purple-dark {
    background: #99a9bf;
  }
  .bg-purple {
    background: #d3dce6;
    background-color:transparent;
  }
  .bg-purple1{
    background: #d3dce6;
  }
  .bg-purple-light {
    position: relative;
    
    
  }
  .grid-content {

    border-radius: 4px;
    min-height: 36px;
  }
  .row-bg {
    padding: 10px 0;
    background-color: #f9fafc;
  }
  .el-input{
    width:70%;
  }
  


.LoginBox el-input:nth-child(2){
    top:30%;
}
.LoginBox span{
    text-align:right;
    font-size:45px;
    font-family: '优设标题黑';
    color:#0154cf;
}
.RegBox{
    padding: 30px;
    width:328px;
    height:385px;
    border-top:1px solid rgba(255,255,255,0.5);
    border-left:1px solid rgba(255,255,255,0.5);
    border-right:1px solid rgba(70, 47, 47, 0.2);
    border-bottom:1px solid rgba(255,255,255,0.2);
    backdrop-filter: blur(10px);
    /* 边框变圆角 */
    border-radius:5px;
}

.RegBox el-input:nth-child(2){
    top:30%;
}
.RegBox span{
    text-align:right;
    font-size:45px;
    font-family: '优设标题黑';
    color:rgba(255, 255, 255,1);
}
.input-box{
    display:flex;
    justify-content: center;
    flex-direction: row;
    align-items:center;
    margin:20px;
}
.input-box > .el-col> label{
    margin-right: 10px;
    text-align:center;
    color:white;
    font-weight: bold;
}
.reg-box{
    display:flex;
    justify-content: center;
    flex-direction: row;
    align-items:center;
    margin:7px;
}
.reg-box > .el-col> label{
    margin-right: 10px;
    text-align:center;
    color:white;
    font-weight: bold;
}
.el-button{
    position: relative;
    bottom:0%;
    width:100%;
}
.el-button-reg{
    position: relative;
    bottom:2%;
    width:100%;
}
.grid-content .topBar{
    /* background-color:#122c91; */
}
</style>