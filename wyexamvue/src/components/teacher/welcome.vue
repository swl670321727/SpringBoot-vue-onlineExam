<template>
    <section class="index">
      <div class="hello">
        <i class="iconfont el-icon-guide"></i><span>很高兴遇见你,{{user.userName}}老师。</span>
      </div>
      <div class="msg">
        <p class="title">教务公告：</p>
        <ul>
          <li @click="openMsg()"><i class="iconfont icon-flag"></i>中期报告提交通知</li>
          <li @click="openMsg()"><i class="iconfont icon-flag"></i>下周例行工作报告会</li>
          <li @click="openMsg()"><i class="iconfont icon-flag"></i>关于毕业生答辩具体流程</li>
        </ul>
      </div>
    </section>
  </template>
  
  <script>
  export default {
    data() {
      return {
        user: { //用户信息
          userName: null,
          userId: null
        } 
      }
    },
    created() {
      this.getUserInfo()
    },
    methods: {
      getUserInfo() { //获取用户信息
        let userName = this.$cookies.get("cname")
        let userId = this.$cookies.get("cid")
        this.user.userName = userName
        this.user.userId = userId
      },
      openMsg() {
        this.$alert('根据教务处通知，请尽快通知学生与2023年3月30号前提交毕业论文中期报告，','中期报告提交通知',{
          confirmButtonText: '确定'
        })
      }
    }
  }
  </script>
  
  
  <style  scoped>
.index {
margin-left: 70px;
}
.index .hello {
font-size: 20px;
color: #726f70;
}
.index .hello  .el-icon-guide {
font-size: 50px;
color: #20b2aa;
}
.msg .title {
font-size: 16px;
color: #000;
margin-top: 20px;
margin-left: 10px;
}
.msg ul {
display: flex;
flex-direction: column;
width: 200px;
overflow: hidden;
}
.msg li {
margin-top: 10px;
font-size: 14px;
color: #20b2aa;
cursor: pointer;
display: inline-block;
}

  </style>
  
  