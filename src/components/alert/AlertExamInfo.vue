<template>
  <!-- 编辑准考证区域 -->
  <modal v-show="modal.state_alertExamInfo">
    <h3 slot="header">
      编辑答题卡
      <a href="javascript:" class="modal-close" v-on:click="closeThisModal">×</a>
    </h3>
    <div slot="body" class="lay-normal-box lay-edit-paper-info">
      <div class="lay-set form">
        <div class="item-content">
          <div class="itm-item">
            <span class="item-name">准考证号：</span>
            <input class="w-full" type="text" value="准考证号" name="examcard" disabled>
          </div>
          <div class="itm-item">
            <span class="item-name">注意事项：</span>
            <textarea class="large-text" style="height:8em;" id="examInfoNotice" name="notice"
                      v-bind:disabled="careDisplay !=1 "
                      v-bind:value="care.content" rows="5"></textarea>
            <div class="prompt"><strong>提示：</strong>段落换行请使用 <em>"回车键"</em></div>
          </div>
          <!-- v-if="data.type.display == 1 || data.type.display == 2"-->
          <div class="itm-item">
            <span class="item-name">显示区块：</span>
            <div class="ctrl-block-show unselect">
              <label><input type="checkbox"
                            v-bind:true-value="1"
                            v-bind:false-value="0"
                            v-bind:disabled="data.type.display == 3"
                            v-model="numDisplay" id="J_numDisplay">准考证号</label>
              <label><input type="checkbox"
                            v-bind:true-value="1"
                            v-bind:false-value="0"
                            v-bind:disabled="data.type.display == 4"
                            v-model="codeDisplay" id="J_codeDisplay">贴条形码区</label>
              <br>
              <label><input type="checkbox"
                            v-bind:true-value="1"
                            v-bind:false-value="0"
                            v-on:change="careDisplayChange"
                            v-model="careDisplay" id="J_careDisplay">注意事项</label>
              <label><input type="checkbox"
                            v-bind:true-value="1"
                            v-bind:false-value="0"
                            v-model="missDisplay" id="J_missDisplay">缺考标记</label>
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

  import Modal from './Modal.vue';

  export default {
    name: 'alert-exam-info',
    props: ["care", "modal", "data"],
    components: {Modal},
    data: function () {
      return {}
    },
    computed: {
      numDisplay: function () {
        return this.data.num.display;
      },
      codeDisplay: function () {
        return this.data.code.display;
      },
      careDisplay: function () {
        return this.data.care.display;
      },
      missDisplay: function () {
        return this.data.miss.display;
      }
    },
    methods: {
      careDisplayChange: function (event) {
        var $examInfoNotice = $("#examInfoNotice");
        if ($(event.currentTarget).prop("checked") === true) {
          $examInfoNotice.prop("disabled", false)
        } else {
          $examInfoNotice.prop("disabled", true)
        }

      },
      yesBtn: function () {
        var _this = this;
        _this.data.care.content = $("#examInfoNotice").val();
        _this.data.num.display = $("#J_numDisplay").prop("checked") === false ? 0 : 1;
        _this.data.code.display = $("#J_codeDisplay").prop("checked") === false ? 0 : 1;
        _this.data.care.display = $("#J_careDisplay").prop("checked") === false ? 0 : 1;
        _this.data.miss.display = $("#J_missDisplay").prop("checked") === false ? 0 : 1;
        app.dataState += 1;
        app.alert.state_alertExamInfo = false
      },
      closeThisModal: function () {
        app.alert.state_alertExamInfo = false
      }
    }
  }
</script>
