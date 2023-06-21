<template>
    <div class="table">
            
        <div class="titleBox">
            <ul class="topBar">
                <li><span class="title">我的所有成绩</span></li>
                <li><div class="icon">
                        <el-input suffix-icon="el-icon-search"
                        type="text" placeholder="输入课程名"
                        class="search" 
                        v-model="SearchKeyWord"></el-input>
                     </div></li>
                <li><el-button class="btnSearch" type="primary"  @click="Search()">搜索</el-button></li>
            </ul>
            
        </div>
        <section class="content-el">

            <el-table ref="filterTable" :data="mark" v-loading="load">
                <el-table-column
                prop="answerDate"
                label="考试日期"
                sortable
                width="200"
                column-key="answerDate"
                :filters="filter"
                :filter-method="Handler4filter">
                </el-table-column>

                <el-table-column
                prop="subject"
                label="课程名称"
                width="300"
                filter-placement="bottom-end">
                    <template slot-scope="scope">
                        <el-tag>{{scope.row.subject}}</el-tag>
                    </template>
                </el-table-column>

                

            
                <el-table-column prop="objMark" label="客观题分数" width="120"></el-table-column>
                <el-table-column prop="subMark" label="主观题分数" width="120"></el-table-column>

                <el-table-column label="是否及格" width="100">
                    <template slot-scope="scope">
                        <el-tag :type="scope.row.objMark + scope.row.subMark>= 60 ? 'success' : 'danger'">{{scope.row.objMark >= 60 ? "及格" : "不及格"}}</el-tag>
                    </template>
                </el-table-column>

                <el-table-column label="类型" width="100">
                    <template slot-scope="scope">
                        <el-tag :type="scope.row.markType == 1 ? 'primary' : 'warning'">{{scope.row.markType == 1 ? "考试" : "练习"}}</el-tag>
                    </template>
                </el-table-column>
        </el-table>
        <el-row type="flex" justify="center" align="middle" class="paging">
            <el-pagination
            @size-change="SizeChangeFunc"
            @current-change="CurrentChangeFunc"
            :current-page="paging.currentP"
            :page-sizes="[4,6,8,10]"
            :page-size="paging.size"
            layout="total, sizes, prev, pager, next, jumper"
            :total="paging.totalP">
            </el-pagination>
        </el-row>
        </section>
    </div>
</template>

<script>
    export default{
        data(){
            return{
                load: false, //加载标识符
                paging: { //分页后的留言列表
                    currentP: 1, //当前页
                    totalP: null, //记录条数
                    size: 8 //每页条数
                },
                mark: [], //学生成绩
                filter: null,//过滤参数
                examineeId:null,  //假设,
                SearchKeyWord:null
            }
        },
        methods:{
            getUid(){
                this.examineeId = this.$cookies.get("uid")
            },
            getMark(){
                this.$axios(`API/mark/${this.paging.currentP}/${this.paging.size}/${this.examineeId}`).then(res =>{
                    if(res.data.code == 200){//访问成功
                        this.load = false; //数据加载完成去掉遮罩
                        this.mark = res.data.data.records
                        console.log(this.mark)
                        this.paging = {...res.data.data}
                        let mapValue = this.mark&&this.mark.map((ele,index) => { //通过map得到 filter:[{text,value}]形式的数组对象
                            let newValue = {}
                            newValue.text = ele.answerDate
                            newValue.value  = ele.answerDate
                            return newValue;
                        })
                        let Hash = []
                        const newArray = this.mapValue&&mapValue.reduce((it,next) => { //对新对象进行去重操作
                            Hash[next.text] ? '' : Hash[next.text] = true && it.push(next);
                            return it;
                        },[])
                        this.filter = newArray
                    }
                }).catch(error =>{
                    console.log(error)
                })
            },
            Search(){
                // console.log(this.paging.current)
                // 这里写this.paging.current是因为paging已经被修改过了,currentP => current
                this.$axios.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded; charset=UTF-8'
                this.$axios(`/API/mark/${this.examineeId}`).then(res => {
                    if(res.data.code == 200) {
                        console.log(res.data.data)
                    let markInfo = res.data.data
                    let newPage = markInfo.filter(itemRecords => {
                        return itemRecords.subject.includes(this.SearchKeyWord)
                    })
                    this.mark = newPage
                }
              })
            },
            SizeChangeFunc(val){
                this.paging.size = val;
                this.getMark();
            }, 
            CurrentChangeFunc(val){
                this.paging.currentP = val;
                this.getMark();
            },
            Handler4filter(val, r, c){// r == row c == column
                const property = c["property"];
                return r[property] === val;
            },
            formatter(r) {
                return r.address; // r == row
            },
            filterTag(val, r) {
                return r.tag === val;
            },
        },
        created(){
            this.load = true;
            this.getUid();
            this.getMark();
        }
    }

</script>

<style scoped>

.paging {
  padding-top: 20px;
}

.table {
  width: 980px;
  margin: 0 auto;
}
.titleBox{
    
    width:100%;
    height:6vh;
    border-bottom: 2px solid #d5d5d5;
    /* text-decoration: underline; */
    display: inline-block;
    text-align: center;
    margin-bottom:32px;
}
.topBar{
    list-style:none;
    display:flex;
    padding:0;
    margin-left:20px;
}
.topBar :nth-child(2){
    margin-left:auto;
}
.topBar :nth-child(3){
    /* display:flex; */
    margin-right:2vh;
    margin-left:3vh;
}
.topBar .el-input{
    width:160px;
}
.title {
    font-weight: bold;
    font-size:15px;
    display: flex;
    cursor: pointer ;
    margin-right:auto;
    text-align:center;
    line-height:6vh;
    color:#344058e8;

}

.content-el {
    background-color: #fff;
    padding: 20px;
}


</style>