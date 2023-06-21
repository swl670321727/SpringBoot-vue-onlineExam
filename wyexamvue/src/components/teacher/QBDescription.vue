<!-- 题库管理功能介绍 -->
<template>
    <section class="description">
      <p class="title">题库管理功能介绍</p>
      <p class="content">题库表设计和普通数据表设计有所区别。
        分为了四张表,分别是选择题题库表,填空题题库表,判断题题库表,应用题题库表
        每个表保存相应类型的题库,通过一张中间表,将题库和试题关联起来。
        这样就组成了一张完整的试卷。
      </p>
      <p class="content">在线组卷：进入组卷中首先要确定所选难度是否合适，以及对应难度的题目数目。每次组卷的
        每种题型只能根据当前允许的最大组卷题量进行组卷。
      </p>
    </section>
  </template>
  
  <style lang="less" scoped>
  .description {
    margin-left: 40px;
      .title {
          width:100%;
          background-color: #48c9b0;
          font-size: 22px;
          color:#f0ffff;
          height:5vh;
          border-radius:4px;
          line-height:5vh;//垂直居中
          font-weight:bold;
          letter-spacing:2px;//文字错开间距
        }
    
    .content {
      width: 600px;
      background-color: #FAF5F2;
      padding: 16px 32px;
      border-radius: 4px;
      border-left: 5px solid #FDC8C8;
      margin: 20px 0px;
    }
  }
  </style>
  