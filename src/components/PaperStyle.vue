<template>
    <div class="tablayout" id="tablayout-1">
        <div class="box-warp" v-bind:class="{'box-a4':layout.style==null || layout.style=='A4','box-a3':layout.style=='A3'}">
            <!--=====================切割标记=====================-->
            <ul class="black-box">
                <li class="black-mark mark1">
                    <span class="triangle"></span>
                    <span class="square"></span>
                </li>
                <li class="black-mark mark2">
                    <span class="square"></span>
                    <span class="triangle"></span>
                </li>
                <li class="black-mark mark3">
                    <span class="triangle"></span>
                    <span class="square"></span>
                </li>
                <li class="black-mark mark4">
                    <span class="square"></span>
                    <span class="triangle"></span>
                </li>
            </ul>
            <!--=====================切割标记=====================-->

            <div class="con-height">
                <!--=====================头部信息=====================-->
                <main-top :title="title"></main-top>
                <!--=====================头部信息=====================-->

                <!--=====================考试信息=====================-->
                <exam-info-a4
                        :data="data"
                        :care="care"
                        :type="type"
                        v-if="layout.style=='A4'"></exam-info-a4>
                <exam-info-a3
                        :data="data"
                        :care="care"
                        :type="type"
                        v-if="layout.style=='A3'"></exam-info-a3>
                <!--=====================考试信息=====================-->

                <!--====================================================================================================
                ================================================分卷====================================================
                ====================================================================================================-->
                <div class="part-wrap">

                    <template v-for="(partItem,partItemIndex) in examPart">

                        <!--<template v-if="partItem && partItemIndex==0">-->
                            <!--<p class="text-muted center part-box" style="padding:100px 0;margin-top:8px;">尚未添加试题</p>-->
                        <!--</template>-->

                        <template v-if="partItem.list.length>0">
                            <!--分卷标题设置============-->
                            <div class="part-title center red hover">
                                <div class="part-menu">
                                    <a href="javascript:;" class="btn"
                                       @click="showAlertEditPartTitle(partItemIndex)">
                                        <i class="iconfont">&#xe601;</i>编辑
                                    </a>
                                </div>
                                <p class="partname1">{{partItem.title}}&nbsp;<small>{{partItem.desc}}</small></p>
                            </div>
                            <!--分卷标题设置-END============-->

                            <!--class fillin-->  <!--height-max a3高度  height-max-->

                            <div class="part-box">

                                <div v-for="(typeItem,typeItemIndex) in partItem.list">


                                    <!--=====================客观题=====================-->
                                    <!--typeItem.type==0-->
                                    <div class="choice hover ques-type ques-type0"
                                         v-bind:id="'ques-anchor'+partItemIndex+'-'+typeItemIndex"
                                         v-if="typeItem.type==0 && typeItem.content.length>0">
                                        <div class="part-menu">
                                            <a href="javascript:;" class="btn"
                                               @click="showAlertXuanzeti(partItemIndex,typeItemIndex)">
                                                <i class="iconfont">&#xe602;</i>添加
                                            </a>
                                            <a href="javascript:;" class="btn"
                                               @click="changeTypeItemStyle(partItemIndex,typeItemIndex)">
                                                <i class="iconfont">&#xe60b;</i>切换版式
                                            </a>
                                            <!-- <link rel="import" href="/app/card/view/include/ques-handle-btn-group-normal.tpl?__inline"> -->
                                        </div>
                                        <div class="q-choice clearfix">

                                            <!--选择题块模版-->
                                            <!--分组显示 每组不超过5个-->
                                            <div class="choice-item"
                                                 v-for="(itemBlock,itemBlockIndex) in Math.ceil(typeItem.content.length/5)"
                                                 v-bind:class="(typeItem.style==1?'vertical-choice':'')">

                                                <!--只显示当前分组-->
                                                <div v-for="(itemTr,itemTrIndex) in typeItem.content"
                                                     class="order-item" v-if="(itemTrIndex+1)>(itemBlockIndex*5) && (itemTrIndex+1) <= ((itemBlockIndex+1)*5)"
                                                     v-bind:card-ques-id="itemTr.order+'.'+itemTr.small">
                                                    <span class="item-number">{{itemTr.order}}</span>

                                                    <!--大写字母-->
                                                    <template v-if="itemTr.style==1">
                                                        <span v-for="(itemTd,indexId) in itemTr.num-0"
                                                              class="item-option">[<b class="pad4">{{quesTemp.choice[indexId]}}</b>]</span>
                                                    </template>

                                                    <!--小写字母-->
                                                    <template v-if="itemTr.style==2">
                                                        <span  v-for="(itemTd,indexId) in itemTr.num-0" class="item-option">[<b class="pad4">{{quesTemp.choice[indexId].toLowerCase()}}</b>]</span>
                                                    </template>

                                                    <!--判断题-->
                                                    <template v-if="itemTr.style==3" >
                                                        <span v-for="(itemTd,indexId) in 2"
                                                              class="item-option">[<b class="pad4">{{quesTemp.trueFalse[indexId]}}</b>]</span>
                                                    </template>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!--=====================客观题-END=====================-->



                                    <!--=========================解答题模版==========================-->
                                    <div class="ques-type ques-type1"
                                         v-bind:id="'ques-anchor'+partItemIndex+'-'+typeItemIndex"
                                         v-if="typeItem.type==1 && typeItem.content.length>0">
                                        <div class="question explain hover">
                                            <div class="part-menu">
                                                <a href="javascript:"
                                                   class="btn"
                                                   v-on:click="showAlertEditQuesTitle(partItemIndex,typeItemIndex)">
                                                    <i class="iconfont">&#xe601;</i>编辑
                                                </a>
                                                <a href="javascript:"
                                                   class="btn"
                                                   v-on:click="showAlertJiedati(partItemIndex,typeItemIndex)">
                                                    <i class="iconfont">&#xe602;</i>添加
                                                </a>
                                                <a href="javascript:"
                                                   class="btn"
                                                   v-on:click="delThisQues(partItemIndex,typeItemIndex)">
                                                    <i class="iconfont">&#xe600;</i>删除
                                                </a>
                                                <a v-show="typeItemIndex != partItem.list.length-1"
                                                   href="javascript:"
                                                   class="btn"
                                                   v-on:click="moveDownThisQues(partItemIndex,typeItemIndex)">
                                                    <i class="iconfont">&#xe605;</i>下移
                                                </a>
                                                <a v-show="typeItemIndex !=0"
                                                   href="javascript:"
                                                   class="btn"
                                                   v-on:click="moveUpThisQues(partItemIndex,typeItemIndex)">
                                                    <i class="iconfont">&#xe604;</i>上移
                                                </a>
                                            </div>


                                            <!-- <link rel="import" href="/app/card/view/include/ques-content-handle-btn-group.tpl?__inline"> -->
                                            <div class="q-title">
                                                <ques-title-info v-bind:item="typeItem"></ques-title-info>
                                            </div>
                                            <div class="q-content">
                                                <div class="jd-kong-list clearfix">
                                                    <jd-kong-template
                                                            v-for="(contentItem , subOrderID) in typeItem.content"
                                                            v-bind:itemLength="typeItem.content.length"
                                                            v-bind:score="score"
                                                            v-bind:contentItem="contentItem"
                                                            v-bind:partItemIndex="partItemIndex"
                                                            v-bind:typeItemIndex="typeItemIndex"
                                                            v-bind:subOrderID="subOrderID"
                                                    ></jd-kong-template>
                                                </div>
                                            </div>
                                        </div>
                                    </div>


                                    <!--解答题模版-END-->


                                    <!--选答题模版-->
                                    <template v-if="typeItem.type==2 && typeItem.content.length>0">
                                        <xuandati-template
                                                v-bind:dataState="dataState"
                                                v-bind:score="score"
                                                v-bind:partItem="partItem"
                                                v-bind:partItemIndex="partItemIndex"
                                                v-bind:typeItemIndex="typeItemIndex"
                                                v-bind:typeItem="typeItem">
                                        </xuandati-template>
                                    </template>
                                    <!--选答题模版-END-->


                                    <!-- 语文作文 -->
                                    <template v-if="typeItem.type==3 && typeItem.content.length>0">
                                        <div class="question ques-type composition hover"
                                             v-bind:id="'ques-anchor'+partItemIndex+'-'+typeItemIndex">
                                            <div class="part-menu">
                                                <a href="javascript:;" class="btn" @click="showAlertEditCnZuowen(partItemIndex,typeItemIndex)">
                                                    <i class="iconfont">&#xe601;</i>编辑
                                                </a>
                                                <!-- <link rel="import" href="/app/card/view/include/ques-handle-btn-group-normal.tpl?__inline"> -->
                                            </div>
                                            <div class="q-title">
                                                <ques-title-info v-bind:item="typeItem"></ques-title-info>
                                            </div>
                                            <div class="q-content">

                                                <div class="content-list">
                                                    <template v-for="(contentItem , subOrderID) in typeItem.content">
                                                        <span class="number" v-bind:card-ques-id="contentItem.order">{{contentItem.order}}.
                                                            <em class="score" v-if="score.display == 1">({{contentItem.score}}分)</em>
                                                        </span>
                                                        <div class="com-title center">题目：________________________________________</div>
                                                        <div class="com-grid clearfix">
                                                            <span v-for="(charItem,charItemIndex) in Math.floor((contentItem.char-0)*(1.3))">
                                                                <em class="tips"
                                                                    v-if="((charItemIndex+1)==contentItem.char ||
                                                                    (charItemIndex+1)==contentItem.char-100 ||
                                                                    (charItemIndex+1)==contentItem.char+100)">{{charItemIndex+1}}</em>
                                                            </span>
                                                            <!--A4版格数补整行-->
                                                            <template v-if="(Math.floor((contentItem.char-0)*(1.3)))%24 !== 0 && layout.style=='A4'">
                                                                <span v-for="charItem1 in (24-(Math.floor((contentItem.char-0)*(1.3)))%24)"></span>
                                                            </template>
                                                            <!--A3版格数补整行-->
                                                            <template v-if="(Math.floor((contentItem.char-0)*(1.3)))%16 !== 0 && layout.style=='A3'">
                                                                <span v-for="charItem1 in (16-(Math.floor((contentItem.char-0)*(1.3)))%16)"></span>
                                                            </template>
                                                        </div>

                                                    </template>
                                                </div>
                                                <!-- 禁止作答区 -->
                                                <!--<div class="no-writing" v-if="noWritable.display">禁止作答区</div>-->
                                            </div>
                                        </div>
                                    </template>
                                    <!--语文作文-END-->


                                    <!--英语作文-->
                                    <template v-if="typeItem.type==4 && typeItem.content.length>0">
                                        <div class="question writing-En ques-type hover"
                                             v-bind:id="'ques-anchor'+partItemIndex+'-'+typeItemIndex">
                                            <div class="part-menu">
                                                <!--<a href="javascript:;" class="btn" @click="showAlertEnZuowen">-->
                                                <!--<i class="iconfont">&#xe602;</i>添加-->
                                                <!--</a>-->
                                                <a href="javascript:;" class="btn" @click="showAlertEditEnZuowen(partItemIndex,typeItemIndex)">
                                                    <i class="iconfont">&#xe601;</i>编辑
                                                </a>
                                              <btn-group-normal v-bind:partItem="partItem"
                                                                v-bind:partItemIndex="typeItemIndex"
                                                                v-bind:partItemIndex="partItemIndex"></btn-group-normal>
                                                <!--<link rel="import" href="/app/card/view/include/ques-handle-btn-group-normal.tpl?__inline">-->
                                            </div>
                                            <div class="q-title">
                                                <ques-title-info v-bind:item="typeItem"></ques-title-info>
                                            </div>
                                            <div class="q-content">
                                                <div class="content-list clearfix">
                                                    <template v-for="(contentItem , contentItemIndex) in typeItem.content">
                                                        <span class="number left" v-bind:card-ques-id="contentItem.order">
                                                            {{contentItem.order}}.
                                                            <em class="score" v-if="score.display==1">({{contentItem.score}}分)</em>
                                                        </span>
                                                        <!--<span class="widthF textarea">-->
                                                        <!--<p>-->
                                                        <!--</p>-->
                                                        <!--</span>-->
                                                        <span class="line widthF left"
                                                              v-bind:style="{'borderBottom':(contentItem.uline==1?'1px solid #333':'none')}"
                                                              v-for="lineItem in (contentItem.hline-0)">
                                                        </span>
                                                        <!--<span class="widthF textarea"><textarea>Yours,<br/>Li Hua</textarea></span>-->
                                                    </template>

                                                </div>
                                            </div>
                                        </div>
                                    </template>
                                    <!--英语作文-END-->
                                </div>
                            </div>


                        </template>
                    </template>




                    <div class="part-tips center red">请在各题目答题区域作答，超出黑色矩形边框限定区域答题无效</div>
                </div>
                <!--====================================================================================================
                ================================================分卷====================================================
                ====================================================================================================-->
                <!--<div class="page red center"></div>-->
            </div>
        </div>
    </div>
