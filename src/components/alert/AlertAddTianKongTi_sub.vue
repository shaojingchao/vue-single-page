<template>
  <div class="fillin-list-nub">
    <span class="item-number"
          v-bind:data-role-order="computedOrderID + itemIndex">第 {{computedOrderID + itemIndex}} 题</span>
    <p class="item-detail">
      <select class="w8em" role="kong" v-model="changeTestItemKong">
        <option v-bind:value="kongItem" v-for="kongItem in 10">{{kongItem}} 空</option>
      </select>
    </p>
    <p class="item-detail">
      每空
      <select class="w8em" role="hline">
        <option value="1">1 行</option>
        <option value="0.5">1/2 行</option>
        <option value="0.3">1/3 行</option>
        <option v-bind:value="optItem+1" v-for="optItem in 1">{{optItem+1}} 行</option>
      </select>
    </p>
    <p class="item-detail" v-if="changeTestItemKong!=1">
      <label><input type="checkbox" v-bind:disabled="changeTestItemKong==1"
                    class="checktype"
                    role="hasSubOrder">添加小题号</label>
    </p>
  </div>
</template>


<script>
  /*填空题-小题*/

  export default {
    name: "tiankongti-sub",
    props: [
      "selectedAddedTestNum",
      "itemIndex",
      "computedOrderID"
    ],
    data: function () {
      return {
        changeTestItemKong: 1
      }
    }
  }
</script>

