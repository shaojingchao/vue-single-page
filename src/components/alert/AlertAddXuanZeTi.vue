<template>
  <modal v-show="modal.state_alertXuanzeti">
    <h3 slot="header">
      添加选择题
      <a href="javascript:" class="modal-close" v-on:click="closeThisModal">×</a>
    </h3>
    <div slot="body" class="lay-normal-box lay-edit-paper-info">
      <div class="lay-set form" id="add-xuanZeTi-form">
        <div class="item-content">
          <select-part-to v-if="addFrom==='bar'" v-bind:addPartTo="0"></select-part-to>
          <div class="itm-item">
            <span class="item-name">标题：</span>
            <input class="w-full" type="text" value="选择题" disabled>
          </div>
          <div class="itm-item">
            <span class="item-name">题号：</span>
            <div class="test-order-set">
              <span class="text-primary order-str">{{computedOrderRange}}</span>
              <set-ques-order v-bind:selectedAddedTestNum="selectedAddedTestNum"></set-ques-order>
            </div>
          </div>
          <div class="itm-item">
            <span class="item-name">添加题数：</span>
            <span>
              <select class="w8em" name="choice-num" id="choice-num" v-model="selectedAddedTestNum">
                <option v-for="optNum in 50" v-bind:value="optNum">{{optNum}} 题</option>
              </select>
            </span>
          </div>
          <div class="itm-item">
            <span class="item-name">选项类型：</span>
            <span class="type-select">
              <label class="unselect"><input type="radio" name="choice-style" v-model="choiceStyle" value="1">选择题</label>
              <label class="unselect"><input type="radio" name="choice-style" v-model="choiceStyle" value="3">判断题</label>
            </span>
          </div>
          <div class="itm-item">
            <span class="item-name">选项数量：</span>
            <select class="w8em" name="choice-num" id="option-num" v-bind:disabled="choiceStyle==3">
              <option value="2" v-bind:selected="choiceStyle==3">2</option>
              <option value="3">3</option>
              <option value="4" v-bind:selected="choiceStyle!=3">4</option>
              <option value="5">5</option>
              <option value="6">6</option>
              <option value="7">7</option>
            </select>
          </div>
        </div>
      </div>
    </div>
    <template slot="footer">
      <a class="modal-btn" href="javascript:;" @click="closeThisModal">取消</a>
      <a class="modal-btn modal-btn-primary" href="javascript:;" @click="yesBtn()">确定</a>
    </template>
  </modal>
</template>

<script>

  import SelectPartTo from "./SelectPartTo.vue";
  import SetQuesOrder from "./AlertToolSetQuesOrder.vue";
  import Modal from './Modal.vue';
  import VueMixin_AddQuesOrderConfig from "./Mixins.vue"

  export default {
    name:"alert-xuandati",
    components: {SelectPartTo,SetQuesOrder,Modal},
    mixins: [VueMixin_AddQuesOrderConfig],
    data: function () {
      return {
        addFrom: '', //何种方式添加试题
        choiceStyle: 1 //默认大写字母 客观题类型：1大写字母 2小写字母 3判断对错
      }
    },
    created: function () {
      var _this = this;
      // 监听添加事件
      Bus.$on("showAlertXuanzeti", function (data) {
        _this.addFrom = data;
        _this.computedOrderID = app.examOrderIDArray.max + 1;//计算题号
      });
    },
    methods: {
      yesBtn: function () {
        var shouldOrderID = app.examOrderIDArray.max + 1;
        var choiceNum = $("#choice-num").val() - 0,
          choiceStyleForm = $("[name=choice-style]:checked").val() - 0,
          optionNum = $("#option-num").val() - 0;

        // 临时保存添加的题目数据
        var addItem = [];

        // 检查用户设置题号
        if (app.checkUserSetOrderID(shouldOrderID)) {
          if ($.isNumeric(app.checkUserSetOrderID(shouldOrderID))) {
            shouldOrderID = app.checkUserSetOrderID(shouldOrderID)
          }
        }
        for (var i = 0; i < choiceNum; i++) {
          addItem.push({
            order: shouldOrderID + i,
            style: choiceStyleForm,
            small: 0,//默认不包含小题
            num: optionNum
          });
        }

        // 添加到何处
        var _this = this,
          addFrom = _this.addFrom;
        if (addFrom === 'bar') {
          //来自侧边栏
          var newItem = {
            title: "选择题",
            display: 1,
            type: 0,
            style: 0,//默认竖版
            content: addItem
          };
          var partIndex = $(".j_selectPartTo:visible").val() - 0;
          if (app.addToListNewTypeItem(newItem, partIndex)) {
            app.alert.state_alertXuanzeti = false
          }
        } else {
          //来自页面
          if (app.addToListNewContentItem(addItem, addFrom)) {
            app.alert.state_alertXuanzeti = false
          }
        }
      },
      closeThisModal: function () {
        app.alert.state_alertXuanzeti = false
      }
    }
  }
</script>
