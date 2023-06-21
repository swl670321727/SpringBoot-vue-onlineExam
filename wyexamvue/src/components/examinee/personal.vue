<template>
    <div id="personal">
        <div class="splitLine">
            <p>个人中心</p>
        </div>
        <el-row class="MainBox">
            <el-col class="left" :span="12">
                <el-row>
                    <el-col :span="12">
                        <div class="ppBox" >
                            <el-image class="profilePhoto"
                            style="width: 210px; height: 200px"
                            :src="require('../../assets/userIcon.jpg')"
                            ></el-image>
                        </div>
                    </el-col>
                    <el-col :span="12">
                        <el-upload class="avatar-uploader"
                            action="https://jsonplaceholder.typicode.com/posts/"
                            :show-file-list="false"
                            :on-success="handleAvatarSuccess"
                            :before-upload="beforeAvatarUpload"
                        >
                            <img v-if="imageUrl" :src="imageUrl" class="avatar">
                            <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                        </el-upload>
                    </el-col>
                </el-row>
                
                <el-row>
                    <el-col class="ToDoList" :span="12">
                        <el-badge :value="3" class="item">
                            <span size="small">待办事项
                            </span>
                        </el-badge>
                        <div class="splitLine"></div>
                        <section>
                            <div class="contentStarted" v-if="tempDateInfo.started > 0">
                                您有[{{ tempDateInfo.started }}]场考试已经开始，请注意开考时间后截止时间前完成考试，否则无法考试，不计入成绩。
                            </div>
                            <div class="contentNoStarted" v-if="tempDateInfo.notStarted > 0">
                                您有[{{ tempDateInfo.notStarted }}]场考试未发布，请注意开考时间，并在截止时间前完成考试，否则不计入成绩。
                            </div>
                            <div class="contentExpire" v-if="tempDateInfo.expire > 0">
                                您有[{{ tempDateInfo.expire }}]场考试已结束，请核对成绩。
                            </div>
                        </section>
                        
                            <template>
                                <el-skeleton />
                            </template>
                    </el-col>
                </el-row>
            </el-col>
            <el-col class="UserForm" :span="12">
                    <el-form  label-position="left" :model="UserForm"  ref="UserForm" label-width="100px" class="demo-UserForm">
                        <el-form-item label="用户名" prop="examineeName">
                            <el-input v-model="UserForm.examineeName"></el-input>
                        </el-form-item>                        
                        <el-form-item v-if="UserForm.sex != null"  label="性别" prop="sex" >
                            <el-col :span="11">
                                <el-radio v-model="UserForm.sex" :label="0">女</el-radio>
                                <el-radio v-model="UserForm.sex" :label="1">男</el-radio>
                            </el-col>
                        </el-form-item>
                        <el-form-item label="年级" prop="grade">
                            <el-input disabled v-model="UserForm.grade"></el-input>
                        </el-form-item>
                        <el-form-item label="学院" prop="academe">
                            <el-input disabled v-model="UserForm.academe"></el-input>
                        </el-form-item>
                        <el-form-item label="专业" prop="major">
                            <el-input disabled v-model="UserForm.major"></el-input>
                        </el-form-item>
                        <el-form-item label="班级" prop="clazz">
                            <el-input disabled v-model="UserForm.clazz"></el-input>
                        </el-form-item>
                        <el-form-item label="联系方式" prop="phoneNum">
                            <el-input  v-model="UserForm.phoneNum"></el-input>
                        </el-form-item>
                        <el-form-item label="邮箱" prop="email">
                            <el-input v-model="UserForm.email"></el-input>
                        </el-form-item>
                        <el-form-item label="身份证号" prop="cardId">
                            <el-input v-model="UserForm.cardId"></el-input>
                        </el-form-item>

                    <el-form-item>
                        <el-button type="primary" @click="onSubmit">修改</el-button>
                    </el-form-item>
                </el-form>
            </el-col>
        </el-row>
        
       
        
        
    </div>
</template>

