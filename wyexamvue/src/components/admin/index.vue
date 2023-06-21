<template>
    <div >
        <el-col id="spanWidth" :span="24"><div></div></el-col>
        <v-header></v-header>
        <section class="container">
            <div class="left_side">
                <v-leftBar></v-leftBar>
            </div>

            <div class="main_wrapper">
                <v-tabsBar></v-tabsBar>
                <!-- 考虑到布局美观，暂时去掉navigation -->
                <!-- <v-navigation class="nav"></v-navigation> -->
                
                <router-view></router-view>
            </div>
            
        </section>
        <v-footer></v-footer>
    </div>
</template>

<script>
import header from '@/components/share/header.vue'
import left from '@/components/share/LeftBar.vue'
// import navigation from '@/components/share/navigation.vue'
import footer from '@/components/examinee/indexFooter.vue'
import tabsBar from '@/components/share/tabsBar.vue'

    export default{
        components:{
            'v-header':header,
            'v-leftBar':left,
            // 'v-navigation':navigation,
            'v-footer':footer,
            'v-tabsBar':tabsBar,
        },
        data(){
            return{
                editableTabsInfo:[
                    {
                        title: 'Tab 1',
                        name: '1',
                        content: 'Tab 1 content'
                    },
                    {
                        title: 'Tab 2',
                        name: '2',
                        content: 'Tab 2 content'
                    }
                ]
            }
        },
        methods:{
            
        },
        mounted(){
            
        }
    }

</script>

<style scoped>
#index .nav {
  box-shadow: 1px 0 5px rgba(0, 0, 0, 0.1);
  margin-bottom: 10px;
}
.container {
  display: flex;
  background-color: #fff;
}
.main_wrapper {
  overflow: hidden;
  flex: 1;
  background-color: #fff;
}


</style>
