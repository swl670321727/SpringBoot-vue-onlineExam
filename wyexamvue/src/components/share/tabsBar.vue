<template>
    <div >
        <el-tabs v-model="activeTab"
        @tab-click="handleClick"
        @tab-remove="removeTab"
         type="card" closable >
            <el-tab-pane
            v-for="item of tabsInfo" 
            
            :key="item.route"
            :label="item.name"
            :name="item.route"
            
            >
            </el-tab-pane>
        </el-tabs>
    </div>
</template>

<script>
import { mapState } from 'vuex'
import { mapMutations } from 'vuex';

    export default{
        data(){
            return{
                editableTabsValue: '1', //默认显示的tab坐标值
                tabIndex: 0,  //目前tab最多有几个子tab
                
            }
        },
        methods:{
            ...mapMutations(['AddTabs','deleteTabs','changeTabIndex']),
            removeTab(target) {
                //删除
               if(target == '/index' || target == '/welcome'){
                    return //保证首页不会关闭
               }
               this.$store.commit('deleteTabs',target) //删除
               //重置活跃页(Tabs选项卡)
               if (this.activeTab === target) {
                    if(this.tabsInfo && this.tabsInfo.length >= 1) {
                        
                        this.$store.commit('setActiveTab',this.tabsInfo[this.tabsInfo.length - 1].route)
                        this.$router.push({path:this.activeTab})
                    }
               }
            },
            handleClick(targetName){

                this.$router.push({path: this.tabsInfo[targetName.index].route})
                
            },
            
        },
        computed:{
            tabsInfo(){
                return this.$store.state.tabsInfo
            },
            activeTab:{
                get(){ 
                    return this.$store.state.activeTab;
                },
                set(val){
                    this.$store.commit('setActiveTab',val)
                }
            }
            
        },
        mounted(){
            if (this.$route.path !== '/index' && this.$route.path !== '/welcome') {
                this.$store.commit('addTabs', {route: '/welcome' , name: '首页'})
                this.$store.commit('addTabs', {route: this.$route.path , name: this.$route.name })
                this.$store.commit('setActiveTab', this.$route.path)
            
            } else {
                this.$store.commit('addTabs', {route: '/welcome', name: '首页'})
                this.$store.commit('setActiveTab', '/welcome')
            
            }
        },
        
    }

</script>

<style scoped>


</style>

