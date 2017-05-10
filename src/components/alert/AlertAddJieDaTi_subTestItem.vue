<!--解答题小题属性设置-->
<template>
  <div class="item-detail" v-bind:ques-id="computedOrderID" v-bind:sub-test-id="addSubItemContentIndex">
    <!--样式-->
    <div style="margin-bottom:6px;">
            <span class="type-select" style="margin:0;">
                <label class="unselect radio-img no-line" style="margin:3px 15px 3px 0">
                    <input type="radio" role="uline" checked
                           v-bind:name="'has-underline-'+addItemContentIndex+'-'+addSubItemContentIndex"
                           value="0">无横线</label>
                <label class="unselect radio-img on-line" style="margin:3px 0">
                    <input type="radio" role="uline"
                           v-bind:name="'has-underline-'+addItemContentIndex+'-'+addSubItemContentIndex"
                           value="1">有横线</label>

            </span>
    </div>
    <!--分数-->
    <div style="margin-bottom:6px;">
            <span>
                <select class="w8em" role="score">
                    <option v-bind:value="optScore"
                            v-for="optScore in 30">{{optScore}} 分</option>
                </select>
            </span>
    </div>
    <!--空行属性-->
    <div style="margin-bottom:6px;">

      <!--空-->
      <select class="w8em" role="kong">
        <option v-bind:value="addKongNumItem" v-for="addKongNumItem in 20">{{addKongNumItem}} 空</option>
      </select>

      <!--行-->
      每空
      <select class="w8em" role="hline">
        <option value="1">1 行</option>
        <option value="0.5">1/2 行</option>
        <option value="0.3">1/3 行</option>
        <option v-for="(optItem,optItemIndex) in 29" v-bind:value="optItemIndex+2">{{optItemIndex+2}} 行</option>
      </select>
    </div>
  </div>
</template>

<script>

  export default {
    name: "jiedati-add-sub-test-item",
    props: ["addItemContentIndex", "addSubItemContentIndex", "computedOrderID"],
    data: function () {
      return {
        isAddQuesImg: 0,//是否添加图片
        isAddQuesDesc: 0,//是否添加描述
        addQuesImgBy: '' //如何添加
      }
    }
  }
</script>
