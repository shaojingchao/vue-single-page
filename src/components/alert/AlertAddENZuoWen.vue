<template>
    <modal v-show="modal.state_alertEnZuowen">
        <h3 slot="header">
            英语作文
            <a href="javascript:" class="modal-close" v-on:click="closeThisModal">×</a>
        </h3>
        <div slot="body" class="lay-normal-box lay-edit-paper-info">
            <div class="lay-set form">
                <div class="item-content" id="EN_zuowenForm">
                    <select-part-to v-if="isEdit==0" v-bind:addPartTo="1"></select-part-to>
                    <div class="itm-item">
                        <span class="item-name">标题：</span>
                        <input class="w-full" type="text" name="en-zuowen-title" v-bind:value="defValue.title">
                    </div>
                    <div class="itm-item" v-if="isEdit==0">
                        <span class="item-name">题号：</span>
                        <div class="test-order-set">
                            <span class="text-primary order-str">{{computedOrderRange}}</span>
                            <set-ques-order v-bind:selectedAddedTestNum="selectedAddedTestNum"></set-ques-order>
                        </div>
                    </div>
                    <div class="itm-item">
                        <span class="item-name">添加行数：</span>
                        <select class="w8em" name="en-zuowen-hline" v-bind:value=defValue.hline>
                            <option v-bind:value="hangOpt" v-for="hangOpt in 40">{{hangOpt}} 行</option>
                        </select>
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

  import SelectPartTo from "./SelectPartTo.vue";
  import SetQuesOrder from "./AlertToolSetQuesOrder.vue";
  import Modal from './Modal.vue';
  import VueMixin_AddQuesOrderConfig from "./Mixins.vue"
export default {
    name:'alert-en-zuowen',
    mixins: [VueMixin_AddQuesOrderConfig],
    components: {SelectPartTo,SetQuesOrder,Modal},
    data: function () {
        return {
            isEdit: 0,
            defValue: {
                title: "书面表达",
                hline: 10
            },
            addFor: {}
        }
    },
    created: function () {
        var _this = this;
        Bus.$on("showAlertEditEnZuowen", function (pid, tid) {
            _this.addFor.pid = pid;
            _this.addFor.tid = tid;
            _this.isEdit = 1;
        });
        Bus.$on("showAlertEnZuowen", function (data) {
            _this.isEdit = 0;
            _this.computedOrderID = app.examOrderIDArray.max + 1;
        })
    },
    methods: {
        yesBtn: function () {
            var _this = this,
                pid = _this.addFor.pid,
                tid = _this.addFor.tid;
            var $zuowenForm = $("#EN_zuowenForm"),
                title = $zuowenForm.find("[name=en-zuowen-title]").val(),
                hline = $zuowenForm.find("[name=en-zuowen-hline]").val() - 0;
            _this.defValue.title = title;
            _this.defValue.hline = hline;
            // 来自添加
            if (_this.isEdit == 0) {
                var newOrder = _this.computedOrderID;
                var newType = {
                    'title': title,
                    'display': 1,
                    'type': 4,
                    'content': [
                        {'order': newOrder, 'uline': 1, 'hline': hline, 'score': 20, 'desc': ''}
                    ]
                };
                var partLen = app.data.paper.length;
                app.data.paper[partLen - 1].list.push(newType);
            }
            // 来自编辑
            if (_this.isEdit == 1) {
                app.data.paper[pid].list[tid].title = title;
                app.data.paper[pid].list[tid].content[0].hline = hline;
            }
            app.updateDom();
            app.alert.state_alertEnZuowen = false
        },
        closeThisModal: function () {
            app.alert.state_alertEnZuowen = false
        }
    }
}
</script>
