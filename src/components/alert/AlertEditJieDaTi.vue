<template>
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
</template>
<script>
    // 图片上传组件 Webuploader
jQuery.uploader = {
    uploader: {},
    createUploader: function () {
        return WebUploader.create({
            pick: {
                id: '#filePicker',
                label: '点击选择图片'
            },
            dnd: '#uploader .queueList',
            compress: {
                width: 180,
                height: 180,
                quality: 100
            },
            paste: document.body,
            // 文件类型
            accept: {
                title: 'Images',
                extensions: 'jpg,jpeg,gif,png',
                mimeTypes: 'image/jpg,image/jpeg,image/gif,image/png'
            },
            // swf文件路径
            swf: '__PUBLIC__/plugin/webuploader/js/Uploader.swf',
            disableGlobalDnd: true,
            chunked: true,
            server: '/Home/Index/upload.html?dir=bbs&action=uploadimage',
            fileNumLimit: 1, //文件数量
            fileSizeLimit: 2 * 1024 * 1024,    // 2 M
            fileSingleSizeLimit: 2 * 1024 * 1024    // 2 M
        })
    },
    percentages: {}, // 所有文件的进度信息，key为file id
    state:"pedding",// 可能有pedding, ready, uploading, confirm, done.
    init: function (imgList,uploadSuccess) {

        var _this = this;

        $("#uploader").ready(function () {

            // 实例化
            _this.uploader = _this.createUploader();

            if (!WebUploader.Uploader.support()) {
                alert('Web Uploader 不支持您的浏览器！如果你使用的是IE浏览器，请尝试升级 flash 播放器');
                throw new Error('WebUploader does not support the browser you are using.');
            }

            var $wrap = $('#uploader'), // 图片容器
                $queue = $('<ul class="filelist"></ul>').appendTo($wrap.find('.queueList')),
                $statusBar = $wrap.find('.statusBar'), // 状态栏，包括进度和控制按钮
                $info = $statusBar.find('.info'), // 文件总体选择信息。
                $upload = $wrap.find('.uploadBtn'), // 上传按钮
                $placeHolder = $wrap.find('.placeholder'), // 没选择文件之前的内容。
                $progress = $statusBar.find('.progress').hide(), // 总体进度条
                fileCount = 0, // 添加的文件数量
                fileSize = 0, // 添加的文件总大小
                state = _this.state;


            WebUploader.Uploader.register({
                'before-send-file': 'doSomthingAsync'
            }, {

                doSomthingAsync: function () {
                }
            });


            // 配置显示尺寸
            $("#uploadImgSize").on("change",function () {
                var compressSize = ~~$(this).val();
                _this.uploader.option("compress", {
                    width: compressSize,
                    height: compressSize,
                    quality: 100
                });
            });


            // 添加“添加文件”的按钮，
            _this.uploader.addButton({
                id: '#filePicker2',
                label: '继续添加'
            });

            // 更新进度
            function updateTotalProgress() {
                var loaded = 0,
                    total = 0,
                    spans = $progress.children(),
                    percent;

                $.each(_this.percentages, function (k, v) {
                    total += v[0];
                    loaded += v[0] * v[1];
                });

                percent = total ? loaded / total : 0;

                spans.eq(0).text(Math.round(percent * 100) + '%');
                spans.eq(1).css('width', Math.round(percent * 100) + '%');
                _this.updateStatus(fileCount, fileSize, $info);
            }

            // 设置状态
            function setState(val) {
                var stats;

                if (val === state) {
                    return;
                }

                $upload.removeClass('state-' + state);
                $upload.addClass('state-' + val);
                state = val;

                switch (state) {
                    case 'pedding':
                        $placeHolder.removeClass('element-invisible');
                        $queue.parent().removeClass('filled');
                        $queue.hide();
                        $statusBar.addClass('element-invisible');
                        _this.uploader.refresh();
                        break;

                    case 'ready':
                        $placeHolder.addClass('element-invisible');
                        $('#filePicker2').removeClass('element-invisible');
                        $queue.parent().addClass('filled');
                        $queue.show();
                        $statusBar.removeClass('element-invisible');
                        _this.uploader.refresh();
                        break;

                    case 'uploading':
                        $('#filePicker2').addClass('element-invisible');
                        $progress.show();
                        $upload.text('暂停上传');
                        break;

                    case 'paused':
                        $progress.show();
                        $upload.text('继续上传');
                        break;

                    case 'confirm':
                        $progress.hide();
                        $upload.text('开始上传').addClass('disabled');

                        stats = _this.uploader.getStats();
                        if (stats.successNum && !stats.uploadFailNum) {
                            setState('finish');
                            return;
                        }
                        break;
                    case 'finish':
                        stats = _this.uploader.getStats();
                        if (stats.successNum) {
                            // alert('上传成功');
                        } else {
                            // 没有成功的图片，重设
                            state = 'done';
                            location.reload();
                        }
                        break;
                }

                _this.updateStatus(fileCount, fileSize, $info);
            }

            _this.uploader.onUploadProgress = function (file, percentage) {
                var $li = $('#' + file.id),
                    $percent = $li.find('.progress span');

                $percent.css('width', percentage * 100 + '%');
                _this.percentages[file.id][1] = percentage;
                updateTotalProgress();
            };

            _this.uploader.onFileQueued = function (file) {
                fileCount++;
                fileSize += file.size;

                if (fileCount === 1) {
                    $placeHolder.addClass('element-invisible');
                    $("#uploadImgSize").prop("disabled",true);
                    $statusBar.show();
                }

                var $addFilesHtml = _this.addFiles(file);

                $queue.append($addFilesHtml);
                setState('ready');
                updateTotalProgress();
                $upload.click();

            };

            _this.uploader.onFileDequeued = function (file) {
                fileCount--;
                fileSize -= file.size;

                if (!fileCount) {
                    setState('pedding');
                }
                _this.removeFiles(file);
                updateTotalProgress();

            };

            _this.uploader.on('all', function (type) {
                var stats;
                switch (type) {
                    case 'uploadFinished':
                        setState('confirm');
                        break;

                    case 'startUpload':
                        setState('uploading');
                        break;

                    case 'stopUpload':
                        setState('paused');
                        break;
                }
            });
            // 上传完成 添加新图片路径
            _this.uploader.onUploadSuccess = function (file, res) {
                if (res.state == "SUCCESS") {
                    imgList.push([res.url]);
                    uploadSuccess && uploadSuccess();
                }
            };

            // 错误
            _this.uploader.onError = function (code) {
                switch (code) {
                    case 'Q_EXCEED_NUM_LIMIT':
                        alert("文件数量超过最大值，最多一次添加3个");
                        break;

                    case 'Q_EXCEED_SIZE_LIMIT':
                        alert("文件总大小超过限制，最高为 2M");
                        break;

                    case 'Q_TYPE_DENIED':
                        alert("请选择图片文件，可用文件类型jpg,jpeg,png");
                        break;
                }
            };

            // 上传
            $upload.on('click', function () {
                if ($(this).hasClass('disabled')) {
                    return false;
                }
                if (state === 'ready') {
                    _this.uploader.upload();
                } else if (state === 'paused') {
                    _this.uploader.upload();
                } else if (state === 'uploading') {
                    _this.uploader.stop();
                }
            });

            // 重试
            $info.on('click', '.retry', function () {
                _this.uploader.retry();
            });

            // 忽略
            $info.on('click', '.ignore', function () {
                alert('todo');
            });

            $upload.addClass('state-' + state);
            updateTotalProgress();
        })

    },
    //检查是否支持transition
    isSupportTransition: (function () {
        var s = document.createElement('p').style,
            r = 'transition' in s ||
                'WebkitTransition' in s ||
                'MozTransition' in s ||
                'msTransition' in s ||
                'OTransition' in s;
        s = null;
        return r;
    }()),

    //显示错误信息
    showError: function (code) {
        var text = '';
        switch (code) {
            case 'exceed_size':
                text = '文件大小超出';
                break;

            case 'interrupt':
                text = '上传暂停';
                break;

            default:
                text = '上传失败，请重试';
                break;
        }
        return text;
    },

    // 当有文件添加进来时执行，负责view的创建
    addFiles: function (file) {
        var _this = this,
            ratio = window.devicePixelRatio || 1, // 优化retina, 在retina下这个值是2
            thumbnailWidth = 110 * ratio, // 缩略图大小
            thumbnailHeight = 110 * ratio;

        var $li = $('<li id="' + file.id + '">' +
                '<p class="title">' + file.name + '</p>' +
                '<p class="imgWrap"></p>' +
                '<p class="progress"><span></span></p>' +
                '</li>'),

            $btns = $('<div class="file-panel">' +
                '<span class="cancel">删除</span>' +
                '<span class="rotateRight">向右旋转</span>' +
                '<span class="rotateLeft">向左旋转</span></div>').appendTo($li),
            $prgress = $li.find('p.progress span'),
            $wrap = $li.find('p.imgWrap'),
            $info = $('<p class="error"></p>');

        if (file.getStatus() === 'invalid') {
            $info.text(_this.showError(file.statusText)).appendTo($li);
        } else {

            // @todo lazyload
            $wrap.text('预览中');
            _this.uploader.makeThumb(file, function (error, src) {
                if (error) {
                    $wrap.text('不能预览');
                    return;
                }

                var img = $('<img src="' + src + '">');
                $wrap.empty().append(img);
            }, thumbnailWidth, thumbnailHeight);

            _this.percentages[file.id] = [file.size, 0];
            file.rotation = 0;
        }

        file.on('statuschange', function (cur, prev) {
            if (prev === 'progress') {
                $prgress.hide().width(0);
            } else if (prev === 'queued') {
                $li.off('mouseenter mouseleave');
                $btns.remove();
            }
            // 成功
            if (cur === 'error' || cur === 'invalid') {
                $info.text(_this.showError(file.statusText)).appendTo($li);
                _this.percentages[file.id][1] = 1;
            } else if (cur === 'interrupt') {
                $info.text(_this.showError('interrupt')).appendTo($li);
            } else if (cur === 'queued') {
                _this.percentages[file.id][1] = 0;
            } else if (cur === 'progress') {
                $info.remove();
                $prgress.css('display', 'block');
            } else if (cur === 'complete') {
                $li.append('<span class="success"></span>');
            }

            $li.removeClass('state-' + prev).addClass('state-' + cur);
        });

        $li.on('mouseenter', function () {
            $btns.stop().animate({height: 30});
        });

        $li.on('mouseleave', function () {
            $btns.stop().animate({height: 0});
        });

        $btns.on('click', 'span', function () {
            var index = $(this).index(),
                deg;

            switch (index) {
                case 0:
                    _this.uploader.removeFile(file);
                    return;

                case 1:
                    file.rotation += 90;
                    break;

                case 2:
                    file.rotation -= 90;
                    break;
            }
            if (_this.isSupportTransition) {
                deg = 'rotate(' + file.rotation + 'deg)';
                $wrap.css({
                    '-webkit-transform': deg,
                    '-mos-transform': deg,
                    '-o-transform': deg,
                    'transform': deg
                });
            } else {
                $wrap.css('filter', 'progid:DXImageTransform.Microsoft.BasicImage(rotation=' + (~~((file.rotation / 90) % 4 + 4) % 4) + ')');
            }
        });

        return $li;
    },

    // 负责view的销毁
    removeFiles: function (file) {
        delete this.percentages[file.id];
        $('#' + file.id).off().find('.file-panel').off().end().remove();
    },
    updateStatus: function (fileCount, fileSize, $info) {

        var text = '', stats, _this = this;

        if (_this.state === 'ready') {
            text = '选中' + fileCount + '张图片，共' + WebUploader.formatSize(fileSize) + '。';
        }
        else if (_this.state === 'confirm') {
            stats = _this.uploader.getStats();
            if (stats.uploadFailNum) {
                text = '已成功上传' + stats.successNum + '张图片，' +
                    stats.uploadFailNum + '张图片上传失败，<a class="retry" href="#">重新上传</a>失败图片或<a class="ignore" href="#">忽略</a>'
            }
        }
        else {
            stats = _this.uploader.getStats();
            text = '共' + fileCount + '张（' +
                WebUploader.formatSize(fileSize) +
                '），已上传' + stats.successNum + '张';

            if (stats.uploadFailNum) {
                text += '，失败' + stats.uploadFailNum + '张';
            }
        }

        $info.html(text);

    }
};

