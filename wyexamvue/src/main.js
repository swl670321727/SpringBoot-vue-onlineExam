import Vue from 'vue'
import App from './App.vue'
import router from './router'
import * as echarts from 'echarts'
import VueRouter from 'vue-router'
import store from './store'
import Axios from 'axios'
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'
import VueCookies from 'vue-cookies'
import qs from 'qs'
import '../global.css'//配置全局样式（1背景填充）

Vue.config.productionTip = false
Vue.use(VueCookies)
Vue.use(ElementUI)

Vue.prototype.bus = new Vue()    //公共总线
Vue.prototype.$echarts = echarts
Vue.prototype.$axios = Axios
Vue.prototype.$cookies = VueCookies
Vue.prototype.$qs = qs
Axios.defaults.headers.post['Content-Type'] = 'application/json;charset=utf-8' 
// 'application/x-www-form-urlencoded'



//重复点击导航导致报错，以下代码可解决
const originalPush = VueRouter.prototype.push
VueRouter.prototype.push = function push(location) {
  return originalPush.call(this, location).catch(err => err)
}


new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
