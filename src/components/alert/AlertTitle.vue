<!-- 姓名及标题 -->
<template>
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
            <span class="ml8 view-title unselect" data-state="paperName" v-html="paperName.html"
                  @click="toggleShowState"></span>
          </div>
          <div class="itm-item" id="alert-paper-title">
            <span class="item-name">主标题：</span>
            <input class="w80" type="text" name="mainTitle"
                   v-bind:value="mainTitle.content"
                   v-bind:disabled="!mainTitle.display">
            <span class="ml8 view-title unselect" data-state="mainTitle" v-html="mainTitle.html"
                  @click="toggleShowState"></span>
          </div>
          <div class="itm-item" id="alert-paper-subtitle">
            <span class="item-name">副标题：</span>
            <input class="w80" type="text" name="subTitle"
                   v-bind:value="subTitle.content"
                   v-bind:disabled="!subTitle.display">
            <span class="ml8 view-title unselect" data-state="subTitle" v-html="subTitle.html"
                  @click="toggleShowState"></span>
          </div>
        </div>
      </form>
    </div>
    <template slot="footer">
      <a class="modal-btn" href="javascript:;" @click="closeThisModal">取消</a>
      <a class="modal-btn modal-btn-primary" href="javascript:;" @click="yesBtn">确定</a>
    </template>
  </modal>
</template>

<script>

//  编辑头部信息

import Modal from './Modal.vue';

  export default {
    name: "alert-title",
    props: ["modal", "title"],
    components:{Modal},
    data: function () {
      return {
        showHtml: '<i class="iconfont">&#xe608;</i>隐藏',
        hideHtml: '<i class="iconfont">&#xe609;</i>显示'
      };
    },
    computed: {
      paperName: function () {
        return $.extend(
          {},
          this.title.top,
          {html: this.title.top.display === 1 ? this.showHtml : this.hideHtml}
        );
      },
      mainTitle: function () {
        return $.extend(
          {},
          this.title.title,
          {html: this.title.title.display === 1 ? this.showHtml : this.hideHtml}
        );
      },
      subTitle: function () {
        return $.extend(
          {},
          this.title.sub,
          {html: this.title.sub.display === 1 ? this.showHtml : this.hideHtml}
        );
      }
    },
    methods: {
      yesBtn: function () {
        var $form = $("#form-title-info").find('input:text');
        var objTitle = {};
        // 缓存设置状态
        $.each($form, function () {
          objTitle[this.name] = {};
          objTitle[this.name]["content"] = this.value;
          objTitle[this.name]["display"] = !this.disabled;
        });
        app.data.top = objTitle.paperName;
        app.data.title = objTitle.mainTitle;
        app.data.sub = objTitle.subTitle;
        app.dataState += 1;
        app.alert.state_alertTitle = false;
      },
      toggleShowState: function (event) {
        var $this = $(event.currentTarget);
        var $thisValue = $this.parents('.itm-item').find("input"),
          $thisProp = $thisValue.prop("disabled");
        if ($thisProp === true) {
          $this.html(this.showHtml);
          $this.parents('.itm-item').find("input").prop({"disabled": false});
        } else if ($thisProp === false) {
          $this.html(this.hideHtml);
          $this.parents('.itm-item').find("input").prop({"disabled": true});
        }
      },
      closeThisModal: function () {
        app.alert.state_alertTitle = false;
      }
    }
  }
</script>
