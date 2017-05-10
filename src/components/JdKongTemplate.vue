<!--解答题-->
<template>
  <div class="jd-kong-list-item">
    <template v-if="!isENError">
      <div class="jd-hang-item clearfix"
           v-on:mouseenter="hoverThisQues(1)"
           v-on:mouseleave="hoverThisQues(0)"
           v-bind:class="{'jd-hang-p10':isQuesBlock,'jd-hang-npb':isContentLastQuesBlock}"
           v-bind:card-ques-id="cardQuesId">
        <!--<link rel="import" href="/app/card/view/include/ques-handle-btn-group.tpl?__inline">-->

        <!--if no img-->
        <span class="jd-kong-item"
              v-for="kongItem in kongItemLen"
              v-if="!isImg"
              v-bind:class="isNoImgClass">
                    <em class="jd-order" v-bind:class="{'jd-jdt':isQuesBlock}">
                        <span v-if="kongItem==1 && contentItem.small<=1">{{contentItem.order}}.
                            <span v-if="score.display==1"> ({{contentItem.score}}分)</span>
                        </span>
                    </em>

                    <em class="jd-sub" v-if="kongItem==1 && isSmall">({{contentItem.small}})</em>

                    <ques-desc v-bind:contentItem="contentItem" v-if="kongItem==1"></ques-desc>

                    <span class="jdt-block-line" v-if="isShowQuesBlockLine && kongItem==1"></span>
                </span>

        <!--if img-->
        <span class="jd-kong-item hang-has-img no-line"
              v-bind:style="hangHasImgStyle"
              v-bind:class="isImgClass"
              v-if="isImg">
                    <em class="jd-order" v-bind:class="{'jd-jdt':isQuesBlock}">
                        <span>{{contentItem.order}}.<span
                          v-if="score.display==1"> ({{contentItem.score}}分)</span></span>
                    </em>
                    <em class="jd-sub" v-if="isSmall">({{contentItem.small}})</em>

                    <ques-desc v-bind:contentItem="contentItem"></ques-desc>

          <!--<link rel="import" href="/app/card/view/include/ques-tpl-img-list.tpl?__inline">-->

                    <span class="jdt-block-line" v-if="isShowQuesBlockLine"></span>
                </span>
      </div>
    </template>

    <!--短文改错-->
    <template v-if="isENError">
      <div class="jd-hang-item clearfix"
           v-bind:card-ques-id="cardQuesId"
           v-on:mouseenter="hoverThisQues(1)"
           v-on:mouseleave="hoverThisQues(0)">
        <link rel="import" href="/app/card/view/include/ques-handle-btn-group.tpl?__inline">
        <span style="height:auto;">
                <em class="jd-order">
                    <span v-if="contentItem.small==1 || contentItem.small==0">{{contentItem.order}}.
                    <span v-if="score.display==1"> ({{contentItem.score}}分)</span></span>
                </em>
                <em class="jd-sub" v-if="contentItem.small!=0">({{contentItem.small}})</em>
                <div style="line-height:48px;padding-top:15px;" v-html="contentItem.desc"></div>
            </span>
      </div>
    </template>

    <!--短文改错-END-->
  </div>
</template>
<!--解答题-END-->

<script>
  import QuesDesc from "./QuesDesc.vue"
  export default {
    name: "jd-kong-template",
    components: {QuesDesc},
    props: ["contentItem", "partItemIndex", "typeItemIndex", "subOrderID", "score", "itemLength"],
    data: function () {
      return {
        hoverThis: 0
      }
    },
    computed: {
      // 试题id
      cardQuesId: function () {
        var $this = this;
        return $this.contentItem.order + '.' + $this.contentItem.small;
      },
      // formatHline:function(num){
      //     var val = parseInt(num);
      //     if (val != num && val > 1){
      //         return parseInt(num);
      //     }else{
      //         return val;
      //     }
      //
      //
      // },

      kongItemLen: function () {
        var $this = this;
        return ((( 0 < $this.contentItem.hline && $this.contentItem.hline < 1 )
          ? 1 :
          $this.contentItem.hline ) * ( $this.contentItem.kong == 0 ? 1 : $this.contentItem.kong ));
      },
      isSmall: function () {
        return this.contentItem.small != 0
      },
      isNoImgClass: function () {
        var $this = this;
        return {
          'hang-1-3': $this.contentItem.hline == 0.3,
          'hang-1-1': $this.contentItem.hline >= 1,
          'hang-1-2': $this.contentItem.hline == 0.5,
          'no-line': $this.contentItem.uline == 0 || ($this.contentItem.desc && $this.contentItem.desc.length > 0)
        };
      },
      isImgClass: function () {
        var $this = this;
        if ($this.contentItem.hline) {
          return {
            'hang-1-3': $this.contentItem.hline == 0.3,
            'hang-1-1': $this.contentItem.hline >= 1,
            'hang-1-2': $this.contentItem.hline == 0.5
          };
        }
      },
      isImg: function () {
        var $this = this;
        if (!$this.contentItem.img || ($this.contentItem.img && $this.contentItem.img.length === 0)) {
          return false;
        } else if ($this.contentItem.img && $this.contentItem.img.length > 0) {
          return true;
        }
      },
      hangHasImgStyle: function () {
        return {'min-height': Math.max(this.kongItemLen * 48, 150) + 'px'};
      },
      isQuesBlock: function () {
        var $this = this;
        if ($this.contentItem.hline) {
          return $this.contentItem.hline >= 2;
        }
      },
      isContentLastQuesBlock: function () {
        return this.isQuesBlock === true && (this.itemLength - 1) === this.subOrderID
      },
      isShowQuesBlockLine: function () {
        var $this = this;
        if ($this.contentItem.hline) {
          return $this.contentItem.hline >= 2 && $this.subOrderID !== 0 && $this.contentItem.small <= 1;
        }
      },
      // 短文改错
      isENError: function () {
        return this.contentItem.kong == 0 && this.contentItem.hline == 0;
      }
    },
    methods: {

      /*删除*/
      delThisQues: function (pid, tid, oid) {
        app.delQuesType(pid, tid, oid);
      },

      /*下移*/
      moveDownThisQues: function (pid, tid, oid) {
        app.ItemMoveDown(pid, tid, oid);
      },

      /*上移*/
      moveUpThisQues: function (pid, tid, oid) {
        app.itemMoveUp(pid, tid, oid);
      },

      /*单题编辑 - 监听编辑试题弹框*/
      showAlertEditJiedati: function (pid, tid, oid) {
        app.$forceUpdate();
        Bus.$emit("showAlertEditJiedati", {
          pid: pid,
          tid: tid,
          oid: oid
        });
        app.alert.state_alertEditJiedati = true;
      },

      /*单题操作-鼠标移入*/
      hoverThisQues: function (over) {
        this.hoverThis = over;
      }
    }
  }
</script>