</template>

<script>

import MainTop  from "./main/MainTop.vue"
import ExamInfoA3  from "./main/ExamInfoA3.vue"
import ExamInfoA4  from "./main/ExamInfoA4.vue"
import JdKongTemplate  from "./JdKongTemplate.vue"
import XuandatiTemplate  from "./XuandatiTemplate.vue"
import QuesTitleInfo  from "./QuesTitleInfo.vue"

import BtnGroupNormal  from "./QuesHandleBtnGroupNormal.vue"

export default {
    name:"paper-style",

    components:{
        ExamInfoA3,
        ExamInfoA4,
        MainTop,
        JdKongTemplate,
        XuandatiTemplate,
        QuesTitleInfo,
        BtnGroupNormal
    },
    props: [
        "dataState",
        "layout",
        "data",
        "care",
        "title",
        "type",
        "examPart",
        "modal",
        "score"
    ],
    data: function () {
        return {
            hlineHeight: 48,
            quesTemp: {
                choice: ["A", "B", "C", "D", "E", "F", "G"],
                trueFalse: ["√", "x"]
            },
            autoOrderChoice: false,
            saveOldOrderID: []
        }
    },
    methods: {
        /*切换选择题版式*/
        changeTypeItemStyle: function (i, j) {
            var style = app.data.paper[i].list[j].style;
            if (style == 0) {
                app.data.paper[i].list[j].style = 1;
            } else {
                app.data.paper[i].list[j].style = 0;
            }
            app.dataState += 1;
        },
        /*编辑分卷标题*/
        showAlertEditPartTitle: function () {
            app.alert.state_alertPartInfo = true;
        },
        /*编辑标题*/
        showAlertEditQuesTitle: function (pid, tid) {
            Bus.$emit("showAlertEditQuesTitle", pid, tid);
            app.alert.state_alertEditQuesTitle = true
        },
        /*添加选择题*/
        showAlertXuanzeti: function (i, j) {
            Bus.$emit("showAlertXuanzeti", {part: i, block: j});
            app.alert.state_alertXuanzeti = true
        },
        /*添加填空题*/
        showAlertTiankongti: function (i,j) {
            Bus.$emit("showAlertTiankongti",{part: i, block: j});
            app.alert.state_alertTiankongti = true
        },
        /*添加解答题*/
        showAlertJiedati: function (i,j) {
            Bus.$emit("showAlertJiedati",{part: i, block: j});
            app.alert.state_alertJiedati = true
        },
        /*添加英语作文*/
        showAlertEditEnZuowen: function (pid, tid) {
            Bus.$emit("showAlertEditEnZuowen", pid, tid);
            app.alert.state_alertEnZuowen = true
        },
        /*添加语文作文*/
        showAlertEditCnZuowen: function (pid, tid) {
            Bus.$emit("showAlertEditCnZuowen", pid, tid);
            app.alert.state_alertCnZuowen = true
        },
        /*下移*/
        moveDownThisQues: function (pid,tid) {
            app.moveDown(pid,tid);
        },
        /*上移*/
        moveUpThisQues: function (pid,tid) {
            app.moveUp(pid,tid);
        },
        /*删除*/
        delThisQues: function (pid,tid,oid) {
            app.delQuesType(pid,tid,oid);
        }
    }
}
</script>
