<template>
  <div class="exam-number red" v-if="data.num.display == 1">
    <em class="numwidth">准考证号</em>
    <span v-for="item in 13"></span>
  </div>
</template>
<script>
  export default {
    name: "exam-info-exam-number",
    props: ["data"]
  }
</script>
