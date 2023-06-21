<template>
    <footer id="footer">
        <ul>
            <li><a href="javascript:;">关于我们</a></li>
            <li><a href="javascript:;">免责声明</a></li>
            <li><a href="javascript:;">使用协议</a></li>
            <li><a href="http://beian.miit.gov.cn/" target="_blank">粤ICP备05000001号</a></li>
            <li>@Copyright 2022-2023. ALL Rights Reserved</li>
        </ul>
    </footer>
</template>

<script>
    export default{
        name:'indexFooter',
    }

</script>

<style scoped>
#footer a {
  color: #919698;
  font-size: 14px;
}
#footer {
  background-color: #eee;
}
#footer ul {
  margin: 0;
  border-top: 1px solid #d5d5d5;
  display: flex;
  justify-content: center;
  height: 10vh;
  line-height: 80px;
}
#footer ul li {
  color: #919698;
  font-size: 14px;
  margin-right: 20px;
}

</style>