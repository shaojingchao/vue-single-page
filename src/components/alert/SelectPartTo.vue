<!--添加到 ：选择分卷-->
<template>
  <div class="itm-item">
    <span class="item-name">添加到：</span><select class="w8em j_selectPartTo" v-model="selectPartTo">
      <option value="0">第Ⅰ卷</option>
      <option value="1">第Ⅱ卷</option>
    </select>
  </div>
</template>
<script>
  export default {
    name: "select-part-to",
    props: ["addPartTo"],
    computed: {
//默认添加到第几卷
      selectPartTo: function () {
        return this.addPartTo;
      }
    }
  }
</script>
