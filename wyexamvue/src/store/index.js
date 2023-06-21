import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    menuHide:false,//菜单栏左右滑动
    userInfo:null,
    IsPractice:false,//联系模式标志
    ExamDateInfo:null,//控制练习页面ExamPractice的

    activeTab:null,//控制活跃tabs
    tabsInfo:[],

    menu:[
      {
        index:'1',
        icon:'el-icon-document',
        title:'考试管理',
        list:[{item1:'功能介绍',path:'/examDescription'},{item2:'考试管理',path:'/manageExam'},{item3:'发布考试',path:'/addExam'},]
      },
      {
        index:'2',
        icon:'el-icon-search',
        title:'查询成绩',
        list:[{item1:'学生成绩',path:'/allExamineesInfo'},]//,{item2:'成绩数据分析',path:'/mark'}
      },
      {
        index:'3',
        icon:'el-icon-folder-opened',
        title:'题库管理',
        list:[{item1:'功能介绍',path:'/QBDescription'},{item2:'所有题库',path:'/searchAllQB'},{item3:'增加题库',path:'/add2QB'},]
      },
      {
        index:'4',
        icon:'el-icon-user',
        title:'考生管理',
        list:[{item1:'学生管理',path:'/manageExaminee'},{item2:'添加学生',path:'/addExaminee'},]
      },
  ],
    //学院选择项，解耦不写死在组件内，可初始化为后端获取并使用
    academeOptions:[{
        value: '信通学院',
        label: '信通学院'
      },
      {
        value: '艺术学院',
        label: '艺术学院'
      },
      {
        value: '轮机工程学院',
        label: '轮机工程学院'
      },
      {
        value: '土木工程学院',
        label: '土木工程学院'
      },
    ],
    //专业选择项，解耦不写死在组件内，可初始化为后端获取并使用
    majorOptions:[
      {
        value: '软件工程',
        label: '软件工程',
        academe:'信通学院'
      },
      {
        value: '计算机技术与科学',
        label: '计算机技术与科学',
        academe:'信通学院'
      },
      {
        value: '网络工程',
        label: '网络工程',
        academe:'信通学院'
      },
      {
        value: '衍生品设计',
        label: '衍生品设计',
        academe:'艺术学院'
      },
      {
        value: '数字媒体',
        label: '数字媒体',
        academe:'艺术学院'
      },
//  ----------------------
      {
        value: '专业一',
        label: '专业一',
        academe:'轮机工程学院'
      },
      {
        value: '专业二',
        label: '专业二',
        academe:'轮机工程学院'
      },
      //  ----------------------
      {
        value: '专业一',
        label: '专业一',
        academe:'土木工程学院'
      },
      {
        value: '专业二',
        label: '专业二',
        academe:'土木工程学院'
      },

    ],
    gradeOptions:[
      {   
          value: '2019',
          label: '2019'
      },
      {   
          value: '2020',
          label: '2020'
      },
      {   
          value: '2021',
          label: '2021'
      },
      {   
          value: '2022',
          label: '2022'
      },
    ]
  },
  mutations: {
    practice(state,status){//练习模式
      state.IsPractice = status;
    },
    toggle(state){
      state.menuHide = !state.menuHide;
    },
    changeUserInfo(state,info){
      state.userInfo = info
    },
    changeIsPractice(state,Info){
      state.IsPractice = Info
    },
    setExamDateInfo(state,info){ 
      state.ExamDateInfo = info
    },
    // new tabs
    setActiveTab(state,index){
      state.activeTab = index
    },
    addTabs(state,route){ //要控制传过来的对象
      state.tabsInfo.push(route)
      //过滤空数组
      state.tabsInfo = state.tabsInfo.filter(obj => obj.name)
    },
    deleteTabs(state,route){ 
      let index = 0;
      for (let gohh of state.tabsInfo){
        if(gohh.route === route){ //route作为唯一的标识辅助删除
          break
        }
        index++
      }
      state.tabsInfo.splice(index,1)

      //重置活跃页(Tabs选项卡)
      // let Index = state.tabsInfo.length;
      // let arr = Object.values(state.tabsInfo)
      // state.activeTab = arr[Index - 1]?.route //用?.判断是否存在，避免报错
      //跳转
      //以上思路已经在tabs内实现，故无需在此重复
    },

  },
  actions: {
  },
  modules: {
  },
  
})
