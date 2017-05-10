<script type="text/html" id="tpl-paper-style">
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
                                            <link rel="import" href="/app/card/view/include/ques-handle-btn-group-normal.tpl?__inline">
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
                                            <link rel="import" href="/app/card/view/include/ques-content-handle-btn-group.tpl?__inline">
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
                                                <link rel="import" href="/app/card/view/include/ques-handle-btn-group-normal.tpl?__inline">
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
                                                <link rel="import" href="/app/card/view/include/ques-handle-btn-group-normal.tpl?__inline">
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
</script>

<!--解答题-->
<script type="text/html" id="tpl-jd-kong-template">

    <div class="jd-kong-list-item">
        <template v-if="!isENError">
            <div class="jd-hang-item clearfix"
                 v-on:mouseenter="hoverThisQues(1)"
                 v-on:mouseleave="hoverThisQues(0)"
                 v-bind:class="{'jd-hang-p10':isQuesBlock,'jd-hang-npb':isContentLastQuesBlock}"
                 v-bind:card-ques-id="cardQuesId">
                <link rel="import" href="/app/card/view/include/ques-handle-btn-group.tpl?__inline">

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
                        <span>{{contentItem.order}}.<span v-if="score.display==1"> ({{contentItem.score}}分)</span></span>
                    </em>
                    <em class="jd-sub" v-if="isSmall">({{contentItem.small}})</em>

                    <ques-desc v-bind:contentItem="contentItem"></ques-desc>

                    <link rel="import" href="/app/card/view/include/ques-tpl-img-list.tpl?__inline">

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

</script>
<!--解答题-END-->


<!--选答题-->
<sctipt type="text/html" id="tpl-xuandati-template">
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
                            <span class="jd-kong-item hang-1-1 hang-has-img no-line"
                                  v-if="isHasImg"
                                  v-bind:style="{minHeight:hlineHeight*computedKong+'px'}">
                                <span class="jd-img-list big-block">
                                    <span class="img-item"
                                          v-for="imgItem in newType2.content.img">
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
</sctipt>