<template>
  <div class="login">
    
        <el-input class="input1"
            placeholder="请输入用户名"
            v-model="loginName"
            clearable>
          </el-input><br>
          <el-input
          class="input1"
          placeholder="请输入密码"
           v-model="loginPwd" show-password>
           </el-input>
        <h1 class="login-h1">登录</h1>
        <el-button class="login-btn" @click="login()" type="primary">登录</el-button>
  </div>
  
</template>

<script>
import {mapState,mapMutations} from 'vuex'
import qs from 'qs'
export default {
  data(){
      return {
        loginName:"",
        loginPwd:"",
        ...mapState(['status']),
        list:{
          status:'succeedLogin'
        },//登录状态临时变量
      }
  },
  methods:{
      ...mapMutations(['changeLoginStatus']),
      login(){
        //判空
        if(this.loginName == null || this.loginPwd == null) {
          alert("用户名、密码为空！")
          return;
        }

        var _this = this;
        this.$axios({
          url:'userLogin',
          method:'post',
          // headers:{
          //   'Content-Type':'application/json'
          // },
          data:   //post用data传参
                  //使用JSON序列化
                  //JSON.stringify({'user_name':'_this.loginName','user_pwd':'_this.loginPwd'})
            qs.stringify({
              //不是对象不要JSON.stringify
              loginName:_this.loginName,
              loginPwd:_this.loginPwd
            })
        }).then(function(resp){//接收成果,获取登录状态
            if(resp.data != null && resp.data != ""){
              //登录成功
              if(resp.data.user_authority == 'disable'){
                alert('你已被限制登录')
                return;
              }
              var userInfo ={
                isLogin:true,//true表示登录成功
                manage:resp.data.user_identity,//身份
                name:resp.data.user_name,
                id:resp.data.user_id
              }

              //使用localstorage保存登录状态
              localStorage.setItem("userInfo",JSON.stringify(userInfo));
              //登录状态存储在vuex中，注意添加 _this
              _this.changeLoginStatus(userInfo) //踩坑1. 参数多写了一个state导致结果不理想
              //延时提示
              setTimeout(() => {
                alert("登录成功")
                //跳转
                _this.$router.push({
                path:'/MainPage'
                });
              }, 0);
              
            }else{
              alert("登录失败")
            }
        })

      },
      handleClick(tab, event) {
        console.log(tab, event);
      }
  }
}
</script>

<style>
  .login-h1{
    position: absolute;
    left:705px;
    top:200px;
    color:white;
    font-size: 1300;
    z-index: 999;
  }
  .login{
    height:1000px;
    width:100%;
    position: absolute;
    top:-80px;
    background-color: rgb(148, 189, 241);
  }
  .input1{
    display: block;
    width:304px;
    height:37px;
    position:relative;
    top:300px;
    left:580px;
  }
  .login-btn{
    display: block;
    position:relative;
    top:320px;
    left:705px;
  }
</style>
