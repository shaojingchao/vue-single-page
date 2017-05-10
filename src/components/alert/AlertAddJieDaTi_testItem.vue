<!--解答题各题属性设置-->
<template>
  <div class="con-item-list" v-bind:jiedati-ques-id="computedOrderID">
    <div class="itm-item" style="padding-left:65px;">
      <span class="item-name" style="margin-left:-65px;width:65px;">小题：</span>
      <span class="type-select">
        <label class="unselect">
            <input type="radio" role="has-sub-test"
                   v-bind:name="'has-sub-test-'+addItemContentIndex"
                   v-model="isAddSubTest" value="0">无小题</label>
        <label class="unselect">
            <input type="radio" role="has-sub-test"
                   v-bind:name="'has-sub-test-'+addItemContentIndex"
                   v-model="isAddSubTest" value="1">有小题</label>
        <div style="clear:both"></div>
    </span>
    </div>
    <div class="itm-item" style="padding-left:65px;">
      <span class="item-name" style="margin-left:-65px;width:65px;">属性：</span>

      <!--有小题-->
      <div v-if="isAddSubTest-0">
        共
        <select class="w5em" v-model="selectedAddSubNum">
          <option v-for="(optItem,optItemIndex) in (maxAddSubNum-1)"
                  v-bind:value="optItem+1">{{optItem+1}}
          </option>
        </select>
        <span class="ml8">小题</span>
        <div class="sub-tab-item-wrap" role="hasSmallQues">
          <ul class="sub-tab-item clearfix">
            <li v-for="(addSubItem,addSubItemIndex) in selectedAddSubNum"
                v-bind:class="{on:(currentSubItemIndex==addSubItemIndex)}"
                v-on:click="tabCurrentSubItem(addSubItemIndex)">({{addSubItem}})小题
            </li>
          </ul>
          <div class="sub-tab-con">
            <sub-test-item
              v-for="(addSubItemContent,addSubItemContentIndex) in selectedAddSubNum"
              v-show="currentSubItemIndex==addSubItemContentIndex"
              v-bind:computedOrderID="computedOrderID"
              v-bind:addItemContentIndex="addItemContentIndex"
              v-bind:addSubItemContentIndex="addSubItemContentIndex"></sub-test-item>
          </div>
        </div>
      </div>
      <!--没有小题-->
      <div v-if="!(isAddSubTest-0)" role="noSmallQues">
        <sub-test-item
          v-bind:computedOrderID="computedOrderID"
          v-bind:addItemContentIndex="addItemContentIndex"
          v-bind:addSubItemContentIndex="0"></sub-test-item>
      </div>
    </div>
  </div>
</template>

<script>
  // 添加小题组件

  import SubTestItem from "./AlertAddJieDaTi_subTestItem.vue"
  export default {
    name: "jiedati-add-test-item",
    props: ["addItemContentIndex", "addSubItemContentIndex", "computedOrderID"],
    components: {SubTestItem},
    data: function () {
      return {
        isAddQuesDesc: 0,//是否添加描述
        isAddSubTest: 0,//是否添加小题
        currentSubItemIndex: 0,//当前题号
        maxAddSubNum: 10,//最大添加数量
        selectedAddSubNum: 2 //默认添加数量
      }
    },
    watch: {
      selectedAddSubNum: function (v, o) {
        console.log(v, o);
        if (this.currentSubItemIndex >= v) {
          this.currentSubItemIndex = 0
        }
      }
    },

    methods: {
      //tab切换小题
      tabCurrentSubItem: function (tabid) {
        this.currentSubItemIndex = tabid - 0
      }
    }
  }
</script>
