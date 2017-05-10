<script type="text/html" id="tpl-alert-jiedati">
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
                                    v-bind:addItemContentIndex="addItemContentIndex"></jiedati-add-test-item>
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
</script>

<!--解答题各题属性设置-->
<script type="text/html" id="tpl-jiedati-add-test-item">
<div class="con-item-list" v-bind:jiedati-ques-id="computedOrderID">
    <div class="itm-item" style="padding-left:65px;">
        <span class="item-name" style="margin-left:-65px;width:65px;">小题：</span>
        <span class="type-select">
        <label class="unselect">
            <input type="radio" role="has-sub-test"
                   v-bind:name="'has-sub-test-'+addItemContentIndex"
                   v-model="isAddSubTest" value="0">无小题</label>
        <label class="unselect">
            <input type="radio" role="has-sub-test"
                   v-bind:name="'has-sub-test-'+addItemContentIndex"
                   v-model="isAddSubTest" value="1">有小题</label>
        <div style="clear:both"></div>
    </span>
    </div>
    <div class="itm-item" style="padding-left:65px;">
        <span class="item-name" style="margin-left:-65px;width:65px;">属性：</span>

        <!--有小题-->
        <div v-if="isAddSubTest-0">
            共
            <select class="w5em" v-model="selectedAddSubNum">
                <option v-for="(optItem,optItemIndex) in (maxAddSubNum-1)"
                        v-bind:value="optItem+1">{{optItem+1}}</option>
            </select>
            <span class="ml8">小题</span>
            <div class="sub-tab-item-wrap" role="hasSmallQues">
                <ul class="sub-tab-item clearfix">
                    <li v-for="(addSubItem,addSubItemIndex) in selectedAddSubNum"
                        v-bind:class="{on:(currentSubItemIndex==addSubItemIndex)}"
                        v-on:click="tabCurrentSubItem(addSubItemIndex)">({{addSubItem}})小题</li>
                </ul>
                <div class="sub-tab-con">
                    <jiedati-add-sub-test-item
                        v-for="(addSubItemContent,addSubItemContentIndex) in selectedAddSubNum"
                        v-show="currentSubItemIndex==addSubItemContentIndex"
                        v-bind:computedOrderID="computedOrderID"
                        v-bind:addItemContentIndex="addItemContentIndex"
                        v-bind:addSubItemContentIndex="addSubItemContentIndex"></jiedati-add-sub-test-item>
                </div>
            </div>
        </div>
        <!--没有小题-->
        <div v-if="!(isAddSubTest-0)" role="noSmallQues">
            <jiedati-add-sub-test-item
                    v-bind:computedOrderID="computedOrderID"
                    v-bind:addItemContentIndex="addItemContentIndex"
                    v-bind:addSubItemContentIndex="0"></jiedati-add-sub-test-item>
        </div>
    </div>
</div>
</script>

<!--解答题小题属性设置-->
<script type="text/html" id="tpl-jiedati-add-sub-test-item">
    <div class="item-detail" v-bind:ques-id="computedOrderID" v-bind:sub-test-id="addSubItemContentIndex">
        <!--样式-->
        <div style="margin-bottom:6px;">
            <span class="type-select" style="margin:0;">
                <label class="unselect radio-img no-line" style="margin:3px 15px 3px 0">
                    <input type="radio" role="uline" checked v-bind:name="'has-underline-'+addItemContentIndex+'-'+addSubItemContentIndex" value="0">无横线</label>
                <label class="unselect radio-img on-line" style="margin:3px 0">
                    <input type="radio" role="uline" v-bind:name="'has-underline-'+addItemContentIndex+'-'+addSubItemContentIndex" value="1">有横线</label>

            </span>
        </div>
        <!--分数-->
        <div style="margin-bottom:6px;">
            <span>
                <select class="w8em" role="score">
                    <option v-bind:value="optScore"
                            v-for="optScore in 30">{{optScore}} 分</option>
                </select>
            </span>
        </div>
        <!--空行属性-->
        <div style="margin-bottom:6px;">

            <!--空-->
            <select class="w8em" role="kong">
                <option v-bind:value="addKongNumItem" v-for="addKongNumItem in 20">{{addKongNumItem}} 空</option>
            </select>

            <!--行-->
            每空
            <select class="w8em" role="hline">
                <option value="1">1 行</option>
                <option value="0.5">1/2 行</option>
                <option value="0.3">1/3 行</option>
                <option v-for="(optItem,optItemIndex) in 29" v-bind:value="optItemIndex+2">{{optItemIndex+2}} 行</option>
            </select>
        </div>
    </div>
</script>
