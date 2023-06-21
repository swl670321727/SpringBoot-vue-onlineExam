<!--左边下拉导航栏-->
<template>
  <div id="left">
    <el-menu 
      :unique-opened="true"
      active-text-color="#dd5862" 
      text-color="#000" 
      :default-active="this.$route.path"
      class="el-menu-vertical-demo" 
      @open="handleOpen" 
      @close="handleClose" 
      :collapse="menuHide" 
      background-color="#344058e8"  
      menu-trigger="click" router>
        <el-submenu v-for="(item,index) in menu" :index='item.index' :key="index">
          <template slot="title">
            <div class="left-width">
              <i class="iconfont" :class="item.icon"></i>   
              <span slot="title" class="title">{{item.title}}</span>
            </div>
          </template>

          <el-menu-item-group v-for="(list,index1) in item.list" :key="index1">
            <el-menu-item @click="handleTitle({'index':item.index,'path':list.path,'title':list.item1})" :index="list.path" v-if="list.item1 != null">{{list.item1}}</el-menu-item>
            <el-menu-item @click="handleTitle({'index':item.index,'path':list.path,'title':list.item2})" :index="list.path" v-if="list.item2 != null">{{list.item2}}</el-menu-item>
            <el-menu-item @click="handleTitle({'index':item.index,'path':list.path,'title':list.item3})" :index="list.path" v-if="list.item3 != null">{{list.item3}}</el-menu-item>
          </el-menu-item-group>
        </el-submenu>
    </el-menu>
    
  </div>
</template>

<script>
import {mapMutations, mapState} from 'vuex'
export default {
  name: "mainLeft",
  data() {
    return {
      
    }
  },
  computed: {
    ...mapState(["menuHide","menu",'tabsInfo','activeTab']),
    
  },
  created() {
    this.addData()
  },
  methods: {
    
    //点击标题传递参数给navigator组件和topTab组件
    handleTitle(Info) {
      this.bus.$emit('sendIndex',Info.index)
      // this.addTabs({'name':Info.title,'route':Info.path})
      // this.setActiveTab(Info.path)

    },
    addData() {
      let part = this.$cookies?.get("part")
      if(part == null) return;
      //对象转数组
      let arr = Object.values(this.$store.state.menu)
      //判断menu内是否已经有教师管理了。
      for(let i of arr){
        if(i.title === '教师管理'){
          return;
        }
      }
      //判断是不是管理员
      if(part == 0) {
        this.menu.push({
          index: '5',
          title: '教师管理',
          icon: 'icon-Userselect',
          list:[{item1:'教师管理',path:'/manageTeacher'},{item2: '添加教师',path: '/addTeacher'}],
        })
      }
    },
    adjustLeftBarWidth(){
      let lW = document
    },
    handleOpen(key, keyPath) {
      // console.log(key, keyPath);
    },
    handleClose(key, keyPath) {
      // console.log(key, keyPath);
    },
    ...mapMutations(['addTabs'])
  },
  watch: {
            '$route' (to, from) {
                let flag = false
                for (let item of this.tabsInfo) {
                    if (item.name === to.name) { //用name做唯一标识
                        this.$store.commit('setActiveTab', to.path)
                        flag = true
                        break
                    }
                }

                if (!flag) {
                    this.$store.commit('addTabs', {route: to.path, name: to.name})//to.title 中的title即为menu[]中的标签页title
                    this.$store.commit('setActiveTab', to.path)
                }
            
            }
        }//watch

  
}
</script>

<style>

.el-menu-vertical-demo:not(.el-menu--collapse) .el-submenu__title:before {
  transition-duration: 500ms; /* 修改持续时间 */
}

.el-menu-vertical-demo .el-submenu__title { 
  overflow: hidden;
}
.left-width .iconfont {
  font-size: 18px;
  color: #fff;
}
.left-width {
  width: 213px;
}
.el-menu-vertical-demo:not(.el-menu--collapse) {
  min-height: 900px;
}
#left {
  height: 900px;
  /* width:268.51px; */
  background-color: #344058e8;
  z-index: 0;
}
#left .el-menu-vertical-demo .title {
  color: #fff;
  font-size: 16px;
  font-weight: bold;
  margin-left: 14px;
}
.el-submenu {
  border-bottom: 1px solid #eeeeee0f !important;
}
.el-submenu__title:hover {
  background-color: #fff;
}
.el-submenu__title i {
    color: #fbfbfc !important;
}
</style>