import TestItem from "./AlertAddJieDaTi_testItem.vue"
import Modal from './Modal.vue';

export default {
    name:"alert-edit-jiedati",
    props: ["modal"],
    components:{TestItem,Modal},
    data: function () {
        return {
            editWhich: '',
            editDataCache: '',
            editData: {
                "order": '', "small": '', "uline": '', 'kong': '', 'hline': '', "score": '', 'desc': '',
                img: []
            }, //声明要编辑的试题数据
            isAddQuesDesc: 0,
            addedImgList: [],
            isAddQuesImg: '',
            addQuesImgBy: ''
        }
    },
    computed: {
        computedEditData: function () {
            return this.editDataCache;
        },
        /*短文改错题*/
        isENError: function () {
            return this.editDataCache.kong == 0 && this.editDataCache.hline == 0;
        }
    },
    created: function () {
        var _this = this;
        Bus.$on("showAlertEditJiedati", function (data) {
            _this.editWhich = data;

            // 解除数据绑定
            var saveQuesData = JSON.parse(JSON.stringify(_this.handleOldData(_this.editWhich)));

            // 对描述进行过滤
            // if (saveQuesData.desc && saveQuesData.desc.length > 0) {
            //     saveQuesData.desc = saveQuesData.desc.replace(/\<\/?\w+\>/gi, '');
            // }

            // 合并数据
            _this.editDataCache = $.extend({}, _this.editData, saveQuesData);
        });
    },

    methods: {

        // 获取原数据
        handleOldData: function (p, changeData) {
            // 如果有第二个参数修改数据
            if (changeData) {
                app.data.paper[p.pid].list[p.tid].content.splice(p.oid, 1, changeData);
                app.dataState++;
                return;
            }
            return app.data.paper[p.pid].list[p.tid].content[p.oid];
        },

        //根据试题序号获取试题ID题库
        tryGetTestID: function (order) {
            var id = null;
            try{
                id = editData.getTestIDByOrder(order)
            }
            catch(e){
                $.console.warn(e);
                id = editData.getTestIDByOrder()
            }
            return id;
        },

        // 添加图片到缓存
        pushImgToCache:function (List) {
            var _this = this;
            var computedEditData = _this.computedEditData;
            if (computedEditData.img && computedEditData.img !== undefined) {
                if ($.isArray(computedEditData.img)) {
                    _this.computedEditData.img = computedEditData.img.concat(List);//添加图片到缓存数据
                } else {
                    return false;
                }
            } else {
                _this.computedEditData.img = List;//添加图片到缓存数据
            }
        },

        // 选用试题图片
        selectServerImage: function () {
            var _this = this;
            _this.addedImgList = [];// 缓存图片

            // 获取题库图片参数
            var thisOrder = _this.editData.order;

            var params = {
                testID: _this.tryGetTestID(thisOrder)
            };

            var layerLoading = layer.load(2);
            $.get(U("/Home/Index/testImageChoose"), params, function (data) {
                layer.close(layerLoading);
                if (data.status === 1 && data.data && data.data.length > 0) {

                    // var imgList_demo = [
                    //     "/Public/default/image/answer/pic.jpg",
                    //     "/Public/default/image/answer/pic.jpg",
                    //     "/Public/default/image/answer/pic.jpg"
                    // ];

                    //弹出选择框
                    var layerindex = layer.open({
                        type: 0,
                        shift: 0,
                        area: ["700px", "500px"],
                        title: "请选择图片",
                        btn: ["确定", "取消"],
                        content: _this.outputImgList(data.data),//得到图片列表
                        yes: function () {
                            var imgSrc = $("#layer_serverImgList").find("li.selected").find("img").attr("src");
                            _this.addedImgList.push([imgSrc]);
                            _this.pushImgToCache(_this.addedImgList);
                            layer.close(layerindex);
                        },
                        success: function () {
                            //为图片绑定选择事件
                            $("#layer_serverImgList").on("click", "li", function () {
                                var $this = $(this);
                                $this.addClass("selected").siblings("li").removeClass("selected");
                            });
                        }
                    });

                } else {
                    layer.alert("抱歉，未找到相关试题图片！ <br>请使用其他添加方式！", {icon: 0})
                }
            });

        },

        // 将数据生成图片列表
        outputImgList: function (data) {
            var tmp = "<ul id='layer_serverImgList'>";
            for (var i = 0; i < data.length; i++) {
                tmp += "<li><div class='img-box'><img src=" + data[i] + "></div>";
            }
            tmp += "</ul>";
            return tmp;
        },

        //图片上传
        uploadThisImage: function () {
            var _this = this;
            _this.addedImgList = [];// 缓存图片
            var uploaderHtml = '<div id="uploader" class="wu-example">\
                                <div class="g-form" style="padding:20px 15px 0;">\
                                    最大显示尺寸：<select id="uploadImgSize">\
                                        <option value="100">100 * 100</option>\
                                        <option value="140">140 * 140</option>\
                                        <option value="180" selected>180 * 180</option>\
                                        <option value="220">220 * 220</option>\
                                        <option value="260">260 * 260</option>\
                                    </select>\
                                </div>\
                                <div class="queueList">\
                                    <div id="dndArea" class="placeholder">\
                                    <div id="filePicker"></div>\
                                    <p>或将照片拖到这里，单次最多可选1张</p>\
                                    </div>\
                                </div>\
                                <div class="statusBar" style="display:none;">\
                                        <div class="progress">\
                                        <span class="text">0%</span>\
                                        <span class="percentage"></span>\
                                        </div><div class="info"></div>\
                                        <div class="btns">\
                                        <div id="filePicker2"></div><div class="uploadBtn">开始上传</div>\
                                        </div>\
                                </div>\
                                <div id="cropper-wraper" style="display: none">\
                                <div id="cropper-img" style="width:100%;height:300px;border:2px solid #ddd;">\
                                    <img src="" alt="" />\
                                    </div>\
                                    <div class="clearfix">\
                                        <div id="img-preview" class="left" style="width:160px;height:160px;border:2px solid #ddd;margin-top:10px;"></div>\
                                    </div>\
                                </div>\
                            </div>';
            var layerUpImg = layer.open({
                type: 0,
                title: false,
                shift: -1,
                area: ["700px", "auto"],
                btn: ["确定", "取消"],
                content: uploaderHtml,
                success: function (layero) {
                    layero.find(".layui-layer-btn").css({"text-align": "center","opacity":0, "padding-bottom": "20px"});

                    // webuploaderReady
                    jQuery.uploader.init(_this.addedImgList,function(){
                        _this.pushImgToCache(_this.addedImgList);
                        app.updateDom();
                        layer.close(layerUpImg);
                        layer.msg("添加成功");
                    });
                }
            });
        },

        // 删除缓存图片
        delThisQuesImg: function (iid) {
            var _this = this;
            _this.computedEditData.img.splice(iid, 1);
            layer.msg('已删除！', {time: 1000});
        },
        yesBtn: function () {
            this.$forceUpdate();//组件数据初始化
            var _this = this;
            if(_this.isENError){
                _this.computedEditData.desc = $(".J_content-edit").html()
            }

            _this.handleOldData(_this.editWhich, _this.computedEditData);
            app.alert.state_alertEditJiedati = false
        },
        closeThisModal: function () {
            this.$forceUpdate();//组件数据初始化
            app.alert.state_alertEditJiedati = false
        }
    }
}
</script>
