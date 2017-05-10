<script type="text/html" id="tpl-alert-jiedati-more">
    <modal v-show="modal">
        <h3 slot="header">
            添加解答题
            <a href="javascript:" class="modal-close" v-on:click="closeThisModal">×</a>
        </h3>
        <div slot="body" class="lay-normal-box lay-edit-paper-info">
            <div class="lay-set form">
                <div class="item-content">
                    <div class="itm-item">
                        <span class="item-name">题型：</span>
                        <input class="w-full" type="text" value="多选题">
                    </div>
                    <div class="itm-item">
                        <span class="item-name">选择题号：</span>
                <span>
                    <label class="ml10">
                        <input type="checkbox" name="" id="" value="">第20题
                    </label>
                    <label class="ml10">
                        <input type="checkbox" name="" id="" value="">第20题
                    </label>
                    <label class="ml10">
                        <input type="checkbox" name="" id="" value="">第20题
                    </label>
                    <label class="ml10">
                        <input type="checkbox" name="" id="" value="">第20题
                    </label>
                    <label class="ml10">
                        <input type="checkbox" name="" id="" value="">第20题
                    </label>
                    <label class="ml10">
                        <input type="checkbox" name="" id="" value="">第20题
                    </label>
                    <label class="ml10">
                        <input type="checkbox" name="" id="" value="">第20题
                    </label>
                </span>
                    </div>
                    <div class="itm-item">
                        <span class="item-name">必答题数：</span>
                        <select class="w6em" name="" id="">
                            <option value="">1</option>
                            <option value="">2</option>
                            <option value="">3</option>
                            <option value="">4</option>
                            <option value="">5</option>
                        </select> <span class="ml8">题</span>
                    </div>
                    <!--<div class="itm-item">-->
                        <!--<span class="item-name">分数：</span>-->
                        <!--<input class="w12em" type="text" value="20"><span class="ml8">分</span>-->
                    <!--</div>-->
                    <div class="itm-item">
                        <span class="item-name">描述：</span>
                        <textarea class="w-full">请考生在x、x、x题中任选一题作答。请把你所选题目的题号用2B铅笔涂黑。如果多做，则按所做的第一题计分。在作答过程中请写清每问的小标号。p我选做的题号是：[x][x][x]</textarea>
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
