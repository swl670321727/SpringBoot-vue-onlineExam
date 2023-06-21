import Vue from 'vue'
import VueRouter from 'vue-router'
import VueCookies from 'vue-cookies'
import Store from '../store'


Vue.use(VueRouter)



const routes = [
  {
    path: '/',//登录页面
    name: 'login',
    component: () => import('@/components/share/Login'),
    meta:{
      title:'无忧Exam考试系统'
    }
  },

  {//考生页面
    path: '/examinee',
    component: () => import('@/components/examinee/index'),
    children: [
      {path:"/examList",component: ()=> import('@/components/examinee/ExamList')},//考试列表
      {path:'/examPractice', component: () => import('@/components/examinee/ExamPractice')},//练习
      {path: '/examMsg', component: () => import('@/components/examinee/examMsg')},//点击进入考试详情
      // {path: '/message', component: () => import('@/components/examinee/message')},//暂未开发
      {path: '/answerMark', component: () => import("@/components/examinee/answerMark")},//答题成绩，暂未开发
      {path: '/markTable', component: () => import("@/components/examinee/markTable")},//成绩单
      {path: '/personal', component: () => import("@/components/examinee/personal")}//个人中心
    ],
    meta:{
      title:'无忧Exam考试系统'
    }
  },
  {
    path: '/index', //教职员端+管理员端主页
    component: () => import('@/components/admin/index'),
    children: [
      {
        path: '/welcome', //首页默认路由
        component: () => import('@/components/teacher/welcome')
      },
      // -----------------------------------------------------------------
      {
        path:'/examDescription', //功能介绍
        name:'考试功能介绍',
        component: () => import('@/components/teacher/examDescription')
      },
      {
        path: '/manageExam', //考试管理
        name:'考试管理',
        component: () => import('@/components/teacher/manageExam')
      },
      {
        path: '/addExam',   //添加考试
        name:'添加考试',
        component: () => import('@/components/teacher/addExam')
      },
      {
        path: '/correctPaper',//阅卷
        
        component: () => import ('@/components/teacher/correctPaper')
      },
      // -----------------------------------------------------------------
      {
        path: '/allExamineesInfo', //所有考生成绩
        name:'所有考生成绩',
        component: () => import('@/components/teacher/allExamineesInfo')
      },
      {
        path: '/mark', //考生成绩统计分析
        name:'成绩分析',
        component: () => import('@/components/charts/mark')
      },
      // -----------------------------------------------------------------
      {
        path: '/QBDescription', //题库管理功能介绍  QB是QuestionBank的缩写
        name:'题库功能介绍',
        component: ()=> import('@/components/teacher/QBDescription')
      },
      {
        path: '/searchAllQB', //查询所有题库
        name:'查询所有题库',
        component: () => import('@/components/teacher/searchAllQB')
      },
      {
        path: '/add2QB', //增加题库主界面
        name:'增加题库',
        component: () => import('@/components/teacher/add2QuestionBank')
      },
      {
        path: '/add2QBChildren', //点击试卷跳转到添加题库页面
        component: () => import('@/components/teacher/add2QuestionBankChildren')
      },
      // -----------------------------------------------------------------
      {
        path: '/manageExaminee', //考生管理界面
        name:'考生管理',
        component: () => import('@/components/teacher/manageExaminee')
      },
      {
        path: '/addExaminee', //添加考生
        name:'添加考生',
        component: () => import('@/components/teacher/addExaminee')
      },
      // -----------------------------------------------------------------------
      {
        path: '/manageTeacher',//教职工管理
        name:'教职工管理',
        component: () => import('@/components/admin/manageTeacher')
      },
      {
        path: '/addTeacher',//添加教职工
        name:'添加教职工',
        component: () => import ('@/components/admin/addTeacher')
      },

      {
        path: '/TeaAndAdmin',//个人中心
        name:'个人中心',
        component: () => import ('@/components/teacher/personal')
      }
    ]
  },
  //考生答题页面
  {path: '/answer',component: () => import('@/components/examinee/answer')},
  {path: '/test',component: () => import('@/components/share/template'),},
  
]



const router = new VueRouter({
  el:'#app',
  routes
})

router.beforeEach((to,from,next) =>{
  //=========================获取路由对应的路径=================================
  let examineePath=[];
  routes[1].children.forEach(item =>{
    examineePath.push(item.path)
  });  examineePath.push('/examinee');examineePath.push('/answer')//把父路由和答题页给添加进去
  
  let teaAndAdminPath=[];
  routes[2].children.forEach(item =>{
    teaAndAdminPath.push(item.path)
  });  teaAndAdminPath.push('/index');///把父路由给添加进去
  //============================================================================

  let token1 = VueCookies.get('uInfo');//考生数据
  let token2 = VueCookies.get('cInfo');//教职工、管理员数据
  // console.log(token)
  if(token1 || token2){//登录状态
    //防止后台子系统端退了，刷新一下进入考生端
    if(token2 == null && teaAndAdminPath.indexOf(to.path) != -1){
      next({path:'/'})
    }else{
      next();
    }

    //防止考生端退了，刷新一下进入后台子系统端
    if(token1 == null && examineePath.indexOf(to.path) != -1){
      next({path:'/'})
    }else{
      next();
    }
  }else{
    if(to.path == '/'){
      next();
    } else {
      next({path:'/'}); //未登录，无法跳转，回到登录页
    }
  }

  //=========================控制考生跳转访问=================================
  if(token1){
    if(examineePath.indexOf(from.path) != -1 && teaAndAdminPath.indexOf(to.path) != -1  && token1.part == '2' ){ //examineePath.indexOf(from.path) != -1 匹配到了，说明是从子路由过来的
      if(to.path == '/examinee'){
        next();
      }else
        next({path:'/examinee'});
    }
  }
  //=========================================================================

  //=========================控制教职员和管理员跳转访问===============================
  if(teaAndAdminPath.indexOf(from.path) != -1 && examineePath.indexOf(to.path) != -1 && ( token2.part == '0'||  token2.part == '1')){ //teaAndAdminPath.indexOf(from.path) != -1 匹配到了，说明是从子路由过来的
    if(to.path == '/index'){
      next();
    }else
      next({path:'/index'});
  }
  //================================================================================

  //=================================控制考试模式==================================
  if(to.path == '/examMsg' && from.path == '/examPractice' ){
    Store.commit('changeIsPractice',true)
  }else if(to.path == '/examMsg' && from.path == '/examList') {
    Store.commit('changeIsPractice',false)
  }
  //另外嵌套一层在组件内嵌一个判断学生是否已经考过试，以此作为判断具备考试资格
})

export default router
