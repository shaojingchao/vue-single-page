<script type="text/html" id="tpl-alert-add-desc">
    <modal v-if="modal.state_alertAddDesc">
        <h3 slot="header">
            编辑
            <a href="javascript:" class="modal-close" v-on:click="closeThisModal">×</a>
        </h3>
        <div slot="body" class="lay-normal-box lay-edit-paper-info" style="width:500px">
            <div class="lay-set form">
                <div class="item-content">
                    <!--添加描述-->
                    <div class="itm-item">
                        <span class="item-name">描述：</span>
                        <span class="type-select">
                            <label class="unselect">
                                <input type="checkbox" name="" v-model="isAddQuesDesc">添加描述</label>
                        </span>
                        <textarea class="w-full" v-if="isAddQuesDesc" role="desc" placeholder="描述" v-model="editData.desc"></textarea>
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