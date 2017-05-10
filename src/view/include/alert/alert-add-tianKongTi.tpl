<script type="text/html" id="tpl-alert-tiankongti">
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
                                    v-for="(subItem,itemIndex) in (selectedAddedTestNum-0)"></tiankongti-sub>
                        </div>
                        <!--v-bind:toggleSetOrderID="toggleSetOrderID"
                                    v-bind:getOrderID="getOrderID"
                                    v-bind:itemIndex="itemIndex"-->

                    </div>

                </div>
            </div>
        </div>
        <template slot="footer">
            <a class="modal-btn" href="javascript:;" @click="closeThisModal">取消</a>
            <a class="modal-btn modal-btn-primary" href="javascript:;" @click="yesBtn">确定</a>
        </template>
    </modal>
</script>

<script type="text/html" id="tpl-tiankongti-sub">
    <div class="fillin-list-nub">
        <span class="item-number" v-bind:data-role-order="computedOrderID + itemIndex">第 {{computedOrderID + itemIndex}} 题</span>
        <p class="item-detail">
            <select class="w8em" role="kong" v-model="changeTestItemKong">
                <option v-bind:value="kongItem" v-for="kongItem in 10">{{kongItem}} 空</option>
            </select>
        </p>
        <p class="item-detail">
            每空
            <select class="w8em" role="hline">
                <option value="1">1 行</option>
                <option value="0.5">1/2 行</option>
                <option value="0.3">1/3 行</option>
                <option v-bind:value="optItem+1" v-for="optItem in 1">{{optItem+1}} 行</option>
            </select>
        </p>
        <p class="item-detail" v-if="changeTestItemKong!=1">
            <label><input type="checkbox" v-bind:disabled="changeTestItemKong==1" class="checktype" role="hasSubOrder">添加小题号</label>
        </p>
    </div>
</script>
