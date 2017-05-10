<template>
  <modal v-show="modal.state_alertPartInfo">
    <h3 slot="header">
      编辑分卷信息
      <a href="javascript:" class="modal-close" v-on:click="closeThisModal">×</a>
    </h3>
    <div slot="body" class="lay-normal-box lay-edit-paper-info">
      <div class="lay-set form">
        <div class="item-content" id="partInfoSet">
          <div class="itm-item partInfoItem" v-for="(partTitleItem,partTitleItemIndex) in examPart">
            <div>
              <span class="item-name">{{String.fromCharCode(8544+partTitleItemIndex)}} 卷信息：</span>
              <input class="w-full" type="text" v-bind:name="'part-title-'+partTitleItemIndex"
                     v-bind:value="partTitleItem.title">
            </div>
            <div style="margin-top:6px">
              <span class="item-name">{{String.fromCharCode(8544+partTitleItemIndex)}} 卷描述：</span>
              <input class="w-full" type="text" v-bind:name="'part-desc-'+partTitleItemIndex"
                     v-bind:value="partTitleItem.desc">
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
</template>

<script>
  /*========
   编辑分卷信息
   ========*/

  import Modal from './Modal.vue';

  export default {
    name: "alert-part-info",
    props: ["examPart", "modal"],
    components:{Modal},
    methods: {
      yesBtn: function () {
        var partInfoSetItem = $("#partInfoSet").find(".partInfoItem");
        partInfoSetItem.each(function (i) {
          var $this = $(this);
          // 更新数据
          app.data.paper[i].title = $this.find("[name=part-title-" + i + "]").val();
          app.data.paper[i].desc = $this.find("[name=part-desc-" + i + "]").val();
        });
        app.dataState += 1;
        app.alert.state_alertPartInfo = false
      },
      closeThisModal: function () {
        app.alert.state_alertPartInfo = false
      }
    }
  }
</script>
