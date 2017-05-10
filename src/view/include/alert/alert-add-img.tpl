<script type="text/html" id="tpl-alert-add-img">
    <modal v-if="modal.state_alertAddImg">
        <h3 slot="header">
            编辑
            <a href="javascript:" class="modal-close" v-on:click="closeThisModal">×</a>
        </h3>
        <div slot="body" class="lay-normal-box lay-edit-paper-info" style="width:500px">
            <div class="lay-set form">
                <div class="item-content">
                    <!--添加图片-->
                    <div class="itm-item">
                        <span class="item-name">图片：</span>
                        <div class="uploadImage">
                            <span class="type-select">
                                <label class="unselect">
                                    <input type="checkbox" v-model="isAddQuesImg">添加图片</label>
                                <label v-if="isAddQuesImg">
                                    <input type="radio" name="addQuesImgBy"
                                           v-model="addQuesImgBy" value="0" v-on:click="selectServerImage">选用试题图片</label>
                                <label v-if="isAddQuesImg">
                                    <input type="radio" name="addQuesImgBy"
                                           v-model="addQuesImgBy" value="1" v-on:click="uploadThisImage">上传</label>
                            </span>
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