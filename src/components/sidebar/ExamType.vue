<template>
  <div class="panel-order examtype" id="examtype">
    <a href="javascript:;"
       data-examtype="1"
       v-bind:class="{choice:type.display=='1'}"
       v-on:click="toggleExamType" id="examtype1">高考仿真</a>
    <a href="javascript:;"
       data-examtype="2"
       v-bind:class="{choice:type.display=='2'}"
       v-on:click="toggleExamType" id="examtype2">期中期末</a>
    <a href="javascript:;"
       data-examtype="3"
       v-bind:class="{choice:type.display=='3'}"
       v-on:click="toggleExamType" id="examtype3">单元测试</a>
    <a href="javascript:;"
       data-examtype="4"
       v-bind:class="{choice:type.display=='4'}"
       v-on:click="toggleExamType" id="examtype4">课时训练</a>
  </div>
</template>
<script>
  /*考试类型*/
  export default {
    name: "exam-type",
    props: ["type"],
    data: function () {
      return {}
    },
    methods: {
      toggleExamType: function (event) {
        app.data.type.display = $(event.currentTarget).data("examtype");
        console.log(app.dataState);
        // app.dataState += 1;
      }
    }
  }
</script>
