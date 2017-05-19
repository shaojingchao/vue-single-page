<template>
  <div class="miss red" v-if="data.miss.display == 1">
    <span class="miss-sign">缺考标记<em></em></span>
    <span>考生禁填</span>
  </div>
</template>
<script>
  export default {
    name: "exam-info-miss",
    props: ["data"]
  }
</script>
