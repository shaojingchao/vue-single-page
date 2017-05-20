<template>
  <div class="content clearfix" id="answer-content">
    <alert-title
      v-bind:title="title"
      v-bind:modal="alert"></alert-title>

    <!--编辑答题卡-->
    <alert-exam-info
      v-bind:data="data"
      v-bind:care="data.care"
      v-bind:modal="alert"></alert-exam-info>

    <!--编辑分卷信息-->
    <alert-part-info
      v-bind:examPart="data.paper"
      v-bind:modal="alert"></alert-part-info>

    <!--添加填空题-->
    <alert-tiankongti
      v-bind:modal="alert"
      v-bind:examPart="data.paper"
      v-bind:examOrderIDArray="examOrderIDArray"></alert-tiankongti>

    <!--选择题-->
    <alert-xuanzeti
      v-bind:modal="alert"
      v-bind:examOrderIDArray="examOrderIDArray"></alert-xuanzeti>

    <!--解答题-->
    <alert-jiedati
      v-bind:modal="alert"
      v-bind:examOrderIDArray="examOrderIDArray"></alert-jiedati>

    <!--编辑解答题-->
    <alert-edit-jiedati
      v-bind:modal="alert"></alert-edit-jiedati>

    <!--选答题-->
    <alert-xuandati
      v-bind:modal="alert"
      v-bind:examOrderIDArray="examOrderIDArray"></alert-xuandati>

    <!--英语作文-->
    <alert-en-zuowen
      v-bind:modal="alert"
      v-bind:examOrderIDArray="examOrderIDArray"></alert-en-zuowen>

    <!--语文作文-->
    <alert-cn-zuowen
      v-bind:modal="alert"
      v-bind:examOrderIDArray="examOrderIDArray"></alert-cn-zuowen>

    <!--编辑试题title-->
    <alert-edit-ques-title
      v-bind:examPart="data.paper"
      v-bind:modal="alert"></alert-edit-ques-title>

    <!--添加试题弹出框-END-->
    <!--答题卡显示区-->
    <div class="left-con" id="left-con">
      <div class="content-box" id="content-box">
        <paper-style
          v-bind:dataState="dataState"
          v-bind:data="data"
          v-bind:examPart="data.paper"
          v-bind:type="data.type"
          v-bind:care="data.care"
          v-bind:modal="alert"
          v-bind:title="title"
          v-bind:score="data.score"
          v-bind:layout="data.layout"></paper-style>
      </div>
    </div>
    <!--答题卡显示区-END-->
    <!-- 右侧操作 -->
    <div class="right-con" id="right-con">
      <div class="panel-item" v-if="answerType != ''">
        <div class="title">答题卡格式</div>
        <div class="answer-type">
          <p v-if="answerType == '1'">统一答题卡</p>
          <p v-if="answerType == '2'">AB卷</p>
        </div>
      </div>
      <div class="panel-item">
        <div class="title">选择版式</div>
        <type-style
          v-bind:layout="data.layout"></type-style>
      </div>
      <div class="panel-item">
        <div class="title">考试类型</div>
        <exam-type
          v-bind:type="data.type"></exam-type>
      </div>
      <div class="panel-item">
        <div class="title">添加试题</div>
        <add-test
          v-bind:modal="alert"
        ></add-test>
      </div>
      <div class="panel-item">
        <div class="title">显示分数</div>
        <score-view
          v-bind:score="data.score"></score-view>
      </div>
      <!--<div class="panel-item">
      -->
      <!--<div class="title">设置禁止作答区</div>
    -->
      <!--<forbid-view>
      -->
      <!--</forbid-view>
      -->
      <!--</div>
      -->
      <div class="panel-item">
        <div class="title">试题列表</div>
        <test-list
          v-bind:modal="alert"
          v-bind:examPart="data.paper"></test-list>
      </div>
    </div>
    <side-btm-handle v-bind:page="computedPage"></side-btm-handle>
  </div>
</template>

<script>

  /*alert folder*/
  import AlertTitle from "./components/alert/AlertTitle.vue"
  import AlertExamInfo from "./components/alert/AlertExamInfo.vue"
  import AlertPartInfo from "./components/alert/AlertPartInfo.vue"
  import AlertTiankongti from "./components/alert/AlertAddTianKongTi.vue"
  import AlertXuanzeti from "./components/alert/AlertAddXuanZeTi.vue"
  import AlertJiedati from "./components/alert/AlertAddJieDaTi.vue"
  import AlertEditJiedati from "./components/alert/AlertEditJieDaTi.vue"
  import AlertXuandati from "./components/alert/AlertAddXuanDaTi.vue"
  import AlertCnZuowen from "./components/alert/AlertAddCNZuoWen.vue"
  import AlertEnZuowen from "./components/alert/AlertAddENZuoWen.vue"
  import AlertEditQuesTitle from "./components/alert/AlertEditQuesTitle.vue"

  /*sidebar folder*/
  import AddTest from "./components/sidebar/AddTest.vue"
  import ExamType from "./components/sidebar/ExamType.vue"
  import PaperStyle from "./components/PaperStyle.vue"
//  import ForbidView from "./components/sidebar/ForbidView.vue"
  import ScoreView from "./components/sidebar/ScoreView.vue"
  import SideBtmHandle from "./components/sidebar/SideBtmHandle.vue"
  import TypeStyle from "./components/sidebar/TypeStyle.vue"
  import TestList from "./components/sidebar/TestList.vue"

  import _vue_data from './js/vueData.js'

  //console.log(_vue_data);


  export default {
    name: 'app',
    components: {
      AlertTitle,
      AlertExamInfo,
      AlertPartInfo,
      AlertTiankongti,
      AlertXuanzeti,
      AlertJiedati,
      AlertEditJiedati,
      AlertXuandati,
      AlertCnZuowen,
      AlertEnZuowen,
      AlertEditQuesTitle,

      PaperStyle,

      TypeStyle,
      ExamType,
      // ForbidView,
      AddTest,
      ScoreView,
      TestList,
      SideBtmHandle
    },
    data: function () {
      return _vue_data;
    },//数据
    //计算属性
    computed: {
      // 获取答题卡类型
      "answerType": function () {
        return 1;
        // parseInt((typeof editData != null ? (editData.getAttr(2) || 0) : 1)) ||
      },
      // 答题卡头部信息
      "title": function () {
        var _this = this;
        return {top: _this.data.top, title: _this.data.title, sub: _this.data.sub}
      }
    },
    methods:{
    }
  }

</script>

<style>
  @import 'css/card.css';
  @import '../bower_components/layer/build/skin/default/layer.css';
  #app{height:100%;}

</style>
