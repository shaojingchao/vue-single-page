<script type="text/html" id="tpl-alert-xuanzeti">
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
</script>
