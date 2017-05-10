<script type="text/html" id="tpl-alert-en-zuowen">
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
                    <!--<div class="itm-item">-->
                        <!--<span class="item-name">开头描述：</span>-->
                        <!--<textarea class="w-full">This example cannot be edited because our editor uses a textarea for input,and your browser does not allow a textarea inside a textarea.</textarea>-->
                    <!--</div>-->
                    <!--<div class="itm-item">-->
                        <!--<span class="item-name">结尾描述：</span>-->
                        <!--<textarea>This example cannot be edited because our editor uses a textarea for input,and your browser does not allow a textarea inside a textarea.</textarea>-->
                    <!--</div>-->
                </div>
            </div>
        </div>
        <template slot="footer">
            <a class="modal-btn" href="javascript:;" @click="closeThisModal">取消</a>
            <a class="modal-btn modal-btn-primary" href="javascript:;" @click="yesBtn">确定</a>
        </template>
    </modal>
</script>
