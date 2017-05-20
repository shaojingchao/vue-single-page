<template>
  <modal v-show="modal.state_alertJiedati">
    <h3 slot="header">
      添加解答题
      <a href="javascript:" class="modal-close" v-on:click="closeThisModal">×</a>
    </h3>
    <div slot="body" class="lay-normal-box lay-edit-paper-info" style="width:800px">
      <div class="lay-set form">
        <div class="item-content" id="lay_jiedati">
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
            <select class="w8em" v-model="selectedAddedTestNum">
              <option v-bind:value="addNumItem" v-for="addNumItem in maxAddNum">{{addNumItem}} 题</option>
            </select>
          </div>
          <div class="itm-item">
            <span class="item-name">设置：</span>
            <div class="explain-info">
              <ul class="tab-item">
                <li v-bind:class="{on:(currentItemIndex==addItemIndex)}"
                    v-for="(addItem,addItemIndex) in selectedAddedTestNum-0"
                    v-on:click="tabCurrentItem(addItemIndex)">第{{computedOrderID+addItemIndex}}题</li>
              </ul>
              <div class="con-item" id="jiedatiAddedQuesContent">
                <jiedati-add-test-item
                  v-for="(addItemContent,addItemContentIndex) in selectedAddedTestNum-0"
                  v-show="currentItemIndex==addItemContentIndex"
                  v-bind:computedOrderID="computedOrderID+addItemContentIndex"
                  v-bind:addItemContentIndex="addItemContentIndex"
                  v-bind:key="addItemContent"></jiedati-add-test-item>
              </div>
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
  import JiedatiAddTestItem from "./AlertAddJieDaTi_testItem.vue"
  import SelectPartTo from "./SelectPartTo.vue"
  import SetQuesOrder from "./AlertToolSetQuesOrder.vue"
  import VueMixin_AddQuesOrderConfig from "./Mixins.vue"
  import Modal from './Modal.vue'

export default {
    name:"alert-jiedati",
    mixins: [VueMixin_AddQuesOrderConfig],
    components:{JiedatiAddTestItem,SelectPartTo,SetQuesOrder,Modal},
    data: function () {
        return {
            defValue: {
                title: "解答题"
            },
            maxAddNum: 10,//最大添加数量
            currentItemIndex: 0 //默认显示的试题标签索引
        }
    },
    watch: {
        "selectedAddedTestNum": function (v, o) {
            console.log(v, o);
            if (this.currentItemIndex >= v) {
                this.currentItemIndex = 0
            }
        }
    },
    created: function () {
        var _this = this;

        // 监听解答题弹出框事件
        Bus.$on("showAlertJiedati", function (data) {
            _this.addFrom = data; //弹框来源
            _this.computedOrderID = app.examOrderIDArray.max + 1;//计算题号
        });
    },
    methods: {

        // 解答题tab切换
        tabCurrentItem: function (tabid) {
            this.currentItemIndex = tabid - 0
        },

        //选择添加题数事件
        selectedAddedTestNumEvent: function (e) {
            var $target = e.currentTarget;
            this.currentItemIndex = this.currentItemIndex > $target.value ? $target.value : this.currentItemIndex;
        },

        // 获取试题属性配置 @$Item 试题对象 @hasSub  是否有小题
        getTestItemAttr: function ($Item, hasSub) {
            // ['order'=>11,'small'=>2,'uline'=>1,'kong'=>2,'hline'=>0.3,'score'=>3],
            var $order = $Item.attr("ques-id") - 0;
            var $small = hasSub === 0 ? 0 : $Item.attr("sub-test-id") - 0 + 1;
            var $score = $Item.find("[role=score]").val() - 0;
            var $uline = $Item.find("[role=uline]:checked").val() - 0;
            var $kong = $Item.find("[role=kong]:visible").val() - 0;
            var $hline = $Item.find("[role=hline]").val() - 0;
            // var $desc = $Item.find("[role=desc]:visible").val();
            return {
                order: $order,
                small: $small,
                uline: $uline,
                kong: $kong || 0,
                hline: $hline,
                score: $score,
                desc: '',
                img: []
            };
        },
        yesBtn: function () {
            var _this = this,
                addFrom = _this.addFrom,
                addItem = [],//缓存试题属性
                title = $("#lay_jiedati").find("[role=title]").val(), // 获取表单试题属性
                $jiedatiAddedQuesContent = $("#jiedatiAddedQuesContent"),//要添加的解答题容器
                $jiedatiItem = $jiedatiAddedQuesContent.find("[jiedati-ques-id]");

            // 遍历新试题数据
            $jiedatiItem.each(function () {
                var $this = $(this),
                    $hasSmall = $this.find('[role="has-sub-test"]:checked').val() - 0,
                    $subTestItem = $this.find("[sub-test-id]");

                // 没有小题
                if ($hasSmall == 0) {
                    addItem.push(_this.getTestItemAttr($subTestItem, 0));
                }
                // 有小题
                if ($hasSmall == 1) {
                    $subTestItem.each(function () {
                        var $subThis = $(this);
                        addItem.push(_this.getTestItemAttr($subThis, 1));
                    })
                }

            });

            console.log(addItem);
            if (addFrom === 'bar') {// 来自添加新题型
                var newType = {
                    'title': title,
                    'display': 1,
                    'type': 1,
                    'content': addItem
                };
                var partIndex = $(".j_selectPartTo:visible").val() - 0;
                if (app.addToListNewTypeItem(newType, partIndex)) {
                    app.alert.state_alertJiedati = false
                }
            } else {//来自当前试题添加
                if (app.addToListNewContentItem(addItem, addFrom)) {
                    app.alert.state_alertJiedati = false
                }
            }
        },
        closeThisModal: function () {
            app.alert.state_alertJiedati = false
        }
    }
}
</script>
