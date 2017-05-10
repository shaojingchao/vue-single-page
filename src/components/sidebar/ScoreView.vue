<template>
  <div class="panel-order score-view">
        <span class="type-select">
            <label class="unselect" v-bind:class="{'text-primary':score.display==1}">
                <input type="radio" name="scoreShow" value="1" v-model="score.display">显示
            </label>
            <label class="unselect" v-bind:class="{'text-primary':score.display==0}">
                <input type="radio" name="scoreShow" value="0" v-model="score.display">隐藏
            </label>
        </span>
  </div>
</template>

<script>
  /*是否显示分数*/
  export default {
    name: "score-view",
    props: ["score"],
    watch: {
      "score.display": function (val) {
        app.dataState += 1;
        console.log(val);
      }
    }
  }
</script>
