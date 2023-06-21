<!--  添加题库 -->
<template>
  <div class="add">
    <el-tabs v-model="activeName">
    <el-tab-pane name="first">
      <span slot="label"><i class="el-icon-circle-plus"></i>添加试题</span>
      <section class="append">
        <ul>
          <li>
            <span>题目类型:</span>
            <el-select v-model="optionValue" placeholder="请选择题型" class="w150">
              <el-option
                v-for="item in options"
                :key="item.value"
                :label="item.label"
                :value="item.value">
              </el-option>
            </el-select>
          </li>
          <li v-if="optionValue == '选择题'">
            <span>所属章节：</span>
            <el-input
              placeholder="请输入对应章节"
              v-model="postChoose.chapter"
              class="w150"
              clearable>
            </el-input>
          </li>
          <li v-if="optionValue == '填空题'">
            <span>所属章节：</span>
            <el-input
              placeholder="请输入对应章节"
              v-model="postFill.chapter"
              class="w150"
              clearable>
            </el-input>
          </li>
          <li v-if="optionValue == '判断题'">
            <span>所属章节：</span>
            <el-input
              placeholder="请输入对应章节"
              v-model="postJudge.chapter"
              class="w150"
              clearable>
            </el-input>
          </li>
          <li v-if="optionValue == '应用题'">
            <span>所属章节：</span>
            <el-input
              placeholder="请输入对应章节"
              v-model="postApplication.chapter"
              class="w150"
              clearable>
            </el-input>
          </li>
          <li v-if="optionValue == '选择题'">
            <span>难度等级:</span>
            <el-select v-model="postChoose.difficulty" placeholder="选择难度等级" class="w150">
              <el-option
                v-for="item in levels"
                :key="item.value"
                :label="item.label"
                :value="item.value">
              </el-option>
            </el-select>
          </li>
          <li v-if="optionValue == '填空题'">
            <span>难度等级:</span>
            <el-select v-model="postFill.difficulty" placeholder="选择难度等级" class="w150">
              <el-option
                v-for="item in levels"
                :key="item.value"
                :label="item.label"
                :value="item.value">
              </el-option>
            </el-select>
          </li>
          <li v-if="optionValue == '判断题'">
            <span>难度等级:</span>
            <el-select v-model="postJudge.difficulty" placeholder="选择难度等级" class="w150">
              <el-option
                v-for="item in levels"
                :key="item.value"
                :label="item.label"
                :value="item.value">
              </el-option>
            </el-select>
          </li>
          <li v-if="optionValue == '应用题'">
            <span>难度等级:</span>
            <el-select v-model="postApplication.difficulty" placeholder="选择难度等级" class="w150">
              <el-option
                v-for="item in levels"
                :key="item.value"
                :label="item.label"
                :value="item.value">
              </el-option>
            </el-select>
          </li>
          <li v-if="optionValue == '选择题'">
            <span>正确选项:</span>
            <el-select v-model="postChoose.rightAns" placeholder="选择正确答案" class="w150">
              <el-option
                v-for="item in rights"
                :key="item.value"
                :label="item.label"
                :value="item.value">
              </el-option>
            </el-select>
          </li>
        </ul>
        <!-- 选择题部分 -->
        <div class="choose" v-if="optionValue == '选择题'">
          <div class="title">
            <el-tag>题目:</el-tag><span>在下面的输入框中输入题目,形如--DNS 服务器和DHCP服务器的作用是（）</span>
            <el-input
              type="textarea"
              rows="4"
              v-model="postChoose.question"
              placeholder="请输入题目内容"
              resize="none"
              class="answer">
            </el-input>
          </div>
          <div class="options">
            <ul>
              <li>
                <el-tag type="success">A</el-tag>
                <el-input
                  placeholder="请输入选项A的内容"
                  v-model="postChoose.ansA"
                  clearable="">
                </el-input>
              </li>
              <li>
                <el-tag type="success">B</el-tag>
                <el-input
                  placeholder="请输入选项B的内容"
                  v-model="postChoose.ansB"
                  clearable="">
                </el-input>
              </li>
              <li>
                <el-tag type="success">C</el-tag>
                <el-input
                  placeholder="请输入选项C的内容"
                  v-model="postChoose.ansC"
                  clearable="">
                </el-input>
              </li>
              <li>
                <el-tag type="success">D</el-tag>
                <el-input
                  placeholder="请输入选项D的内容"
                  v-model="postChoose.ansD"
                  clearable="">
                </el-input>
              </li>
            </ul>
          </div>
          <div class="title">
            <el-tag>解析:</el-tag><span>在下面的输入框中输入题目解析</span>
            <el-input
              type="textarea"
              rows="4"
              v-model="postChoose.analysis"
              placeholder="请输入答案解析"
              resize="none"
              class="answer">
            </el-input>
          </div>
          <div class="submit">
            <el-button type="primary" @click="chooseSubmit()">立即添加</el-button>
          </div>
        </div>
        <!-- 填空题部分 -->
        <div class="choose fill" v-if="optionValue == '填空题'">
          <div class="title">
            <el-tag>题目:</el-tag><span>输入题目,形如--从计算机网络系统组成的角度看，计算机网络可以分为()和()。注意需要考生答题部分一定要用括号（英文半角）括起来。</span>
            <el-input
              type="textarea"
              rows="4"
              v-model="postFill.question"
              placeholder="请输入题目内容"
              resize="none"
              class="answer">
            </el-input>
          </div>
          <div class="fillAnswer">
            <el-tag>正确答案:</el-tag>
            <el-input v-model="postFill.rightAns"></el-input>
          </div>
          <div class="title analysis">
            <el-tag type="success">解析:</el-tag><span>下方输入框中输入答案解析</span>
            <el-input
              type="textarea"
              rows="4"
              v-model="postFill.analysis"
              placeholder="请输入答案解析"
              resize="none"
              class="answer">
            </el-input>
          </div>
          <div class="submit">
            <el-button type="primary" @click="fillSubmit()">立即添加</el-button>
          </div>
        </div>
        <!-- 判断题 -->
        <div class="choose judge" v-if="optionValue == '判断题'">
          <div class="title">
            <el-tag>题目:</el-tag><span>在下面的输入框中输入题目</span>
            <el-input
              type="textarea"
              rows="4"
              v-model="postJudge.question"
              placeholder="请输入题目内容"
              resize="none"
              class="answer">
            </el-input>
          </div>
          <div class="judgeAnswer">
            <el-radio v-model="postJudge.rightAns" label="T">正确</el-radio>
            <el-radio v-model="postJudge.rightAns" label="F">错误</el-radio>
          </div>
          <div class="title">
            <el-tag>解析:</el-tag><span>在下面的输入框中输入题目解析</span>
            <el-input
              type="textarea"
              rows="4"
              v-model="postJudge.analysis"
              placeholder="请输入答案解析"
              resize="none"
              class="answer">
            </el-input>
          </div>
          <div class="submit">
            <el-button type="primary" @click="judgeSubmit()">立即添加</el-button>
          </div>
        </div>
        <!-- 应用题 -->
        <div class="choose fill" v-if="optionValue == '应用题'">
          <div class="title">
            <el-tag>题目:</el-tag><span>输入题目,形如--简述CSMA技术的P—坚持算法规则。</span>
            <el-input
              type="textarea"
              rows="4"
              v-model="postApplication.question"
              placeholder="请输入题目内容"
              resize="none"
              class="answer">
            </el-input>
          </div>
          <div class="fillAnswer">
            <el-tag>正确答案:</el-tag>
            <el-input
              type="textarea"
              rows="4"
              v-model="postApplication.referenceAns"
              placeholder="请输入参考答案"
              resize="none"
              class="answer">
            </el-input>
          </div>
          <div class="title analysis">
            <el-tag type="success">解析:</el-tag><span>下方输入框中输入答案解析</span>
            <el-input
              type="textarea"
              rows="4"
              v-model="postApplication.analysis"
              placeholder="请输入答案解析"
              resize="none"
              class="answer">
            </el-input>
          </div>
          <div class="submit">
            <el-button type="primary" @click="applicationSubmit()">立即添加</el-button>
          </div>
        </div>
      </section>
    </el-tab-pane>

    <!-- ======================================在线组卷================================ -->
    <el-tab-pane name="second">
      <span slot="label"><i class="iconfont icon-daoru-tianchong"></i>在线组卷</span>
      <div class="box">
        <ul>
          <li>
            <span>试题难度:</span>
            <el-select v-model="difficultyValue" placeholder="试题难度" class="w150">
              <el-option 
                v-for="item in difficulty"
                :key="item.value"
                :label="item.label"
                :value="item.value">
              </el-option>
            </el-select>
          </li>
          <li>
            <span>选择题数量：</span> 
              <el-select v-model="chooseNumber"  placeholder="请选择" >
                <el-option 
                v-for="item in chooseOptions"
                :key="item.value"
                :label="item.label"
                :value="item.value" >

                </el-option>
              </el-select>
            
          </li>
          <li>
            <span>填空题数量：</span> 
            <el-select  v-model="fillNumber"  placeholder="请选择">
                <el-option 
                v-for="item in fillOptions"
                :key="item.value"
                :label="item.label"
                :value="item.value" >

                </el-option>
              </el-select>
          </li>
          <li>
            <span>判断题数量：</span> 
            <el-select v-model="judgeNumber"  placeholder="请选择">
                <el-option
                v-for="item in judgeOptions"
                :key="item.value"
                :label="item.label"
                :value="item.value" >

                </el-option>
              </el-select>

          </li>
          <li>
            <span>应用题数量：</span>
            <el-select v-model="applicationNumber"  placeholder="请选择">
                <el-option
                v-for="item in applicationOptions"
                :key="item.value"
                :label="item.label"
                :value="item.value" >

                </el-option>
              </el-select>

          </li>
          <li>
            <el-button type="primary" @click="create()">立即组卷</el-button>
          </li>
        </ul>
      </div>
    </el-tab-pane>
  </el-tabs>
  </div>