<script>
import {mapState} from 'vuex'
    export default{
        data(){
            return{
                UserForm:{ //预设好用户信息格式
                    examineeName:null,
                    sex:null,
                    grade:null,
                    academe:null,
                    major:null,
                    clazz:null,
                    phoneNum:null,
                    email:null,
                    cardId:null,
                },
                profilePhoto:'@/assets/userIcon.jpg',
                tempDateInfo:{
                    all:0,
                    notStarted:0,
                    started:0,
                    
                },
                imageUrl:'',//上传的头像地址
            }
        },
        methods:{
            //获取当前用户的数据
            getUserInfo(){
                let info = this.$cookies.get('uInfo')
                if(info){
                    this.UserForm = info;
                }else return;
            },
            onSubmit(){
                this.$confirm("请确认信息无误再修改","友情提示",{
                    confirmButtonText: '确定',
                    cancelButtonText: '再检查一下',
                    type: 'warning'
                }).then(() =>{
                    console.log('确定修改')
                    this.$axios({
                        url:'/API/updateExamineePersonal',
                        method:'POST',
                        data:{
                            ...this.UserForm
                        }
                        }).then(res =>{
                            if(res.data.code == 200){//更新成功
                                    this.$message({
                                    message:'更新成功',
                                    type:'success'
                                })
                            }
                            //更新一下UInfo
                            
                            this.$cookies.set('uInfo',this.UserForm)
                            this.getUserInfo()
                        })
                })
            },
            initTempDateInfo(){
                if(this.ExamDateInfo != null){
                    this.tempDateInfo = this.ExamDateInfo;
                }else console.log('error')
            },
            //上传头像相关函数
            handleAvatarSuccess(res, file) {
                this.imageUrl = URL.createObjectURL(file.raw);
            },
            beforeAvatarUpload(file) {
                const isJPG = file.type === 'image/jpeg';
                const isLt2M = file.size / 1024 / 1024 < 2;

                if (!isJPG) {
                this.$message.error('上传头像图片只能是 JPG 格式!');
                }
                if (!isLt2M) {
                this.$message.error('上传头像图片大小不能超过 2MB!');
                }
                return isJPG && isLt2M;
            }
            //上传头像函数
        },
        created(){
            this.getUserInfo()
            
        },
        mounted(){
            this.initTempDateInfo()
        },
        computed:{
            ...mapState(['ExamDateInfo'])
        }
    }

</script>

<style scoped >
#personal{
    width:100%;
}
.splitLine{
    width:90%;
    text-align: center;
    border-bottom:2px solid #d5d5d5;
    text-align:center;
    display:inline-block;
}
#personal > .splitLine > p{
    font-family:"优设标题黑";
    color:#ffffffff;
    height:4vh;
    font-size:22px;
    line-height:4vh;
    border-radius:3px;
    background-color:#20b2aa;
}
.MainBox{
    background: linear-gradient(to right, #f0fff0 0%, #f0ffff 100%);
}
.ppBox{
    margin-left:10px;
    margin-top:20px;
    height:220px;
    border:1px solid rgb(221, 216, 216);
    width:240px;
    border-radius: 2px;
}
.profilePhoto{
    margin:10px;
}
.ToDoList{
    
    height:37vh;
    width:90%;
    margin:10px;
    background-color:#f0fff0;
    text-align:left;
    box-shadow:0 0 2px 1px rgb(194, 192, 192);
}
.ToDoList span{
    font:20px;
    font-weight:bold;
    margin-left:20px;
    color:#344058e8;
    border-bottom:4px solid #0195ff;
}

.UserForm {
    margin-top:20px;
    
    background-color:#f0ffff;
    padding-top:10px;
    padding-left:20px;
    box-shadow:0 0 2px 1px rgb(194, 192, 192);
}
.UserForm .el-input{
    height:20%;
    
}
.contentStarted{
    width:80%;
    background-color: #c7e4e2;
    padding: 16px 32px;
    border-radius: 4px;
    border-left: 5px solid #20b2aa;
    margin: 20px 0px;
}
.contentExpire{
    width:80%;
    background-color: 	#fff0f5;
    padding: 16px 32px;
    border-radius: 4px;
    border-left: 5px solid #f08080;
    margin: 20px 0px;
}
.contentNoStarted{
    width:80%;
    background-color: rgb(236, 248, 255);
    padding: 16px 32px;
    border-radius: 4px;
    border-left: 5px solid rgb(80, 191, 255);
    margin: 20px 0px;
}



</style>
<style>
/* 头像上传区 */
.avatar-uploader .el-upload {
    margin-top:20px;
    border: 1px dashed #b6b2b2;
    border-radius: 6px;
    cursor: pointer;
    position: relative;
    overflow: hidden;
  }
  .avatar-uploader .el-upload:hover {
    border-color: #409EFF;
  }
.avatar-uploader-icon {
    margin-top:20px;
    font-size: 28px;
    color: #8c939d;
    width: 178px;
    height: 200px;
    line-height: 178px;
    text-align: center;
}
.avatar {
    width: 178px;
    height: 220px;
    display: block;
  }
</style>