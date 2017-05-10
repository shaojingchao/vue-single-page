<script type="text/html" id="tpl-alert-edit-jiedati">
    <modal v-show="modal.state_alertEditJiedati">
        <h3 slot="header">
            编辑试题：第{{computedEditData.order}}题
            <a href="javascript:" class="modal-close" v-on:click="closeThisModal">×</a>
        </h3>
        <div slot="body" class="lay-normal-box lay-edit-paper-info" style="width:560px">
            <div class="lay-set form" id="j_edit-this-ques">
                <div class="item-content">
                    <!--样式-->
                    <div class="itm-item" v-if="!isENError">
                        <span class="item-name">样式：</span>
                        <span class="type-select">
                            <label class="unselect radio-img no-line">
                                <input type="radio" role="uline" v-model="computedEditData.uline" name="has-underline" value="0">无横线
                            </label>
                            <label class="unselect radio-img on-line">
                                <input type="radio" role="uline" v-model="computedEditData.uline" name="has-underline" value="1">有横线
                            </label>
                        </span>
                        <span class="text-primary">（提示：‘有图片’或‘有描述’时横线将不显示）</span>
                    </div>

                    <!--分数-->
                    <div class="itm-item">
                        <span class="item-name">分数：</span>
                        <select class="w8em" role="score" v-model="computedEditData.score">
                            <option v-bind:value="optScore" v-for="optScore in 30">{{optScore}} 分</option>
                        </select>
                    </div>

                    <!--空行属性-->
                    <div class="itm-item" v-if="!isENError">
                        <span class="item-name">空行：</span>

                        <!--空-->
                        <select class="w8em" role="kong" v-model="computedEditData.kong">
                            <option v-bind:value="addKongNumItemIndex" v-for="(addKongNumItem,addKongNumItemIndex) in 11">{{addKongNumItemIndex}} 空</option>
                        </select>

                        <!--行-->
                        每空
                        <select class="w8em" role="hline" v-model="computedEditData.hline">
                            <option value="1">1 行</option>
                            <option value="0.5">1/2 行</option>
                            <option value="0.3">1/3 行</option>
                            <option v-for="(optItem,optItemIndex) in 30" v-bind:value="optItemIndex+2">{{optItemIndex+2}} 行
                            </option>
                        </select>
                    </div>

                    <!--添加图片-->
                    <div class="itm-item" v-if="!isENError">
                        <span class="item-name">图片：</span>
                        <div class="uploadImage">
                            <div class="j_imgList" v-if="computedEditData.img && computedEditData.img.length>0">
                                <span class="list-item-cell" v-for="(imgItem,imgItemIndex) in computedEditData.img">
                                    <span class="list-item">
                                        <img v-bind:src="imgItem[0]" v-bind:alt="imgItem[1]?imgItem[1]:('试题图片-'+imgItemIndex)">
                                        <a href="javascript:;" class="del-img" v-on:click="delThisQuesImg(imgItemIndex)" title="删除图片">×</a>
                                    </span>
                                </span>
                            </div>
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

                    <!--添加描述-->
                    <div class="itm-item" v-if="!isENError">
                        <span class="item-name">描述：</span>
                        <textarea class="w-full" role="desc" placeholder="描述~" v-model="computedEditData.desc"></textarea>
                        <p><strong>提示：</strong>添加换行请使用<span class="text-primary">"回车键"</span></p>
                    </div>



                    <div class="itm-item" v-if="isENError">
                        <span class="item-name">描述：</span>
                        <div class="J_content-edit" v-html="computedEditData.desc" contenteditable="true">

                        </div>
                        <!--<p><strong>提示：</strong>添加换行请使用<span class="text-primary">"回车键"</span></p>-->
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