</template>

<script>
export default {
  data() {
    return {
      chooseNumber: 0, //选择题出题数量
      fillNumber: 0, //填空题出题数量
      judgeNumber: 0, //判断题出题数量
      applicationNumber:0,//应用题出题数量
      activeName: 'first',  //活动选项卡
      options: [ //题库类型
        {
          value: '选择题',
          label: '选择题'
        },
        {
          value: '填空题',
          label: '填空题'
        },
        {
          value: '判断题',
          label: '判断题'
        },
        {
          value: '应用题',
          label: '应用题'
        },
      ],
      difficulty: [ //试题难度
        {
          value: '简单',
          label: '简单'
        },
        {
          value: '一般',
          label: '一般'
        },
        {
          value: '困难',
          label: '困难'
        }
      ],
      difficultyValue: '简单',
      levels: [ //难度等级
        {
          value: '1',
          label: '1'
        },
        {
          value: '2',
          label: '2'
        },
        {
          value: '3',
          label: '3'
        },
        {
          value: '4',
          label: '4'
        },
        {
          value: '5',
          label: '5'
        },
      ],
      rights: [ //正确答案
        {
          value: 'A',
          label: 'A'
        },
        {
          value: 'B',
          label: 'B'
        },
        {
          value: 'C',
          label: 'C'
        },
        {
          value: 'D',
          label: 'D'
        },
      ],
      paperId: null,
      optionValue: '选择题', //题型选中值
      subject: '', //试卷名称用来接收路由参数
      postChoose: { //选择题提交内容
        subject: '', //试卷名称
        difficulty: '', //难度等级选中值 
        rightAns: '', //正确答案选中值
        chapter: '', //对应章节
        question: '', //题目
        analysis: '', //解析
        ansA: '',
        ansB: '',
        ansC: '',
        ansD: '',
      },
      postFill: { //填空题提交内容
        subject: '', //试卷名称
        difficulty: '', //难度等级选中值 
        rightAns: '', //正确答案
        chapter: '', //对应章节
        question: '', //题目
        analysis: '', //解析
      },
      postJudge: { //判断题提交内容
        subject: '', //试卷名称
        difficulty: '', //难度等级选中值 
        rightAns: '', //正确答案
        chapter: '', //对应章节
        question: '', //题目
        analysis: '', //解析
      },
      postPaper: { //考试管理表对应字段
        paperId: null,
        questionType: null, // 试卷类型 1--选择题  2--填空题   3--判断题   4-- 应用题
        questionId: null,
      },
      postApplication:{
        subject:null,//试卷名称
        difficulty:null,
        chapter:null,
        question:null,
        analysis:null,
        referenceAns:null,
      },
      InventoryQuestion:null,//用来获取试卷每种题目目前有多少用以限制组卷
      chooseOptions:[
      ],    //用于限制可以添加的题目数
      fillOptions:[
      ],      //用于限制可以添加的题目数
      judgeOptions:[
      ],     //用于限制可以添加的题目数
      applicationOptions:[
      ],//用于限制可以添加的题目数
    };
  },
  created() {
    this.getParams()
    this.getInventoryQuestion()
    // this.initOption() error
  },
  methods: {
    // handleClick(tab, event) {
    //   console.log(tab, event);
    // },
    create() {
      let difficultyParam = 0;
      if(this.difficultyValue  === '简单'){
        difficultyParam = 1
      }else if(this.difficultyValue  === '一般'){
        difficultyParam = 3
      }else if(this.difficultyValue  === '困难')
        difficultyParam = 5
      else return;
      let _subject = this.$route.query.subject;//获取路径传过来的科目
      this.$axios({
        url: '/API/acp',
        method: 'post',
        data: {
          chooseNumber: this.chooseNumber,
          fillNumber: this.fillNumber,
          judgeNumber: this.judgeNumber,
          applicationNumber:this.applicationNumber,
          paperId: this.paperId,
          difficulty:difficultyParam,//根据选择填入难度参数
          subject: _subject //题目数量太少，指定为计算机网络出题
        }
      }).then(res => {
        console.log(res)
        let data = res.data
        if(data.code==200){
          setTimeout(() => {
            this.$router.push({path: '/add2QB'})
          },1000)
           this.$message({
            message:data.msg,
            type: 'success'
          })
        }else if(data.code==400){
            this.$message({
            message: data.msg,
            type: 'error'
          })
        }

      })
    },
    //获取当前试卷中已有题目数量
    getInventoryQuestion(){
      let paperId = this.$route.query.paperId
      this.$axios(`/API/getInventoryQuestion/${paperId}`).then((res) =>{
        console.log(res.data)
        this.InventoryQuestion = res.data.data;
        this.initOption()
      })
    },
    getParams() {
      let subject = this.$route.query.subject //获取试卷名称
      let paperId = this.$route.query.paperId //获取paperId
      this.paperId = paperId
      this.subject = subject
      this.postPaper.paperId = paperId
    },
    chooseSubmit() { //选择题题库提交
      this.postChoose.subject = this.subject
      this.$axios({ //提交数据到选择题题库表
        url: '/API/ChooseQuestion',
        method: 'post',
        data: {
          ...this.postChoose          
        }
      }).then(res => { //添加成功显示提示
        let status = res.data.code
        if(status == 200) {
          this.$message({
            message: '已添加到题库',
            type: 'success'
          })
          this.postChoose = {}
        }
      }).then(() => {
        this.$axios(`/API/ChooseQuestionId`).then(res => { //获取当前题目的questionId
          let questionId = res.data.data.questionId
          this.postPaper.questionId = questionId
          this.postPaper.questionType = 1
          this.$axios({
            url: '/API/paperManage',
            method: 'Post',
            data: {
              ...this.postPaper
            }
          }).then((res) =>{
            if(res.data.code == 200) {
              this.$message({
                message: '已添加到试卷中',
                type: 'success'
              })
            }else if(res.data.code == 400){
              this.$message.error('添加到试卷的过程中出现错误')
            }
          })
        })
      })
    },
    fillSubmit() { //填空题提交
      this.postFill.subject = this.subject
      this.$axios({
        url: '/API/fillQuestion',
        method: 'post',
        data: {
          ...this.postFill
        }
      }).then(res => {
        let status = res.data.code
        if(status == 200) {
          this.$message({
            message: '已添加到题库',
            type: 'success'
          })
          this.postFill = {}
        }
      }).then(() => {
        this.$axios(`/API/fillQuestionId`).then(res => { //获取当前题目的questionId
          let questionId = res.data.data.questionId
          this.postPaper.questionId = questionId
          this.postPaper.questionType = 2
          this.$axios({
            url: '/API/paperManage',
            method: 'Post',
            data: {
              ...this.postPaper
            }
          }).then((res) =>{
            if(res.data.code == 200) {
              this.$message({
                message: '已添加到试卷中',
                type: 'success'
              })
            }else if(res.data.code == 400){
              this.$message.error('添加到试卷的过程中出现错误')
            }
          })
        })
      })
    },
    judgeSubmit() { //判断题提交
      this.postJudge.subject = this.subject
      this.$axios({
        url: '/API/judgeQuestion',
        method: 'POST',
        data: {
          ...this.postJudge
        }
      }).then(res => {
        let status = res.data.code
        if(status == 200) {
          this.$message({
            message: '已添加到题库',
            type: 'success'
          })
          this.postJudge = {}
        }
      }).then(() => {
        this.$axios(`/API/judgeQuestionId`).then(res => { //获取当前题目的questionId
          let questionId = res.data.data.questionId
          this.postPaper.questionId = questionId
          this.postPaper.questionType = 3
          this.$axios({
            url: '/API/paperManage',
            method: 'Post',
            data: {
              ...this.postPaper
            }
          }).then((res) =>{
            if(res.data.code == 200) {
              this.$message({
                message: '已添加到试卷中',
                type: 'success'
              })
            }else if(res.data.code == 400){
              this.$message.error('添加到试卷的过程中出现错误')
            }
          })
        })
      })
    },
    //提交应用题
    applicationSubmit(){
      this.postApplication.subject = this.subject;
      this.$axios({
        url:'/API/applicationQuestion',
        method:'POST',
        data:{
          ...this.postApplication
        }
      }).then(res => {
        let status = res.data.code
        if(status == 200) {
          this.$message({
            message: '已添加到题库',
            type: 'success'
          })
          this.postApplication = {}
        }
      }).then(res =>{
        this.$axios(`/API/applicationQuestionId`).then(res => { //获取当前题目的questionId
          let questionId = res.data.data.questionId
          this.postPaper.questionId = questionId
          this.postPaper.questionType = 4  //应用题类型
          this.$axios({
            url: '/API/paperManage',
            method: 'POST',
            data: {
              ...this.postPaper
            }
          }).then((res) =>{
            if(res.data.code == 200) {
              this.$message({
                message: '已添加到试卷中',
                type: 'success'
              })
            }else if(res.data.code == 400){
              this.$message.error('添加到试卷的过程中出现错误')
            }
          })
        })
      })
    },
    //初始化最大选项，这一块可以写到vuex中，有助于解耦
    initOption(){
      let cOlength;
      let fOlength;
      let jOlength;
      let aOlength;
      if(this.InventoryQuestion[0].totalCount != null){
        cOlength = 30 - this.InventoryQuestion[0].totalCount;  //选择题目前能组卷数目
      }else{
        cOlength = 30 //结果集不存在，直接填充最大上限
      }
      //pankong
      if(this.InventoryQuestion[1].totalCount != null){
        fOlength = 10 - this.InventoryQuestion[1].totalCount;
      }else
        fOlength = 10
      if(this.InventoryQuestion[2].totalCount != null){
        jOlength = 10 - this.InventoryQuestion[2].totalCount;
      }else
        jOlength = 10
      if(this.InventoryQuestion[3].totalCount != null){
        aOlength = 2 - this.InventoryQuestion[3].totalCount;
      }else
        aOlength = 2

      for(let i = 0;i < cOlength && cOlength > 0;i++){
        this.chooseOptions[i] = {value:i+1,label:i+1+''}
      }
      for(let i = 0;i < fOlength && fOlength > 0;i++){
        this.fillOptions[i] = {value:i+1,label:i+1+''}
      }
      for(let i = 0;i < jOlength && jOlength > 0;i++){
        this.judgeOptions[i] = {value:i+1,label:i+1+''}
      }
      for(let i = 0;i < aOlength && aOlength > 0;i++){
        this.applicationOptions[i] = {value:i+1,label:i+1+''}
      }
    }
  },
  directives: {
    'only-digits': {
      inserted(el) {
        el.addEventListener('keypress', function(event) {
          const char = String.fromCharCode(event.which);
          if (!/\d/.test(char)) {
            event.preventDefault();
          }
        });

        el.addEventListener('input', function(event) {
          const value = event.target.value;
          event.target.value = value.replace(/\D/g, '');
        });
      },
    },
  },
};
</script>

