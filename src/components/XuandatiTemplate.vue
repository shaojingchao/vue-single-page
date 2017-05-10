<!--解答题-->
<template>
  <div class="ques-type ques-type2"
       v-bind:id="'ques-anchor'+partItemIndex+'-'+typeItemIndex">
    <div class="question explain choice-more hover">
      <div class="part-menu">
        <!--<a href="javascript:;" class="btn" @click="showAlertXuandati(partItemIndex,typeItemIndex)">-->
        <!--<i class="iconfont">&#xe602;</i>添加-->
        <!--</a>-->
        <a href="javascript:;" class="btn" @click="showAlertEditQuesTitle(partItemIndex,typeItemIndex)">
          <i class="iconfont">&#xe601;</i>编辑
        </a>
        <a href="javascript:;"
           class="btn"
           v-on:click="delThisQues(partItemIndex,typeItemIndex)">
          <i class="iconfont">&#xe600;</i>删除
        </a>
        <a v-show="typeItemIndex != partItem.list.length-1"
           href="javascript:;"
           class="btn"
           @click="moveDownThisQues(partItemIndex,typeItemIndex)">
          <i class="iconfont">&#xe605;</i>下移
        </a>
        <a v-show="typeItemIndex !=0"
           href="javascript:;"
           class="btn"
           @click="moveUpThisQues(partItemIndex,typeItemIndex)">
          <i class="iconfont">&#xe604;</i>上移
        </a>
        <!--<link rel="import" href="/app/card/view/include/ques-handle-btn-group.tpl?__inline">-->
      </div>
      <div class="q-title">
        <ques-title-info v-bind:item="newType2"></ques-title-info>
        <!--选作题标题-->
        <div class="content-list">
          <div class="choice-more-detail">
            <p class="info">请考生在 {{newType2.content.order.join(', ')}} 题中任选 {{newType2.do}} 题作答。
              请把你所选题目的题号用2B铅笔涂黑。如果多做，则按所做的第一题计分。在作答过程中请写清每问的小标号。
            </p>
            <p class="num" v-if="newType2.content.order && newType2.content.order.length>0">
              我选做的题号是：
              <span v-for="(orderItem, subOrderID) in newType2.content.order"
                    class="title-num"
                    v-bind:card-ques-id="orderItem">[<b>{{orderItem}}</b>]</span>
              <!--<span class="score" v-if="score.display==1">({{newType2.content.score}}分)</span>-->
            </p>
          </div>
        </div>
        <!--选作题标题-END-->
      </div>
      <div class="q-content">

        <div class="jd-kong-list clearfix">
          <!--新模板-->
          <template>
            <div class="jd-hang-item clearfix">
              <!--no img-->
              <span class="jd-kong-item hang-1-1"
                    v-if="!isHasImg"
                    v-for="kongItem in computedKong"
                    v-bind:class="{'no-line':newType2.content.uline==0}">
                            </span>

              <!--img-->
              <span class="jd-kong-item hang-1-1 hang-has-img no-line" v-if="isHasImg"
                    v-bind:style="{minHeight:hlineHeight*computedKong+'px'}">
                <span class="jd-img-list big-block">
                  <span class="img-item" v-for="imgItem in newType2.content.img">
                    <template v-for="imgItm in imgItem">
                        <img v-bind:src="imgItm[0]" alt="">
                        <br>
                        <span class="img-item-desc" v-if="imgItm[1]">{{imgItm[1]}}</span>
                    </template>
                  </span>
                </span>
                <!--img-list-END-->
              </span>
            </div>
          </template>
        </div>
        <!--新模板-END-->
      </div>
    </div>
  </div>
</template>
<!--解答题-END-->

<script>
  import QuesTitleInfo from "./QuesTitleInfo.vue"

  export default {
    components: {QuesTitleInfo},
    name: "xuandati-template",
    props: ["dataState", "partItem", "partItemIndex", "typeItemIndex", "score", "typeItem"],
    data: function () {
      return {
        hlineHeight: 48
      }
    },
    computed: {

      // 重新定义选答题数据
      newType2: function () {
        var data = this.typeItem;
        var _this = this;
        var newType = $.parseJSON(JSON.stringify(data));//解除vue原数据绑定
        var newContent = {
          order: [],
          img: [],
          desc: [],
          small: 0,
          kong: 0,
          uline: 0,
          hline: 0,
          score: ''
        };
        var content = newType.content;
        for (var j = 0; j < content.length; j++) {
          var contentItem = content[j];
          newContent.order.push(contentItem.order);
          if (contentItem.img && contentItem.img.length > 0) {
            newContent.img.push(contentItem.img);
          }
          newContent.hline = _this.getMaxNumber(j, content, 'hline');
          newContent.uline = _this.getMaxNumber(j, content, 'uline');
          newContent.score = _this.getMaxNumber(j, content, 'score');
        }
        newType.content = newContent;
        return newType;
      },

      //计算空总数量
      computedKong: function () {
        var newHline = this.newType2.content.hline;
        var newDo = this.newType2.do;
        return (newHline <= 0 ? 1 : newHline) * newDo;
      },

      isHasImg: function () {
        return this.newType2.content.img != null && this.newType2.content.img.length > 0
      }
    },
    methods: {

      /*下移*/
      moveDownThisQues: function (pid, tid) {
        app.moveDown(pid, tid);
      },
      /*上移*/
      moveUpThisQues: function (pid, tid) {
        app.moveUp(pid, tid);
      },
      /*删除*/
      delThisQues: function (pid, tid) {
        app.delQuesType(pid, tid);
      },
      // 获取数据中最大值
      getMaxNumber: function (i, obj, attr) {
        if (i == 0) {
          return obj[0][attr];
        }
        if (i > 0) {
          return Math.max(obj[i - 1][attr], obj[i][attr])
        }
      },
      showAlertEditQuesTitle: function (pid, tid) {
        Bus.$emit("showAlertEditQuesTitle", pid, tid);
        app.alert.state_alertEditQuesTitle = true
      }
    }
  }
</script>

ques-desc
