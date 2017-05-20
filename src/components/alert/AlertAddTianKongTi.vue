<template>
  <modal v-show="modal.state_alertTiankongti">
    <h3 slot="header">
      添加填空题
      <a href="javascript:" class="modal-close" v-on:click="closeThisModal">×</a>
    </h3>
    <div slot="body" class="lay-normal-box lay-edit-paper-info">
      <div class="lay-set form">
        <div class="item-content" id="lay_tiankongti">
          <select-part-to v-if="addFrom==='bar'" v-bind:addPartTo="1"></select-part-to>
          <div class="itm-item">
            <span class="item-name">标题：</span>
            <input class="w-full" type="text" role="title" v-bind:value="defValue.title">
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
              <select class="w8em" v-model="selectedAddedTestNum">
                <option v-bind:value="optItem" v-for="optItem in 20">{{optItem}} 题</option>
              </select>
            </span>
          </div>
          <!--编辑小题属性-->
          <div class="itm-item" id="add_tiankongti_form">
            <span class="item-name">试题编号：</span>
            <div class="fillin-list">
              <tiankongti-sub
                v-bind:selectedAddedTestNum="selectedAddedTestNum"
                v-bind:itemIndex="itemIndex"
                v-bind:computedOrderID="computedOrderID"
                v-for="(subItem,itemIndex) in (selectedAddedTestNum-0)"
                v-bind:key="itemIndex"></tiankongti-sub>
            </div>
          </div>
        </div>
      </div>
    </div>
    <template slot="footer">
      <a class="modal-btn" href="javascript:;" @click="closeThisModal">取消</a>
      <a class="modal-btn modal-btn-primary" href="javascript:;" @click="yesBtn">确定</a>
    </template>
  </modal>
</template>


<script>

  import TiankongtiSub from "./AlertAddTianKongTi_sub.vue"
  import SelectPartTo from "./SelectPartTo.vue"
  import SetQuesOrder from "./AlertToolSetQuesOrder.vue"
  import VueMixin_AddQuesOrderConfig from "./Mixins.vue"
  import Modal from './Modal.vue';

  export default {
    name: "alert-tiankongti",
    mixins: [VueMixin_AddQuesOrderConfig],
    components: {TiankongtiSub,SelectPartTo,SetQuesOrder,Modal},
    props: ["examPart"],
    data: function () {
      return {
        defValue: {
          title: "填空题"
        }
      }
    },
    created: function () {
      var _this = this;
      // 监听添加事件
      Bus.$on("showAlertTiankongti", function (data) {
        console.log(data);
        _this.addFrom = data;
        _this.computedOrderID = app.examOrderIDArray.max + 1;
      });
    },
    methods: {
      yesBtn: function () {
        var _this = this,
          addFrom = _this.addFrom,
          shouldOrderID = app.examOrderIDArray.max + 1,
          title = $("#lay_tiankongti").find("[role=title]").val(),
          selectedAddedTestFormItem = $("#add_tiankongti_form").find(".fillin-list-nub"),
          addItem = [];// 缓存新添加试题数组

        // 检查用户设置题号
        if (app.checkUserSetOrderID()) {
          if ($.isNumeric(app.checkUserSetOrderID())) {
            shouldOrderID = app.checkUserSetOrderID()
          }
        }
        // 生成添加数据格式
        selectedAddedTestFormItem.each(function (i) {
          var $this = $(this);
          var itemHline = $this.find("[role=hline]").val() - 0,
            itemKong = $this.find("[role=kong]").val() - 0,
            itemHasSubOrder = $this.find("[role=hasSubOrder]").prop("checked"),
            newItem = {
              "order": shouldOrderID + i,
              "small": 0,
              "uline": 1,
              'kong': 1,
              'hline': itemHline,
              "desc": '',
              "img": [],
              "score": 2
            };
          //无小题
          if (!itemHasSubOrder) {
            addItem.push(
              $.extend({}, newItem, {
                'kong': itemKong
              }))
          }
          // 有小题
          if (itemHasSubOrder) {
            for (var j = 0; j < itemKong; j++) {
              addItem.push(
                $.extend({}, newItem, {
                  'small': j + 1
                }))
            }
          }
        });
        // 添加
        if (addFrom === 'bar') {// 来自添加
          var newType = {
            'title': title,
            'display': 1,
            'type': 1,
            'content': addItem
          };
          var partIndex = $(".j_selectPartTo:visible").val() - 0;
          if (app.addToListNewTypeItem(newType, partIndex)) {
            app.alert.state_alertTiankongti = false
          }
        } else {
          if (app.addToListNewContentItem(addItem, addFrom)) {
            app.alert.state_alertTiankongti = false
          }
        }

      },
      closeThisModal: function () {
        app.alert.state_alertTiankongti = false;
      }
    }
  }
</script>
