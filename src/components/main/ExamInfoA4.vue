<template>
  <div class="exam-intro hover">
    <div class="part-menu">
      <a href="javascript:;" class="btn" v-on:click="showAlertExamInfo">
        <i class="iconfont">&#xe601;</i>编辑
      </a>
    </div>
    <!-- A4高考仿真  -->
    <div class="exam-cont layer1 examtype-gk" v-if="type.display=='1'">
      <div class="intro-l left">
        <exam-info-exam-number v-bind:data="data"></exam-info-exam-number>
        <exam-info-notice v-bind:data="data"></exam-info-notice>
      </div>
      <div class="intro-r right">
        <exam-info-barcode v-bind:data="data"></exam-info-barcode>
        <exam-info-miss v-bind:data="data"></exam-info-miss>
      </div>
    </div>
    <!-- A4期中期末  -->
    <div class="exam-cont layer1 examtype-qz" v-if="type.display=='2'">
      <div class="intro-l left">
        <exam-info-num v-bind:data="data"></exam-info-num>
      </div>
      <div class="intro-r right">
        <exam-info-barcode v-bind:data="data"></exam-info-barcode>
        <exam-info-notice v-bind:data="data"></exam-info-notice>
        <exam-info-miss v-bind:data="data"></exam-info-miss>
      </div>
    </div>
    <!-- A4单元测试 -->
    <div class="exam-cont layer1 examcard-no-a4 examtype-dy" v-if="type.display=='3'">
      <div class="intro-l left">
        <exam-info-notice v-bind:data="data"></exam-info-notice>
      </div>
      <div class="intro-r right">
        <exam-info-barcode v-bind:data="data"></exam-info-barcode>
        <exam-info-miss v-bind:data="data"></exam-info-miss>
      </div>
    </div>
    <!-- A4课时训练 -->
    <div class="exam-cont layer1 barcode-no-a4 examtype-ks" v-if="type.display=='4'">
      <div class="intro-l left">
        <exam-info-num v-bind:data="data"></exam-info-num>
      </div>
      <div class="intro-r right">
        <exam-info-notice v-bind:data="data"></exam-info-notice>
        <exam-info-miss v-bind:data="data"></exam-info-miss>
      </div>
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
    name: "exam-info-a4",
    props: ["care", "type", "data"],
    components: {ExamInfoNum, ExamInfoBarcode, ExamInfoMiss, ExamInfoNotice, ExamInfoExamNumber},
    data: function () {
      return {}
    },
    methods: {
      showAlertExamInfo: function () {
        app.alert.state_alertExamInfo = true;
      }
    }
  }
</script>
