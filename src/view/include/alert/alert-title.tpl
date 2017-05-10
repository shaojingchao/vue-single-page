<!-- 姓名及标题 -->
<script type="text/html" id="tpl-alert-title">
    <modal v-show="modal.state_alertTitle">
        <h3 slot="header">
            修改头部信息
            <a href="javascript:" class="modal-close" v-on:click="closeThisModal">×</a>
        </h3>

        <div slot="body" class="lay-normal-box lay-edit-paper-info">
            <form class="lay-set form" id="form-title-info">
                <div class="item-content">
                    <div class="itm-item" id="alert-paper-name">
                        <span class="item-name">姓名：</span>
                        <input class="w80" type="text" name="paperName"
                               v-bind:value="paperName.content"
                               v-bind:disabled="!paperName.display">
                        <span class="ml8 view-title unselect" data-state="paperName" v-html="paperName.html" @click="toggleShowState"></span>
                    </div>
                    <div class="itm-item" id="alert-paper-title">
                        <span class="item-name">主标题：</span>
                        <input class="w80" type="text" name="mainTitle"
                               v-bind:value="mainTitle.content"
                               v-bind:disabled="!mainTitle.display">
                        <span class="ml8 view-title unselect" data-state="mainTitle" v-html="mainTitle.html" @click="toggleShowState"></span>
                    </div>
                    <div class="itm-item" id="alert-paper-subtitle">
                        <span class="item-name">副标题：</span>
                        <input class="w80" type="text" name="subTitle"
                               v-bind:value="subTitle.content"
                               v-bind:disabled="!subTitle.display">
                        <span class="ml8 view-title unselect" data-state="subTitle" v-html="subTitle.html" @click="toggleShowState"></span>
                    </div>
                </div>
            </form>
        </div>
        <template slot="footer">
            <a class="modal-btn" href="javascript:;" @click="closeThisModal">取消</a>
            <a class="modal-btn modal-btn-primary" href="javascript:;" @click="yesBtn">确定</a>
        </template>
    </modal>

</script>
