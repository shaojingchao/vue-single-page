<script type="text/html" id="tpl-alert-xuandati">
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
                        <!--<div>-->
                            <!--<select class="w8em" role="kong">-->
                                <!--<option v-bind:value="addKongNumItem"-->
                                        <!--v-for="addKongNumItem in 6">{{addKongNumItem}} 空</option>-->
                            <!--</select>-->
                        <!--</div>-->
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
</script>
<!--解答题各题属性设置-->
<!--<script type="text/html" id="tpl-xuandati-add-test-item">-->
    <!--<div class="con-item-list" v-bind:xuandati-ques-id="computedOrderID">-->
        <!--<div class="itm-item" style="padding-left:65px;">-->
            <!--<span class="item-name" style="margin-left:-65px;width:65px;">小题：</span>-->
            <!--<span class="type-select">-->
        <!--<label class="unselect">-->
            <!--<input type="radio" role="has-sub-test"-->
                   <!--v-bind:name="'has-sub-test-'+addItemContentIndex"-->
                   <!--v-model="isAddSubTest" value="0">无小题</label>-->
        <!--<label class="unselect">-->
            <!--<input type="radio" role="has-sub-test"-->
                   <!--v-bind:name="'has-sub-test-'+addItemContentIndex"-->
                   <!--v-model="isAddSubTest" value="1">有小题</label>-->
        <!--<div style="clear:both"></div>-->
    <!--</span>-->
        <!--</div>-->
        <!--<div class="itm-item" style="padding-left:65px;">-->
            <!--<span class="item-name" style="margin-left:-65px;width:65px;">属性：</span>-->

            <!--有小题-->
            <!--<div v-if="isAddSubTest-0">-->
                <!--共-->
                <!--<select class="w5em" v-model="selectedAddSubNum">-->
                    <!--<option v-for="(optItem,optItemIndex) in 5"-->
                            <!--v-bind:value="optItem+1">{{optItem+1}}</option>-->
                <!--</select>-->
                <!--<span class="ml8">小题</span>-->
                <!--<div class="sub-tab-item-wrap" role="hasSmallQues">-->
                    <!--<ul class="sub-tab-item clearfix">-->
                        <!--<li v-bind:class="{on:(currentSubItemIndex==addSubItemIndex)}"-->
                            <!--v-on:click="tabCurrentSubItem(addSubItemIndex)"-->
                            <!--v-for="(addSubItem,addSubItemIndex) in selectedAddSubNum">( {{addSubItem}} ) 小题</li>-->
                    <!--</ul>-->
                    <!--<div class="sub-tab-con">-->
                        <!--<xuandati-add-sub-test-item-->
                                <!--v-show="currentSubItemIndex==addSubItemContentIndex"-->
                                <!--v-bind:computedOrderID="computedOrderID"-->
                                <!--v-bind:addItemContentIndex="addItemContentIndex"-->
                                <!--v-bind:addSubItemContentIndex="addSubItemContentIndex"-->
                                <!--v-for="(addSubItemContent,addSubItemContentIndex) in selectedAddSubNum"></xuandati-add-sub-test-item>-->
                    <!--</div>-->
                <!--</div>-->
            <!--</div>-->
            <!--没有小题-->
<!--contentItem&ndash;&gt;-->

