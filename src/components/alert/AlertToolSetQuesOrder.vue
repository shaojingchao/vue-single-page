<template>
  <span v-show="selectedAddedTestNum==1" class="unselect" style="vertical-align:-1px">
        <label>
            <input type="checkbox"
               style="vertical-align:-2px"
               v-model="toggleSetOrderID"
               v-bind:disabled="selectedAddedTestNum>1">设置题号
        </label>
        <span class="f12 text-muted" v-if="toggleSetOrderID">
            <input id="userSetOrderID" class="w5em center" type="number"
                   v-bind:value="computedOrderID"
               v-on:change="checkSetterOrderID">
            <a href="javascript:;" class="text-primary"
               v-on:mouseleave="hideSuggestOrderID"
               v-on:mouseenter="showSuggestOrderID"> 提示
            </a>
        </span>
    </span>
</template>

<script>
  /*========
 添加试题时自定义题号
 1. 激活题号设置功能
 2. 用户手动输入题号
 3. 输入同时检查题号合法性
 4. 合法即设置题号 否则不设置
 ========*/

 export default {
  name:"set-ques-order",
  data: function () {
        return {
            suggestOrderID: '',//题号设置建议
            setterOrder: '',//题号设置建议
            layerTips: '',//题号设置建议tips
            toggleSetOrderID: false//手动设置是否激活
        }
    },

    props: ["selectedAddedTestNum"],
    computed: {
        computedOrderID: function () {
            return this.suggestOrderID || app.examOrderIDArray.max + 1;
        }
    },

    watch: {
        //传递题号设置激活状态
        "toggleSetOrderID": function () {
            Bus.$emit("toggleSetOrderID", this.toggleSetOrderID);
        }
    },

    methods: {
        // 题号设置建议
        showSuggestOrderID: function (e) {
            var thisTarget = e.target,
                examOrderID = app.examOrderIDArray,
                min = examOrderID.min,
                max = examOrderID.max,
                sugMsg = '';
            if (max == 0) {
                sugMsg += "还没有添加试题哦！"
            }
            if (0 < max) {
                if (!examOrderID.outOrder.length) {
                    sugMsg += '当前题号为：' + min + '-' + max + '！'
                } else {
                    sugMsg += "当前题号" + min + '-' + max + '中，';
                    sugMsg += '未使用的题号有：\n [ ' + (examOrderID.outOrder.join(", ")) + ' ].';
                }
            }
            this.layerTips = layer.tips(sugMsg, thisTarget, {
                tips: [1, '#3595CC'],
                time: 0
            });
        },
        // 隐藏提示信息
        hideSuggestOrderID: function () {
            layer.close(this.layerTips)
        },
        // 检查输入值合法性
        checkSetterOrderID: function (e) {
            var _this = this;
            var $currTarget = $(e.target);
            var setterOrder = $.trim($currTarget.val()) - 0;
            if (setterOrder > 0) {
                // 设置的试序号是否在试题序号数组中
                if ($.inArray(setterOrder, app.examOrderIDArray.order) !== -1) {
                    $currTarget.attr("able", 0);
                    $currTarget.val(_this.suggestOrderID);
                    layer.msg("试题序号<b> " + setterOrder + " </b>已存在 !", {time: 1500})
                    return
                }
                $currTarget.attr("able", 1);
                _this.suggestOrderID = setterOrder;
                $currTarget.val(_this.suggestOrderID);
                Bus.$emit("sendSetterOrderID", setterOrder);
            } else {
                $currTarget.val(_this.suggestOrderID);
                layer.msg("试题序号只能是大于 0 的数字！", {time: 2500});
            }
        }
    }
 }
</script>

