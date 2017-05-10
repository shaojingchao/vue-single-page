<template>
  <modal v-show="modal.state_alertEditQuesTitle">
    <h3 slot="header">
      编辑头信息
      <a href="javascript:" class="modal-close" v-on:click="closeThisModal">×</a>
    </h3>
    <div slot="body" class="lay-normal-box lay-edit-paper-info">
      <div class="lay-set form">
        <div v-for="(partItem,partItemIndex) in examPart"
             v-if="partItemIndex == currentPartID">
          <div class="item-content"
               v-for="(quesListItem,quesListItemIndex) in partItem.list"
               v-if="quesListItemIndex == currentTitleID">
            <div class="itm-item">
              <span class="item-name">名称：</span>
              <input class="w-full" type="text" v-bind:name="('ques-title-'+partItemIndex+'-'+currentTitleID)"
                     v-bind:value="quesListItem.title">
            </div>
            <div class="itm-item">
              <span class="item-name"></span>
              <label><input type="radio" v-model="titleShowModal" value="1"
                            v-bind:name="('ques-title-display-'+partItemIndex+'-'+currentTitleID)">显示</label>
              <label><input type="radio" v-model="titleShowModal" value="0"
                            v-bind:name="('ques-title-display-'+partItemIndex+'-'+currentTitleID)">隐藏</label>
            </div>
          </div>
        </div>
      </div>
    </div>
    <template slot="footer">
      <a class="modal-btn" href="javascript:;" @click="closeThisModal">取消</a>
      <a class="modal-btn modal-btn-primary" href="javascript:;" @click="yesBtn(currentPartID,currentTitleID)">确定</a>
    </template>
  </modal>
</template>
<script>
  /*========
   编辑-试题title
   ========*/

  import Modal from './Modal.vue';

  export default {
    name: "alert-edit-ques-title",
    props: ["modal", "examPart"],
    components:{Modal},
    data: function () {
      return {
        currentPartID: '',
        currentTitleID: '' //记录当前点击的试题索引
      }
    },
    beforeCreate: function () {
      var _this = this;
      Bus.$on("showAlertEditQuesTitle", function (pid, tid) {
        _this.currentPartID = pid;
        _this.currentTitleID = tid;
      });
    },
    computed: {
      titleShowModal: function () {
        var _this = this;
        if (_this.currentPartID !== '' && _this.currentTitleID !== '') {
          return _this.examPart[_this.currentPartID].list[_this.currentTitleID].display;
        } else {
          return '0';
        }
      }
    },
    methods: {
      yesBtn: function (pid, tid) {
        // 更新数据
        app.data.paper[pid].list[tid].title = $('[name=ques-title-' + pid + '-' + tid + ']').val();
        app.data.paper[pid].list[tid].display = $('[name=ques-title-display-' + pid + '-' + tid + ']:checked').val() - 0;
        app.dataState += 1;
        app.alert.state_alertEditQuesTitle = false;
      },
      closeThisModal: function () {
        app.alert.state_alertEditQuesTitle = false
      }
    }
  }
</script>