<style lang="less" scoped>
.add {
  margin: 0px 40px;
  .box {
    padding: 0px 20px;
    ul li {
      margin: 10px 0px;
      display: flex;
      align-items: center;
      .el-input {
        width: 6%;
      }
      .w150 {
        margin-left: 20px;
        width: 7%;
      }
    }
  }
  .el-icon-circle-plus {
    margin-right: 10px;
  }
  .icon-daoru-tianchong {
    margin-right: 10px;
  }
  .append {
    margin: 0px 20px;
    ul {
      list-style-type:none;
      display: flex;
      align-items: center;
      li {
        margin-right: 20px;
      }
    }
    .choose {
      margin-top: 20px;
      padding: 20px 16px;
      background-color: #f0f8ff;
      border-radius: 4px;
      .title {
        padding-left: 6px;
        color: #2f4f4f;
        span:nth-child(1) {
          margin-right: 6px;
        }
        .answer {
          margin: 20px 0px 20px 8px;
        }
        .el-textarea {
          width: 98% !important;
        }
      }
      .options {
        ul {
          display: flex;
          flex-direction: column;
        }
        ul li {
          display: flex;
          justify-content: center;
          align-items: center;
          width: 98%;
          margin: 10px 0px;
          span {
            margin-right: 20px;
          }
        }
      }
      .submit {
        display: flex;
        justify-content: center;
        align-items: center;
      }        
    }
    .fill {
      .fillAnswer {
        display: flex;
        justify-content: center;
        align-items: center;
        span {
          margin-right: 6px;
        }
        .el-input {
          width: 91% !important;
        }
      }
      .analysis {
        margin-top: 20px;
        margin-left: 5px;
      }
    }
    .judge {
      .judgeAnswer {
        margin-left: 20px;
        margin-bottom: 20px;
      }
    }
    .w150 {
      width: 150px;
    }
    li:nth-child(2) {
      display: flex;
      align-items: center;
      justify-content: center;
    }
  }
}
</style>


