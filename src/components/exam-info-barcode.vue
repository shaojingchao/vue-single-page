<template>
  <div class="barcode center red" v-if="data.code.display == 1">
    <h3>贴条形码区</h3>
    <p>（正面朝上，切勿贴出虚线方框）</p>
  </div>
</template>

<script>
  export default {
    name: "exam-info-barcode",
    props: ["data"]
  }
</script>
