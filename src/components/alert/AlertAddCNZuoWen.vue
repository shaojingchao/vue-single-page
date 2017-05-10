<script type="text/html" id="tpl-alert-cn-zuowen">

</script>

<template>
    <modal v-show="modal.state_alertCnZuowen">
        <h3 slot="header">
            语文作文
            <a href="javascript:" class="modal-close" v-on:click="closeThisModal">×</a>
        </h3>
        <div slot="body" class="lay-normal-box lay-edit-paper-info">
            <div class="lay-set form">
                <div class="item-content" id="CN_zuowenForm">
                    <select-part-to v-if="isEdit==0" v-bind:addPartTo="1"></select-part-to>
                    <div class="itm-item">
                        <span class="item-name">标题：</span>
                        <input class="w-full" type="text" name="cn-zuowen-title" v-bind:value="defValue.title">
                    </div>
                    <div class="itm-item" v-if="isEdit==0">
                        <span class="item-name">题号：</span>
                        <div class="test-order-set">
                            <span class="text-primary order-str">{{computedOrderRange}}</span>
                            <set-ques-order v-bind:selectedAddedTestNum="selectedAddedTestNum"></set-ques-order>
                        </div>
                    </div>
                    <div class="itm-item">
                        <span class="item-name">格数：</span>
                        <span>
                            <select class="w8em" name="cn-zuowen-char" v-bind:value="defValue.char">
                                <option v-bind:value="charOpt*50" v-for="charOpt in 20">{{charOpt*50}} 格</option>
                            </select>
                        </span>
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
    name:'alert-cn-zuowen',
    mixins: [VueMixin_AddQuesOrderConfig],
    components: {SelectPartTo,SetQuesOrder,Modal},
    data: function () {
        return {
            isEdit: 0,
            defValue: {
                title: "作文",
                char: 800
            },
            addFor: {}
        }
    },
    created: function () {
        var _this = this;
        Bus.$on("showAlertEditCnZuowen", function (pid, tid) {
            _this.addFor.pid = pid;
            _this.addFor.tid = tid;
            _this.isEdit = 1;
        });
        Bus.$on("showAlertCnZuowen", function (data) {
            _this.isEdit = 0;
            _this.computedOrderID = app.examOrderIDArray.max + 1;
        })
    },
    methods: {
        yesBtn: function () {
            var _this = this,
                pid = _this.addFor.pid,
                tid = _this.addFor.tid;
            var $zuowenForm = $("#CN_zuowenForm"),
                title = $zuowenForm.find("[name=cn-zuowen-title]").val(),
                char = $zuowenForm.find("[name=cn-zuowen-char]").val() - 0,
                partIndex = $(".j_selectPartTo:visible").val() - 0;
            _this.defValue.title = title;
            _this.defValue.char = char;
            // 来自添加
            if (_this.isEdit == 0) {
                var newOrder = _this.computedOrderID;
                var newType = {
                    'title': title,
                    'display': 1,
                    'type': 3,
                    'content': [
                        {'order': newOrder, 'char': char, 'score': 60, 'desc': ''}
                    ]
                };
                app.data.paper[partIndex].list.push(newType);
            }
            // 来自编辑
            if (_this.isEdit == 1) {
                app.data.paper[pid].list[tid].title = title;
                app.data.paper[pid].list[tid].content[0].char = char;
            }
            app.updateDom();
            app.alert.state_alertCnZuowen = false
        },
        closeThisModal: function () {
            app.alert.state_alertCnZuowen = false
        }
    }
}
</script>
