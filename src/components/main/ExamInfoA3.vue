<template>
  <div class="exam-intro hover">
    <div class="part-menu">
      <a href="javascript:;" class="btn" v-on:click="showAlertExamInfo">
        <i class="iconfont">&#xe601;</i>编辑
      </a>
    </div>
    <!-- A3高考仿真  -->
    <div class="exam-cont simpleness examtype-gk" v-if="type.display=='1'">
      <exam-info-exam-number v-bind:data="data"></exam-info-exam-number>
      <div class="clearfix">
        <div class="intro-l left">
          <exam-info-barcode v-bind:data="data"></exam-info-barcode>
          <exam-info-miss v-bind:data="data"></exam-info-miss>
        </div>
        <div class="intro-r right">
          <exam-info-notice v-bind:data="data"></exam-info-notice>
        </div>
      </div>
    </div>
    <!-- A3期中期末  -->
    <div class="exam-cont complex examtype-qz" v-if="type.display=='2'">
      <exam-info-num v-bind:data="data"></exam-info-num>
      <div class="intro-l left">
        <exam-info-barcode v-bind:data="data"></exam-info-barcode>
        <exam-info-miss v-bind:data="data"></exam-info-miss>
      </div>
      <div class="intro-r right">
        <exam-info-notice v-bind:data="data"></exam-info-notice>
      </div>
    </div>
    <!-- A3单元测试 -->
    <div class="exam-cont examtype-dy" v-if="type.display=='3'">
      <div class="intro-l left">
        <exam-info-barcode v-bind:data="data"></exam-info-barcode>
        <exam-info-miss v-bind:data="data"></exam-info-miss>
      </div>
      <div class="intro-r right">
        <exam-info-notice v-bind:data="data"></exam-info-notice>
      </div>
    </div>
    <!-- A3课时训练 -->
    <div class="exam-cont examtype-ks" v-if="type.display=='4'">
      <exam-info-exam-number v-bind:data="data"></exam-info-exam-number>
      <exam-info-miss v-bind:data="data"></exam-info-miss>
    </div>
  </div>
</template>

<script>
  import ExamInfoNum  from "../exam-info-num.vue"
  import ExamInfoBarcode  from "../exam-info-barcode.vue"
  import ExamInfoMiss  from "../exam-info-miss.vue"
  import ExamInfoNotice  from "../exam-info-notice.vue"
  import ExamInfoExamNumber  from "../exam-info-exam-number.vue"
  export default {
    name: "exam-info-a3",
    props: ["care", "type", "data"],
    components: {ExamInfoNum, ExamInfoBarcode, ExamInfoMiss, ExamInfoNotice, ExamInfoExamNumber},
    methods: {
      showAlertExamInfo: function () {
        app.alert.state_alertExamInfo = true;
      }
    }
  }
</script>
