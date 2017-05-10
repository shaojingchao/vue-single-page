<script type="text/html" id="tpl-alert-cn-zuowen">
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
</script>
