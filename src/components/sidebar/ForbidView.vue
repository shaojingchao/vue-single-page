<template>
  <div class="panel-order forbid-view">
        <span class="type-select">
            <label><input type="radio" name="noWritable" value="1" v-model="display">启用</label>
            <label><input type="radio" name="noWritable" value="0" v-model="display">禁用</label>
        </span>
  </div>
</template>

<script>
  /*是否显示禁答区*/
  export default {
      name:"forbid-view",
    data: function () {
      return {
        display: 1
      }
    },
    watch: {
      "display": function (val) {
        if (app.noWritable.display = (val - 0)) {
          layer.msg("已启用！", {time: 1000})
        } else {
          layer.msg("已禁用！", {time: 1000})
        }
        app.dataState += 1;
      }
    }
  }
</script>
