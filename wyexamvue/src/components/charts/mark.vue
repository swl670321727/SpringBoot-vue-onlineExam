<template>
  <div id ="markto">
    <div ref="box" class="box">
        <!-- 图标区域 -->
    </div>
    <div class="notFound" v-if="isNull">
      <el-empty description="该考生未参加考试"></el-empty>
      <!-- <i class="iconfont icon-LC_icon_tips_fill"></i><span>该考生未参加考试</span> -->
    </div>
  </div>
</template>

<script>
export default {
  name: "markto",
  data() {
    return {
      isNull: false, //原始数据
      tableDataX: [], //x轴数据 保存次数
      tableDataY: [], //y轴数据 保存分数
    }
  },
  mounted() {
    this.getMark();
  },
  methods: {
    getMark() {
      if(this.$route.query.examineeId == undefined){
        this.isNull = true;
        return;
      }

      let examineeId = this.$route.query.examineeId
      this.$axios(`/API/mark/${examineeId}`).then(res => { //根据学生Id查询成绩 
        // console.log(res)
        if(res.data.code == 200) {
          let rootData = res.data.data
          rootData.forEach((element,index) => {
            this.tableDataX.push(`第${index + 1}次`)
            this.tableDataY.push(element.objMark)
          });
          let boxDom = this.$refs["box"];
          let scoreCharts = this.$echarts.init(boxDom);
          let option = {
            xAxis: {
              type: "category",
              data: this.tableDataX
            },
            yAxis: {
              type: "value"
            },
            series: [
              {
                data: this.tableDataY,
                type: "line",
                itemStyle: { normal: { label: { show: true } } }
              }
            ]
          };
            scoreCharts.setOption(option);
            scoreCharts.on("mouseover", params => {
            // console.log(params.value);
          });
        }else {
          this.isNull = true
        }
      })
    },

  }
};
</script>

<style  scoped>
#markto {
    position: relative;
    width: 600px;
    height: 400px;
    
}

.box{
    width: 600px;
    height: 400px;
    border:1px solid rgb(230, 227, 227);
}
.notFound {
  position: absolute;
  top: 15%;
  left: 35%;
}
</style>
