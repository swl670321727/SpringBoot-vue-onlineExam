<template>
    <div >
        <div v-if="timeLeft > 0">{{ timeString }}</div>
        <div v-else>倒计时结束</div>
    </div>
</template>

<script>
const savedTimeKey = 'savedTime';
const savedEndTimeKey = 'savedEndTime';

    export default{
        
        data(){
            return{
                timeLeft: 0,//表示还剩下多少秒
                endTime: 0,//表示倒计时结束的时间
            }
        },
        methods:{
            startCountdown() {
                const savedEndTime = localStorage.getItem(savedEndTimeKey);
                const now = Date.now();

                if (savedEndTime && now < savedEndTime) {
                    this.endTime = savedEndTime;
                } else {
                    const time = 1; // 从后端获取的时间，单位为分钟
                    const duration = time * 60 * 1000;
                    this.endTime = now + duration;
                    localStorage.setItem(savedEndTimeKey, this.endTime);
                }

                this.updateTimeLeft();
            },
            updateTimeLeft() {
                const now = Date.now();
                this.timeLeft = Math.max(0, Math.floor((this.endTime - now) / 1000));

                if (this.timeLeft > 0) {
                        setTimeout(() => this.updateTimeLeft(), 1000);
                } else {
                        localStorage.removeItem(savedEndTimeKey);
                }
            },
        },
        created(){
            
        },
        computed:{
            //计算属性 timeString 将 timeLeft 转换为分钟和秒钟的形式，用于在页面中显示倒计时。
            timeString() {
                const minutes = Math.floor(this.timeLeft / 60);
                const seconds = this.timeLeft % 60;
                return `${minutes} 分 ${seconds} 秒`;
            },
        },
        mounted() {
            this.startCountdown();
        },
        watch:{
            timeLeft(newValue,oldValue){
                if(newValue <= 0){
                    this.$message({
                        message:'结束了',
                        type:'warning'
                    })
                }
            }
            
        }

    }

</script>

<style scoped>


</style>