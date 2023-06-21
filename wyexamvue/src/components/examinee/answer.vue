<!--考生答题界面-->
<template>
    <div id="answer">
      <!--顶部信息栏-->
       <div class="top">
         <ul class="item">
           <li><i class="iconfont icon-menufold icon20" ref="toggle" @click="slider_flag = !slider_flag"></i></li>
           <li>{{examData.type}}-{{examData.courseName}}</li>
           <li @click="flag = !flag">
             <i class="iconfont icon-user icon20"></i>
             <div class="msg"  v-if="flag" @click="flag = !flag">
               <p>姓名：{{userInfo.name}}</p>
               <p>准考证号:  {{userInfo.id}}</p>
             </div>
           </li>
           <li><i class="iconfont icon-arrLeft icon20"></i></li>
         </ul>
       </div>
       <div class="flexarea">
          <!--左边题目编号区-->
          <transition name="slider-fade">
            <div class="left" v-if="slider_flag">
              <ul class="l-top">
                <li>
                  <a href="javascript:;"></a>
                  <span>当前</span>
                </li>
                <li>
                  <a href="javascript:;"></a>
                  <span>未答</span>
                </li>
                <li>
                  <a href="javascript:;"></a>
                  <span>已答</span>
                </li>
                <li>
                  <a href="javascript:;"></a>
                  <span>标记</span>
                </li>
              </ul>
              <div class="l-bottom">
                <div class="item">
                  <p>选择题部分</p>
                  <ul>
                    <li v-for="(list, index1) in topic[1]" :key="index1">
                      <a href="javascript:;" 
                        @click="change(index1)"
                        :class="{'border': index == index1 && currentType == 1,'bg': bg_flag && topic[1][index1].isClick == true}">
                        <span :class="{'markStyle': topic[1][index1].isMark == true}"></span>
                        {{index1+1}}
                      </a>
                    </li>
                  </ul>
                </div>
                <div class="item">
                  <p>填空题部分</p>
                  <ul>
                    <li v-for="(list, index2) in topic[2]" :key="index2">
                      <a href="javascript:;" @click="fill(index2)" :class="{'border': index == index2 && currentType == 2,'bg': fillAnswer[index2][3] == true}">
                        <span :class="{'markStyle': topic[2][index2].isMark == true}"></span>{{topicCount[0]+index2+1}}</a>
                    </li>
                  </ul>
                </div>
                <div class="item">
                  <p>判断题部分</p>
                  <ul>
                    <li v-for="(list, index3) in topic[3]" :key="index3">
                      <a href="javascript:;" @click="judge(index3)" :class="{'border': index == index3 && currentType == 3,'bg': bg_flag && topic[3][index3].isClick == true}">
                        <span :class="{'markStyle': topic[3][index3].isMark == true}"></span>{{topicCount[0]+topicCount[1]+index3+1}}</a>
                    </li>
                  </ul>
                </div>
                <div class="item">
                  <p>应用题部分</p>
                  <ul>
                    <li v-for="(list, index4) in topic[4]" :key="index4">
                      <a href="javascript:;" @click="application(index4)" :class="{'border': index == index4 && currentType == 4,'bg': bg_flag && topic[4][index4].isClick == true}"> 
                        <span :class="{'markStyle': topic[4][index4].isMark == true}"></span>{{topicCount[0]+topicCount[1]+topicCount[2]+index4+1}}</a>
                    </li>
                  </ul>
                </div>
                <div class="final" @click="commit()">结束考试</div>
              </div>
            </div>
          </transition>  

          <!--右边选择答题区-->
          <transition name="slider-fade">
            <div class="right">
                <div class="title">
                    <p>{{title}}</p>
                    <i class="iconfont icon-right auto-right"></i>
                    <span>全卷共{{topicCount[0] + topicCount[1] + topicCount[2] + topicCount[3]}}题  <i class="iconfont icon-time"></i> 倒计时：<b>{{timeString}}</b></span>
                </div>

                <div class="content">
                    <!-- 答题区 -->
                  <p class="topic"><span class="number">{{number}}</span>{{showQuestion}}</p><!--题目-->

                  <div class="choose" v-if="currentType == 1">
                      <el-radio-group v-model="radio[index]" @change="getChangeLabel" >
                        <el-radio  :label="1">A{{showAnswer.ansA}}</el-radio>
                        <el-radio :label="2">B{{showAnswer.ansB}}</el-radio>
                        <el-radio :label="3">C{{showAnswer.ansC}}</el-radio>
                        <el-radio :label="4">D{{showAnswer.ansD}}</el-radio>
                      </el-radio-group>
                      <!-- 是否练习模式 -->
                      <div class="analysis" v-if="IsPractice">
                        <ul>
                            <li> <el-tag type="success">正确答案：</el-tag><span class="right">{{reduceAnswer.rightAns}}</span></li>
                            <li><el-tag>题目解析：</el-tag></li>
                            <li>{{reduceAnswer.analysis == null ? '暂无解析': reduceAnswer.analysis}}</li>
                        </ul>
                      </div>
                  </div>

                <div class="fill" v-if="currentType == 2">
                    <div v-for="(item,currentIndex) in part" :key="currentIndex">
                      <el-input placeholder="请填在此处"
                          v-model="fillAnswer[index][currentIndex]"
                          clearable
                          @blur="fillBG">
                      </el-input>
                    </div>

                    <!-- 是否练习模式 -->
                    <div class="analysis" v-if="IsPractice">
                      <ul>
                          <li> <el-tag type="success">正确答案：</el-tag><span class="right">{{topic[2][index].rightAns}}</span></li>
                          <li><el-tag>题目解析：</el-tag></li>
                          <li>{{topic[2][index].analysis == null ? '暂无解析': topic[2][index].analysis}}</li>
                      </ul>
                    </div>
                </div>
                  <div class="judge" v-if="currentType == 3">
                      <el-radio-group v-model="judgeAnswer[index]" @change="getJudgeLabel" v-if="currentType == 3">
                        <el-radio :label="1">正确</el-radio>
                        <el-radio :label="2">错误</el-radio>
                      </el-radio-group>
                      <!-- 是否练习模式 -->
                      <div class="analysis" v-if="IsPractice">
                        <ul>
                            <li> <el-tag type="success">正确答案：</el-tag><span class="right" v-if="topic[3][index].rightAns == 'T'"> 正确</span>
                                                                          <span class="right" v-if="topic[3][index].rightAns == 'F'"> 失败</span></li>
                            <li><el-tag>题目解析：</el-tag></li>
                            <li>{{topic[3][index].analysis == null ? '暂无解析': topic[3][index].analysis}}</li>
                        </ul>
                      </div>
                  </div>
                  
                  <div class="application" v-if="currentType == 4">
                        <!-- 应用题 -->
                        <el-col class="answerArea"  :span="12">
                          <el-input
                            type="textarea"
                            :rows="4"
                            placeholder="请在此区域作答"
                            v-model="applicationAnswer[index][0]"
                            >
                          </el-input>
                        </el-col>

                      <!-- 是否练习模式 -->
                      <div class="analysis" v-if="IsPractice">
                        <ul>
                            <li> <el-tag type="success">正确答案：</el-tag>
                              <span class="right"> {{ topic[4][index].rightAns  }}</span>
                            </li>
                            <li><el-tag>题目解析：</el-tag></li>
                            <li>{{topic[4][index].analysis == null ? '暂无解析': topic[4][index].analysis}}</li>
                        </ul>
                      </div>
                  </div>
                </div>

                <div class="operation">
                  <ul class="end">
                      <li @click="previous()"><i class="iconfont icon-previous"></i><span>上一题</span></li>
                      <li @click="mark()"><i class="iconfont icon-mark-o"></i><span>标记</span></li>
                      <li @click="next()"><span>下一题</span><i class="iconfont icon-next"></i></li>
                  </ul>
                </div>
            </div>
          </transition>
       </div> 
    </div>
  </template>
  
  <script>
  import {mapState} from 'vuex'
  export default {
    data() {
      return {
        startTime: null, //考试开始时间
        endTime: null, //考试结束时间
        time: null, //考试持续时间
        reduceAnswer:[],  //vue官方不支持3层以上数据嵌套,如嵌套则会数据渲染出现问题,此变量直接接收3层嵌套时的数据。
        answerMark: 0, //答题总分数
        bg_flag: false, //已答标识符,已答改变背景色
        isFillClick: false, //选择题是否点击标识符
        slider_flag: true, //左侧显示隐藏标识符
        flag: false, //个人信息显示隐藏标识符
        currentType: 1, //当前题型类型  1--选择题  2--填空题  3--判断题 4--应用题
        radio: [], //保存考生所有选择题的选项
        title: "请选择正确的选项",
        index: 0, //全局index
        userInfo: { //用户信息
          name: null,
          id: null
        },
        topicCount: [],//每种类型题目的总数
        score: [],  //每种类型分数的总数
        examData: { //考试信息
          // totalMark: null,
        },
        topic: {  //试卷信息
  
        },
        showQuestion: [], //当前显示题目信息
        showAnswer: {}, //当前题目对应的答案选项
        number: 1, //题号
        part: null, //填空题的空格数量
        fillAnswer: [[]], //二维数组保存所有填空题答案
        judgeAnswer: [], //保存所有判断题答案
        applicationAnswer: [[]], //保存所有应用题答案
        topic1Answer: [],  //学生选择题作答编号
        rightAns: '',
        timeLeft:0,//表示还剩下多少秒
        LeftEndTime:0,//表示倒计时结束时间
      }
    },
    created() {
      this.IsCapable()
      this.getCookies()
      this.getExamData()

    },
    mounted(){
      
    },
    watch:{
            //监听剩余时间
            timeLeft(newValue,oldValue){
              //自动收卷
                if(newValue <= 0){
                    this.$message({
                        message:'考试结束！自动收卷',
                        type:'warning'
                    })
                    //获取答题数据
                    /* 计算选择题总分 */
                    let topic1Answer = this.topic1Answer
                    let finalMark = 0
                    topic1Answer.forEach((element,index) => { //循环每道选择题根据选项计算分数
                      let right = null
                      if(element != null) {
                        switch(element) { //选项1,2,3,4 转换为 "A","B","C","D"
                          case 1:
                            right = "A"
                            break
                          case 2:
                            right = "B"
                            break
                          case 3:
                            right = "C"
                            break
                          case 4:
                            right = "D"
                        }
                        if(right == this.topic[1][index].rightAns) { // 当前选项与正确答案对比
                          finalMark += this.topic[1][index].mark // 计算总分数
                        }
                        console.log(right,this.topic[1][index].rightAns)
                      }
                      // console.log(topic1Answer)
                    })
                    /**计算填空题总分 */
                    // console.log(`this.fillAnswer${this.fillAnswer}`)
                    // console.log(this.topic[2][this.index])
                    let fillAnswer = this.fillAnswer
                    fillAnswer.forEach((element,index) => { //此处index和 this.index数据不一致，注意
                      element.forEach((inner) => {
                        if(this.topic[2][index].rightAns?.includes(inner)) { //判断填空答案是否与数据库一致
                          // console.log("正确")
                          finalMark += this.topic[2][this.index].mark
                        }
                      })
                    });
                    /** 计算判断题总分 */
                    let topic3Answer = this.judgeAnswer
                    topic3Answer.forEach((element,index) => {
                      let right = null
                      switch(element) {
                        case 1:
                          right = "T"
                          break
                        case 2:
                          right = "F"
                      }
                      if(right == this.topic[3][index].rightAns) { // 当前选项与正确答案对比
                          finalMark += this.topic[3][index].mark // 计算总分数
                        }
                    })
                    console.log(`目前总分${finalMark}`)


                    console.log("交卷")
                    let date = new Date()
                    this.endTime = this.getTime(date)
                    let answerDate = this.endTime.substr(0,10)//YY-MM-DD
                    //提交成绩信息
                    this.$axios({
                      url: '/API/addMark',
                      method: 'post',
                      data: {
                        examCode: this.examData.examCode, //考试编号
                        examineeId: this.userInfo.id, //学号
                        subject: this.examData.courseName, //课程名称
                        objMark: finalMark, //客观题答题成绩
                        answerDate: answerDate, //答题日期
                        
                      }
                    }).then(res => {
                      if(res.data.code == 200) {
                        //再次判断是否为练习模式
                        if( this.IsPractice == true){
                          //练习模式
                          console.log('练习模式')
                          return;
                        }else{
                          // 将主观题答案提交给correct_Paper
                          let cpvo = {
                            examineeId: this.userInfo.id, //学号
                            examCode: this.examData.examCode, //考试编号
                            subject: this.examData.courseName, //课程名称
                            answerInfo:this.applicationAnswer, //答题模块
                          }
                          this.$axios({
                              url:'/API/commitAppAnswer',
                              method:'POST',
                              data:{
                                ...cpvo
                              }
                            }).then(res =>{
                              if(res.data.code == 200){
                                  //提交成功
                                  console.log('提交成功')
                                  this.$message({
                                    showClose: true,
                                    type: 'success',
                                    message: '提交成功。'
                                  })
                              }else{
                                console.log('失败结果：'+res.data.msg)
                                if(res.data.code == 400){
                                  this.$message({
                                    showClose: true,
                                    type: 'error',
                                    message: '提交失败。'
                                  })
                                }
                              }
                            })
                          }
                        }else if(res.data.code == 201){
                          console.log('练习客观题成绩添加成功!')
                        }
                    }).then(res => {
                      this.$router.push({path:'/markTable'})
                    })
                  }
            }
            
    },
    methods: {
      test(){
       
      },
      //获取是否具备考试资格
      IsCapable(){
        if(this.IsPractice == false){ //成立则为考试模式
          //检查是否过期
          const Dealine = new Date(this.$route.query.examDeadline);
          const now = new Date();
          if(now > Dealine){ //考试已结束 不允许再考
                this.$message.error('考试已结束！')
                this.$router.push('/ExamPractice')
                return;
          }
          //检查资格
          let examCode = this.$route.query.examCode
          let examineeId = this.$cookies.get('uid');
          this.$axios(`/API/IsCapable/${examCode}/${examineeId}`).then((res) =>{
            if(res.data.data == false){//不具备资格，直接不给考
              this.$message.error('你已使用过该试卷进行考核，不具备考试资格！')
              this.$router.push('/ExamPractice')
              return;
            }
          })   
        }else{ //练习模式
          //检验是否考过试
          let examCode = this.$route.query.examCode
          let examineeId = this.$cookies.get('uid');
          this.$axios(`/API/IsCapable/${examCode}/${examineeId}`).then((res) =>{
              if(res.data.data == true){//没考过试，直接不给练习
                this.$message.error('你还未考过这门试，不能够练习，请完成考试！')
                this.$router.push('/ExamList')
                return;
              }
          })
        }
      },
      //控制倒计时，参数:该门考试的持续时间。
      startCountdown(DuringTime) {
          const savedEndTimeAndExamCode = localStorage.getItem('savedEndTimeAndExamCode');
          const data = JSON.parse(savedEndTimeAndExamCode);//取出来转换一下格式
          const savedEndTime = data?.savedEndTime;
          const examCode = data?.examCode;//examCode作为唯一标识
          const now = Date.now();
          if (savedEndTime && now < savedEndTime && examCode == this.$route.query.examCode) { //当前时间小于从localStorage中存储的应当结束时间，则说明倒计时还没有结束; 并且判断是同一场考试 
            this.LeftEndTime = savedEndTime;
          } else {
              const duration = DuringTime * 60 * 1000;// 从后端获取的时间，单位为分钟
              this.LeftEndTime = now + duration;
              let savedEndTimeAndExamCode = {
                'savedEndTime':this.LeftEndTime,
                'examCode':this.$route.query.examCode
              }
              localStorage.setItem('savedEndTimeAndExamCode',JSON.stringify(savedEndTimeAndExamCode))
          }

          this.updateTimeLeft();
      },
      updateTimeLeft() {
          const now = Date.now();
          this.timeLeft = Math.max(0, Math.floor((this.LeftEndTime - now) / 1000));

          if (this.timeLeft > 0) {
                  setTimeout(() => this.updateTimeLeft(), 1000);
          } else {
                  localStorage.removeItem('savedEndTimeAndExamCode');
          }
      },////控制倒计时
      getTime(date) { //日期格式化
        let year = date.getFullYear()
        let month= date.getMonth()+ 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
        let day=date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
        let hours=date.getHours() < 10 ? "0" + date.getHours() : date.getHours();
        let minutes=date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes();
        let seconds=date.getSeconds() < 10 ? "0" + date.getSeconds() : date.getSeconds();
        // 拼接
        return year+"-"+month+"-"+day+" "+hours+":"+minutes+":"+seconds;
      },
      getCookies() {  //获取cookie
        this.userInfo.name = this.$cookies.get("uname")
        this.userInfo.id = this.$cookies.get("uid")
      },
      getExamData() { //获取当前试卷所有信息
        let date = new Date()
        this.startTime = this.getTime(date)
        let examCode = this.$route.query.examCode //获取路由传递过来的试卷编号
        this.$axios(`/API/getExamByExamCode/${examCode}`).then(res => {  //通过examCode请求试卷详细信息
          this.examData = { ...res.data.data} //获取考试详情

          this.index = 0
          this.time = this.examData.duringTime //获取分钟数
          let paperId = this.examData.paperId
          this.startCountdown(this.time)//倒计时开始

          this.$axios(`/API/paper/${paperId}`).then(res => {  //通过paperId获取试题题目信息
            this.topic = {...res.data} ///返回的是一个Map<Integer，List<T>>集合
            // console.log(this.topic[3].length)
            //判断试卷有没有题，没有则退出
            if((this.topic[4] == null && this.topic[1] == null && this.topic[2] == null && this.topic[3] == null)
            || (this.topic[4].length <= 0 && this.topic[1].length <= 0 && this.topic[2].length <= 0 && this.topic[3].length <= 0)){
              //没有题可做
              this.$message.error('该试卷尚未有题目，请重试！')
              this.$router.push('/ExamList')
              return;
            }


            let reduceAnswer = this.topic[1][this.index]
            this.reduceAnswer = reduceAnswer
            let keys = Object.keys(this.topic) //对象转数组
            keys.forEach(e => {
              // console.log('e:'+e)
              let data = this.topic[e]
              this.topicCount.push(data.length)
              //--------以下代码为待改善内容 
              // let currentMark = 0
              // for(let i = 0; i< data.length; i++) { //循环每种题型,计算出总分
              //   currentMark += data[i].score
              //   console.log('score',data[i].score)
              // }
              // this.score.push(currentMark) //把每种题型总分存入score
            })
            let len1 = this.topicCount[1]
            let len2 = this.topicCount[3]
            let father1 = []
            for(let i = 0; i < len1; i++) { //根据填空题数量创建二维空数组存放每道题答案
              let children = [null,null,null,null]
              father1.push(children)
            }
            this.fillAnswer = father1 //填空题

            let father2 = []
            for(let i = 0; i < len2; i++) { //根据应用题数量创建二维空数组存放每道题答案
              let children = [null,null,null]    //子数组第0坐标存储答案，第二坐标存储题目,第三坐标存储解析
              father2.push(children)
            }
            this.applicationAnswer = father2 //应用题

            let dataInit1 = this.topic[1]
            this.showQuestion = dataInit1[0].question
            this.showAnswer = dataInit1[0]
            this.number = 1
            
            
            //this.showQuestion = dataInit2[0].question //2023年4月17日，bug：导致选择题第一题被渲染成判断题第一题
            // this.showAnswer = dataInit2[0]           //
          })
        })
      },
      change(index) { //选择题
        this.index = index
        let reduceAnswer = this.topic[1][this.index]
        this.reduceAnswer = reduceAnswer
        this.isFillClick = true
        this.currentType = 1
        let len = this.topic[1].length
        if(this.index < len) {
          if(this.index <= 0){
            this.index = 0
          }
          this.title = "请选择正确的选项"
          let Data = this.topic[1]
          // console.log(Data)
          this.showQuestion = Data[this.index].question //获取题目信息
          this.showAnswer = Data[this.index]
          this.number = this.index + 1
        }else if(this.index >= len) {
          this.index = 0
          this.fill(this.index)
        }
      },
      fillBG() { //填空题已答题目 如果已答该题目,设置第四个元素为true为标识符
        if(this.fillAnswer[this.index][0] != null) {
          this.fillAnswer[this.index][3] = true
        }
      },
      applicationBG() { //填空题已答题目 如果已答该题目,设置第四个元素为true为标识符
        console.log('BGBG')
        if(this.applicationAnswer[this.index][0] != null) {
          this.applicationAnswer[this.index][3] = true
        }
      },
      fill(index) { //填空题
        let len = this.topic[2].length
        this.currentType = 2
        this.index = index
        if(index < len) {
          if(index < 0) {
            index = this.topic[1].length -1
            this.change(index)
          }else {
            console.log(`总长度${len}`)
            console.log(`当前index:${index}`)
            this.title = "请在横线处填写答案"
            let Data = this.topic[2]
            // console.log(Data)
            this.showQuestion = Data[index].question //获取题目信息
            let part  = this.showQuestion.split("()").length -1 //根据题目中括号的数量确定填空横线数量
            this.part = part
            //利用第三个坐标来存储‘（）’个数
            this.fillAnswer[this.index][2] = part
            
            this.number = this.topicCount[0] + index + 1
          } 
        }else if(index >= len) {
          this.index = 0
          this.judge(this.index)
        }
      },
      judge(index) { //判断题
        let len = this.topic[3].length
        this.currentType = 3
        this.index = index
        if(this.index < len) {
          if(this.index < 0){
            this.index = this.topic[2].length - 1
            this.fill(this.index)
          }else {
            console.log(`总长度${len}`)
            console.log(`当前index:${this.index}`)
            this.title = "请作出正确判断"
            let Data = this.topic[3]
            // console.log(Data)
            this.showQuestion = Data[index].question //获取题目信息
            this.number = this.topicCount[0] + this.topicCount[1] + index + 1
          }
        }else if (this.index >= len) {
          this.index = 0
          this.application(this.index)// 修改 change
        }
      },
      application(index){//应用题
        //this.applicationBG();//修改应用题背景颜色
        let len = this.topic[4].length
        this.currentType = 4
        this.index = index
        if(this.index < len) {
          if(this.index < 0){
            this.index = this.topic[2].length - 1
            this.judge(this.index)
          }else {
            console.log(`总长度${len}`)
            console.log(`当前index:${this.index}`)
            this.title = "请在答题区域内作答"
            let Data = this.topic[4] 
            // console.log(Data) 
            this.showQuestion = Data[index].question //获取题目信息
            if(this.applicationAnswer[index][1] == null){ //判空，再将题目赋值给二维数组
              this.applicationAnswer[index][1] = Data[index].question
            }
            if(this.applicationAnswer[index][2] == null){ //判空，再将参考答案赋值给二维数组
              this.applicationAnswer[index][2] = Data[index].referenceAns
            }
            
            this.number = this.topicCount[0] + this.topicCount[1] + this.topicCount[2]+ index + 1 //修改题号
        }
        }else if (this.index >= len) {
          this.index = 0
          this.change(this.index)
        }
      },
      getChangeLabel(val) { //获取选择题作答选项
        this.radio[this.index] = val //当前选择的序号
        if(val) {
          let data = this.topic[1]
          this.bg_flag = true
          data[this.index]["isClick"] = true
        }
        /* 保存学生答题选项 */
        this.topic1Answer[this.index] = val 
      },
      getJudgeLabel(val) {  //获取判断题作答选项
        this.judgeAnswer[this.index] = val
        if(val) {
          let data = this.topic[3]
          this.bg_flag = true //标为已答
          data[this.index]["isClick"] = true
        }
      },

      previous() { //上一题
        this.index--
        switch(this.currentType) {
          case 1: 
            this.change(this.index)
            break
          case 2: 
            this.fill(this.index)
            break
          case 3:
            this.judge(this.index)
            break
          case 4:
            this.application(this.index)
            break
        }
      },
      next() { //下一题
        this.index++
        switch(this.currentType) {
          case 1: 
            this.change(this.index)
            break
          case 2: 
            this.fill(this.index)
            break
          case 3:
            this.judge(this.index)
            break
          case 4:
            this.application(this.index)
            break
        }
      },
      mark() { //标记功能,统一可以取消标记
        switch(this.currentType) {
          case 1:
            this.topic[1][this.index]["isMark"] = !this.topic[1][this.index]["isMark"] //选择题标记
            break
          case 2:
            this.topic[2][this.index]["isMark"] = !this.topic[2][this.index]["isMark"] //填空题标记
            break
          case 3:
            this.topic[3][this.index]["isMark"] = !this.topic[3][this.index]["isMark"]  //判断题标记
            break
          case 4:
            this.topic[4][this.index]["isMark"] = !this.topic[4][this.index]["isMark"]  //应用题标记
            break
        }
      },
      commit() { //答案提交计算分数
        /* 计算选择题总分 */
        let topic1Answer = this.topic1Answer
        let finalMark = 0
        topic1Answer.forEach((element,index) => { //循环每道选择题根据选项计算分数
          let right = null
          if(element != null) {
            switch(element) { //选项1,2,3,4 转换为 "A","B","C","D"
              case 1:
                right = "A"
                break
              case 2:
                right = "B"
                break
              case 3:
                right = "C"
                break
              case 4:
                right = "D"
            }
            if(right == this.topic[1][index].rightAns) { // 当前选项与正确答案对比
              finalMark += this.topic[1][index].mark // 计算总分数
            }
            console.log(right,this.topic[1][index].rightAns)
          }
          // console.log(topic1Answer)
        })
        /**计算填空题总分 */
        // console.log(`this.fillAnswer${this.fillAnswer}`)
        // console.log(this.topic[2][this.index])
        

        let fillAnswer = this.fillAnswer
        fillAnswer.forEach((element,index) => { //此处index和 this.index数据不一致，注意
          element.forEach((inner) => {
            if(this.topic[2][index].rightAns?.includes(inner)) { //判断填空答案是否与数据库一致
              if(element[2] == 2){//通过第三个坐标获取当前该选择题有多少个空   //待改善：针对填空题为2个空，这样写是写死了，要改善，比如将this.topic[2][this.index].mark n等分
                finalMark += this.topic[2][this.index].mark - 1 //防止叠加两次mark，所以减掉 mark/2 也就是1
              }else
              finalMark += this.topic[2][this.index].mark
            }
          })
        });
        /** 计算判断题总分 */
        let topic3Answer = this.judgeAnswer
        topic3Answer.forEach((element,index) => {
          let right = null
          switch(element) {
            case 1:
              right = "T"
              break
            case 2:
              right = "F"
          }
          if(right == this.topic[3][index].rightAns) { // 当前选项与正确答案对比
              finalMark += this.topic[3][index].mark // 计算总分数
            }
        })
        console.log(`目前总分${finalMark}`) 
        if(this.timeLeft != 0 ) {
          this.$confirm("考试结束时间未到,是否提前交卷","友情提示",{
            confirmButtonText: '立即交卷',
            cancelButtonText: '再检查一下',
            type: 'warning'
          }).then(() => {
            console.log("交卷")
            let date = new Date()
            this.endTime = this.getTime(date)
            let answerDate = this.endTime.substr(0,10)//YY-MM-DD
            //提交成绩信息
            this.$axios({
              url: '/API/addMark',
              method: 'post',
              data: {
                examCode: this.examData.examCode, //考试编号
                examineeId: this.userInfo.id, //学号
                subject: this.examData.courseName, //课程名称
                objMark: finalMark, //客观题答题成绩
                answerDate: answerDate, //答题日期
                
              }
            }).then(res => {
              if(res.data.code == 200) {
                //再次判断是否为练习模式
                if( this.IsPractice == true){
                  //练习模式
                  console.log('练习模式')
                  return;
                }else{
                  // 将主观题答案提交给correct_Paper
                  // console.log(this.applicationAnswer)
                  let cpvo = {
                    examineeId: this.userInfo.id, //学号
                    examCode: this.examData.examCode, //考试编号
                    subject: this.examData.courseName, //课程名称
                    answerInfo:this.applicationAnswer, //答题模块
                  }
                  this.$axios({
                      url:'/API/commitAppAnswer',
                      method:'POST',
                      data:{
                        ...cpvo
                      }
                    }).then(res =>{
                      if(res.data.code == 200){
                          //提交成功
                          console.log('提交成功')
                          this.$message({
                            showClose: true,
                            type: 'success',
                            message: '提交成功。'
                          })
                      }else{
                        console.log('失败结果：'+res.data.msg)
                        if(res.data.code == 400){
                          this.$message({
                            showClose: true,
                            type: 'error',
                            message: '提交失败。'
                          })
                        }
                      }
                    })
                  }
                }else if(res.data.code == 201){
                  console.log('练习客观题成绩添加成功!')
                }
            }).then(res => {
              this.$router.push({path:'/markTable'})
            })
            
          }).catch(() => {
            //继续答题 
            console.log("继续答题")
          })
        }
      },
      
    },
    computed:{
      ...mapState(["IsPractice"]),
      //计算属性 timeString 将 timeLeft 转换为分钟和秒钟的形式，用于在页面中显示倒计时。
      timeString() {
                const minutes = Math.floor(this.timeLeft / 60);
                const seconds = this.timeLeft % 60;
                return `${minutes} 分 ${seconds} 秒`;
            },
            
    }
  }
  </script>
  
  <style lang="less" scoped>
  

  #answer ul{
    list-style-type:none;
  }
  .iconfont.icon-time {
    color: rgba(50,62,85,1);
    margin: 0px 6px 0px 20px;
  }
  .analysis {
    margin-top: 20px;
    .right {
      color: #2776df;
      font-size: 18px;
      border: 1px solid #2776df;
      padding: 0px 6px;
      border-radius: 4px;
      margin-left: 20px;
    }
    ul li:nth-child(2) {
      margin: 20px 0px;
    }
    ul li:nth-child(3) {
      padding: 10px;
      background-color: #d3c6c9;
      border-radius: 4px;
    }
  }
  .analysis span:nth-child(1) {
    font-size: 18px;
  }
  .answerArea{
    margin-left:25%;//调整应用题答题区域位置
  }
  .markStyle {
    position: absolute;
    width: 4px;
    height: 4px;
    content: "";
    background-color: red;
    border-radius: 50%;
    top: 0px;
    left: 22px;
  }
  .border {
    position: relative;
    border: 1px solid #0195ff !important;
  }
  .bg {
    background-color: #ff7413 !important;
  }
  .fill .el-input {
    display: inline-flex;
    align-items:baseline;
    width: 150px;
    margin-left: 20px;
    margin-top: 10px;
    .el-input__inner {
      border: 1px solid transparent;
      border-bottom: 1px solid #eee;
      padding-left: 20px;
    }
  }
  /* slider过渡效果 */
  .slider-fade-enter-active {
    transition: all .3s ease;
  }
  .slider-fade-leave-active {
    transition: all .3s cubic-bezier(1.0, 0.5, 0.8, 1.0);
  }
  .slider-fade-enter, .slider-fade-leave-to {
    transform: translateX(-100px);
    opacity: 0;
  }
  
  .operation .end li:nth-child(2) {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    background-color: rgb(39, 118, 223);
    border-radius: 50%;
    width: 50px;
    height: 50px;
    color: #fff;
  }
  .operation .end li:nth-child(2):active{
    background-color: #ff7413;
  }
  .operation .end li {
    cursor: pointer;
    margin: 0 100px;
  }
  .operation {
    background-color: #fff;
    border-radius: 4px;
    padding: 10px 0px;
    margin-right: 10px;
  }
  .operation .end {
    display: flex;
    justify-content: center;
    align-items: center;
    color: rgb(39, 118, 223);
  }
  .content .number {
    display: inline-flex;
    justify-content: center;
    align-items: center;
    width: 20px;
    height: 20px;
    border-bottom:4px solid rgb(39, 118, 223);
    color:#344058e8;
    font-weight:bold;
    margin-right: 4px;
  }
  .content {
    padding: 0px 20px;
  }
  .content .topic {
    padding: 20px 0px;
    padding-top: 30px; 
  }
  .right .content {
    background-color: #fff;
    margin: 10px;
    margin-left: 0px;
    height: 470px;
  }
  .content .el-radio-group label span{
    font-size:20px;
  }
  .content .el-radio-group label {
    color: #000;
    // 2023-3-20 优化
    position:relative;
    left:40%;
    font-size:20px;
    // 2023-3-20 优化
    margin: 5px 0px;
  }
  .content .el-radio-group {
    display: flex;
    flex-direction:column;
    // flex 左对齐
    align-items:baseline;
  }
  

  .right .title p {
    margin-left: 20px;
  }
  .flexarea {
    display: flex;
  }
  .flexarea .right {
    flex: 1;
  }
  .auto-right {
    margin-left: auto;
    color: #2776df;
    margin-right: 10px;
  }
  .right .title {
    margin-right: 10px;
    padding-right: 30px;
    display: flex;
    margin-top: 10px;
    background-color: #fff;
    height: 50px;
    line-height: 50px;
  }
  .clearfix {
    clear: both;
  }
  .l-bottom .final {
    cursor: pointer;
    display: inline-block;
    text-align: center;
   background-color: rgb(39, 118, 223);
    width: 240px;
    margin: 20px 0px 20px 10px;
    border-radius: 4px;
    height: 30px;
    line-height: 30px;
    color: #fff;
    margin-top: 22px;
  }
  #answer .left .item {
    padding: 0px;
    font-size: 16px;
  }
  .l-bottom {
    border-radius: 4px;
    background-color: #fff;
  }
  .l-bottom .item p {
    margin-bottom: 15px;
    margin-top: 10px;
    color: #000;
    margin-left: 10px;
    letter-spacing: 2px;
  }
  .l-bottom .item li {
    width: 15%;
    margin-left: 5px;
    margin-bottom: 10px;
  }
  .l-bottom .item {
    display: flex;
    flex-direction: column;
  }
  .l-bottom .item ul {
    width: 100%;
    margin-bottom: -8px;
    display: flex;
    justify-content: space-around;
    flex-wrap: wrap;
  }
  .l-bottom .item ul li a { 
    position: relative;
    justify-content: center;
    display: inline-flex;
    align-items: center;
    width: 30px;
    height: 30px;
    border-radius: 50%;
    background-color: #fff;
    border: 1px solid #eee;
    text-align: center;
    color: #000;
    font-size: 16px;
    font-weight:bold;
  }
  .left .l-top {
    display: flex;
    justify-content: space-around;
    padding: 16px 0px;
    border: 1px solid #eee;
    border-radius: 4px;
    margin-bottom: 10px;
    background-color: #fff;
  }
  .left {
    width: 260px;
    height: 100%;
    margin: 10px 10px 0px 10px;
  }
  .left .l-top li:nth-child(2) a {
    border: 1px solid #eee;
  }
  .left .l-top li:nth-child(3) a {
    background-color: #ff7413;
    border: none;
  }
  .left .l-top li:nth-child(4) a {
    position: relative;
    border: 1px solid #eee;
  }
  .left .l-top li:nth-child(4) a::before {
    width: 4px;
    height: 4px;
    content: " ";
    position: absolute;
    background-color: #cc2222;
    border-radius: 50%;
    top: 0px;
    left: 16px;
  }
  .left .l-top li {
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
  }
  .left .l-top li a {
    display: inline-block;
    padding: 10px;
    border-radius: 50%;
    background-color: #fff;
    border: 1px solid #0195ff;
  }
  #answer .top {
    background-color: rgba(50,62,85,1);
  }
  #answer .item {
    color: #fff;
    display: flex;
    padding: 20px;
    margin-top:0;
    font-size: 20px;
  }
  #answer .top .item li:nth-child(1) {
    margin-right: 10px;
  }
  #answer .top .item li:nth-child(3) {
    position: relative;
    margin-left: auto;
  }
  #answer {
    padding-bottom: 30px;
  }
  .icon20 {
    font-size: 20px;
    font-weight: bold;
  }
  .item .msg {
    padding: 10px 15px;
    border-radius: 4px;
    top: 47px;
    right: -30px;
    color: #6c757d;
    position: absolute;
    border: 1px solid rgba(0,0,0,.15);
    background-color: #fff;
  }
  .item .msg p {
    font-size: 16px;
    width: 200px;
    text-align: left;
  }
  </style>
  