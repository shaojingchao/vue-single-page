<template>
    <modal v-show="modal.state_alertXuandati">
        <h3 slot="header">
            添加选答题
            <a href="javascript:" class="modal-close" v-on:click="closeThisModal">×</a>
        </h3>
        <div slot="body" class="lay-normal-box lay-edit-paper-info" style="width:550px">
            <div class="lay-set form">
                <div class="item-content" id="lay_xuandati">
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
                            <option v-bind:value="addNumItem+1" v-for="addNumItem in 5">{{addNumItem+1}} 题</option>
                        </select>
                        <select class="w8em" role="ques-do">
                            <option v-bind:value="addNumItem" v-for="addNumItem in selectedAddedTestNum-1">必做 {{addNumItem}} 题</option>
                        </select>
                    </div>
                    <div class="itm-item">
                        <span class="item-name">分数：</span>
                        <select class="w8em" role="score">
                            <option v-bind:value="optScore" v-for="optScore in 30">{{optScore}} 分</option>
                        </select>
                    </div>

                    <div class="itm-item">
                        <span class="item-name">行数：</span>
                        <select class="w8em" role="hline">
                            <option v-for="optItem in 30" v-bind:value="optItem">{{optItem}} 行</option>
                        </select>
                    </div>
                    <!--<div class="itm-item">-->
                        <!--<span class="item-name">设置：</span>-->
                        <!--<div class="explain-info">-->
                            <!--<ul class="tab-item">-->
                                <!--<li v-bind:class="{on:(currentItemIndex==addItemIndex)}"-->
                                    <!--v-for="(addItem,addItemIndex) in selectedAddedTestNum-0"-->
                                    <!--v-on:click="tabCurrentItem(addItemIndex)">第{{computedOrderID+addItemIndex}}题</li>-->
                            <!--</ul>-->
                            <!--<div class="con-item" id="xuandatiAddedQuesContent">-->
                                <!--<xuandati-add-test-item-->
                                        <!--v-for="(addItemContent,addItemContentIndex) in selectedAddedTestNum-0"-->
                                        <!--v-show="currentItemIndex==addItemContentIndex"-->
                                        <!--v-bind:computedOrderID="computedOrderID+addItemContentIndex"-->
                                        <!--v-bind:addItemContentIndex="addItemContentIndex"></xuandati-add-test-item>-->
                            <!--</div>-->
                        <!--</div>-->
                    <!--</div>-->
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

  import SelectPartTo from "./SelectPartTo.vue";
  import SetQuesOrder from "./AlertToolSetQuesOrder.vue";
  import Modal from './Modal.vue';
  import VueMixin_AddQuesOrderConfig from "./Mixins.vue"

export default {
    name:"alert-xuandati",
    mixins: [VueMixin_AddQuesOrderConfig],
    components: {SelectPartTo,SetQuesOrder,Modal},
    data: function () {
        return {
            defValue: {
                title: "选答题"
            },
            selectedAddedTestNum: 2//默认添加2道
        }
    },
    created: function () {
        var _this = this;
        Bus.$on("showAlertXuandati", function (data) {
            _this.addFrom = data;
            _this.computedOrderID = app.examOrderIDArray.max + 1;//计算题号
        });
    },
    methods: {
        yesBtn: function () {
            var _this = this,
                addFrom = _this.addFrom;
            // 获取表单试题属性
            var $xuandati = $("#lay_xuandati"),
                title = $xuandati.find("[role=title]").val(),
                $quesDo = $xuandati.find("[role=ques-do]").val() - 0,
                $hline = $xuandati.find("[role=hline]").val() - 0,
                $score = $xuandati.find("[role=score]").val() - 0 || 10;

            // 缓存新试题
            var addItem = [];
            for (var o = 0; o < this.selectedAddedTestNum; o++) {
                addItem.push({
                    order: this.computedOrderID + o,
                    small: 0,
                    uline: 0,
                    kong: 0,
                    hline: $hline,
                    score: $score
                });
            }

            if (addFrom === 'bar') {// 来自添加
                var newType = {
                    'title': title,
                    'display': 1,
                    'type': 2,
                    'do': $quesDo,
                    'content': addItem
                };
                var partIndex = $(".j_selectPartTo:visible").val() - 0;
                if (app.addToListNewTypeItem(newType, partIndex)) {
                    app.alert.state_alertXuandati = false
                }
            } else {
                if (app.addToListNewContentItem(addItem, addFrom)) {
                    app.alert.state_alertXuandati = false
                }
            }
        },
        closeThisModal: function () {
            app.alert.state_alertXuandati = false
        }
    }
}

</script>