<!--解答题小题属性设置-->
<!--<script type="text/html" id="tpl-xuandati-add-sub-test-item">-->
    <!--<div class="item-detail" v-bind:ques-id="computedOrderID" v-bind:sub-test-id="addSubItemContentIndex">-->
        <!--&lt;!&ndash;样式&ndash;&gt;-->
        <!--&lt;!&ndash;<div style="margin-bottom:6px;">&ndash;&gt;-->
            <!--&lt;!&ndash;<span class="type-select" style="margin:0;">&ndash;&gt;-->
                <!--&lt;!&ndash;<label class="unselect radio-img on-line" style="margin:3px 15px 3px 0">&ndash;&gt;-->
                    <!--&lt;!&ndash;<input type="radio" role="uline" checked&ndash;&gt;-->
                           <!--&lt;!&ndash;v-bind:name="'has-underline-'+addItemContentIndex+'-'+addSubItemContentIndex" value="1">带横线</label>&ndash;&gt;-->
                <!--&lt;!&ndash;<label class="unselect radio-img no-line" style="margin:3px 0">&ndash;&gt;-->
                    <!--&lt;!&ndash;<input type="radio" role="uline"&ndash;&gt;-->
                           <!--&lt;!&ndash;v-bind:name="'has-underline-'+addItemContentIndex+'-'+addSubItemContentIndex" value="0">不带横线</label>&ndash;&gt;-->
            <!--&lt;!&ndash;</span>&ndash;&gt;-->
        <!--&lt;!&ndash;</div>&ndash;&gt;-->
        <!--&lt;!&ndash;分数&ndash;&gt;-->
        <!--&lt;!&ndash;<div style="margin-bottom:6px;">&ndash;&gt;-->
            <!--&lt;!&ndash;<span>&ndash;&gt;-->
                <!--&lt;!&ndash;<select class="w8em" role="score">&ndash;&gt;-->
                    <!--&lt;!&ndash;<option v-bind:value="optScore"&ndash;&gt;-->
                            <!--&lt;!&ndash;v-for="optScore in 20">{{optScore}} 分</option>&ndash;&gt;-->
                <!--&lt;!&ndash;</select>&ndash;&gt;-->
            <!--&lt;!&ndash;</span>&ndash;&gt;-->
        <!--&lt;!&ndash;</div>&ndash;&gt;-->
        <!--&lt;!&ndash;空行属性&ndash;&gt;-->
        <!--&lt;!&ndash;<div style="margin-bottom:6px;">&ndash;&gt;-->
            <!--&lt;!&ndash;<select class="w8em" role="hline" v-on:change="selectItemHlineEvent">&ndash;&gt;-->
                <!--&lt;!&ndash;<option value="1">1 行</option>&ndash;&gt;-->
                <!--&lt;!&ndash;<option value="0.5">1/2 行</option>&ndash;&gt;-->
                <!--&lt;!&ndash;<option value="0.3">1/3 行</option>&ndash;&gt;-->
                <!--&lt;!&ndash;<option v-for="(optItem,optItemIndex) in 24"&ndash;&gt;-->
                        <!--&lt;!&ndash;v-bind:value="optItemIndex+2">{{optItemIndex+2}} 行</option>&ndash;&gt;-->
            <!--&lt;!&ndash;</select>&ndash;&gt;-->
            <!--&lt;!&ndash;&lt;!&ndash;行&ndash;&gt;&ndash;&gt;-->
            <!--&lt;!&ndash;<select class="w8em" role="kong">&ndash;&gt;-->
                <!--&lt;!&ndash;<option v-bind:value="addKongNumItem"&ndash;&gt;-->
                        <!--&lt;!&ndash;v-for="addKongNumItem in 6">{{addKongNumItem}} 空</option>&ndash;&gt;-->
            <!--&lt;!&ndash;</select>&ndash;&gt;-->
            <!--&lt;!&ndash;&lt;!&ndash;空&ndash;&gt;&ndash;&gt;-->
        <!--&lt;!&ndash;</div>&ndash;&gt;-->
        <!--&lt;!&ndash;添加描述&ndash;&gt;-->
        <!--<div>-->
            <!--<span class="type-select">-->
                <!--<label class="unselect">-->
                    <!--<input type="checkbox" name="" v-model="isAddQuesDesc">添加描述</label>-->
            <!--</span>-->
            <!--<textarea class="w-full" v-if="isAddQuesDesc" role="desc" placeholder="描述"></textarea>-->
        <!--</div>-->
        <!--&lt;!&ndash;添加图片&ndash;&gt;-->
        <!--<div>-->
            <!--<span class="type-select">-->
                <!--<label class="unselect">-->
                    <!--<input type="checkbox" v-model="isAddQuesImg">添加图片</label>-->
                <!--<label v-if="isAddQuesImg">-->
                    <!--<input type="radio" name="addQuesImgBy"-->
                           <!--v-model="addQuesImgBy" value="0">选用试题图片</label>-->
                <!--<label v-if="isAddQuesImg">-->
                    <!--<input type="radio" name="addQuesImgBy"-->
                           <!--v-model="addQuesImgBy" value="1">上传</label>-->
            <!--</span>-->
            <!--<span v-if="addQuesImgBy==1 && isAddQuesImg">-->
                <!--<input type="file"></span>-->
        <!--</div>-->
    <!--</div>-->
<!--</script>-->


