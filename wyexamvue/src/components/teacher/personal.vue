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
                        <el-badge :value="0" class="item">
                            <span size="small">待办事项
                            </span>
                        </el-badge>
                        <div class="splitLine"></div>
                        
                            <template>
                                <el-skeleton />
                            </template>
                    </el-col>
                </el-row>
            </el-col>
            <el-col class="UserForm" :span="11">
                    <el-form  label-position="left" :model="UserForm"  ref="UserForm" label-width="100px" class="demo-UserForm">
                        <el-form-item v-if="UserForm.adminId" label="管理员账号" prop="adminId">
                            <el-input disabled v-model="UserForm.adminId"></el-input>
                        </el-form-item>
                        <el-form-item  v-if="UserForm.teacherName" label="用户名" prop="teacherName">
                            <el-input v-model="UserForm.teacherName"></el-input>
                        </el-form-item>
                        <el-form-item v-if="UserForm.adminName" label="用户名" prop="adminName">
                            <el-input v-model="UserForm.adminName"></el-input>
                        </el-form-item>
                        <el-form-item  v-if="UserForm.sex != null"  prop="sex" label="性别" >
                            <el-col :span="6">
                                <el-radio  v-model="UserForm.sex" :label="1">男</el-radio>
                                <el-radio  v-model="UserForm.sex" :label="0">女</el-radio>
                            </el-col>
                        </el-form-item>
                        <el-form-item v-if="UserForm.academe" label="学院" prop="academe">
                            <el-col :span="6">
                                <el-select v-model="UserForm.academe" placeholder="请选择">
                                    <el-option
                                    v-for="item in academeOptions"
                                    :key="item.value"
                                    :label="item.label"
                                    :value="item.value">
                                    </el-option>
                                </el-select>
                            </el-col>
                            
                        </el-form-item>

                        <el-form-item v-if="UserForm.title" label="职称" prop="title">
                            <el-input v-model="UserForm.title"></el-input>
                        </el-form-item>
                        <el-form-item v-if="UserForm.pwd" label="密码" prop="pwd">
                            <el-input  disabled :show-password="false" type="password" v-model="UserForm.pwd"></el-input>
                        </el-form-item>
                        <el-form-item v-if="UserForm.phoneNum"  label="联系方式" prop="phoneNum">
                            <el-input v-model="UserForm.phoneNum"></el-input>
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
                    pwd:null,
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
                let info = this.$cookies.get('cInfo')
                console.log(info)
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
                    let part = this.$cookies.get('part')
                    if(part == 1){//教师
                        
                        this.$axios({
                        url:'/API/updateTeacher',
                        method:'POST',
                        data:{
                            ...this.UserForm
                        }
                        }).then(res =>{
                            if(res.data.code == 201){//更新教职工成功
                                    this.$message({
                                    message:'更新成功',
                                    type:'success'
                                })
                            }
                            //更新一下UInfo
                            this.$cookies.set('cInfo',this.UserForm)
                            this.getUserInfo()
                        })
                    }
                    else if(part == 0){//管理员
                        this.$axios({
                            url:'/API/updateAdmin',
                            method:'POST',
                            data:{
                                ...this.UserForm
                            }
                        }).then(res =>{
                            if(res.data.code == 200){//更新管理员成功
                                    this.$message({
                                    message:'更新成功',
                                    type:'success'
                                })
                            }
                            this.$cookies.set('cInfo',this.UserForm)//更新
                            this.getUserInfo()
                        })
                    }else
                        return;
                }).catch(()=>{
                    
                })
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
            
        },
        computed:{
            ...mapState(['ExamDateInfo','academeOptions'])
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
    background-color:#48c9b0;
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
    margin-right:10px;
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
    background-color: #f0fff0;
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
    left:-30%;
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