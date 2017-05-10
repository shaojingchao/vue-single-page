<template>
  <div class="panel-item btn-item">
    <a href="javascript:;" class="btn btn-defult" v-on:click="saveAnswerJson">保存</a>
    <!--<a href="javascript:;" class="btn btn-defult">预览</a>-->
    <a href="javascript:;" class="btn btn-primary" v-on:click="answerDown">下载</a>
    <div class="page-total" v-html="page"></div>
  </div>
</template>

<script>
  /*底部操作按钮*/

  export default {
    name: "side-btm-handle",
    props: ["page"],
    methods: {
      // 保存答题卡
      saveAnswerJson: function () {
        var params = {
          Json: JSON.stringify(app.data),
          SaveID: editData.getAttr(1) || 0
        };
        var layerSave = layer.load(1);
        $.post(U("Home/Index/saveAnswerJson"), params, function (data) {
          layer.close(layerSave);
          if (data.info === 'success') {
            layer.msg("保存成功！", {icon: 1, time: 1000, shade: 0.3})
          } else {
            layer.msg("保存失败！" + JSON.stringify(data.data), {icon: 2, time: 1000, shade: 0.3})
          }
        })
      },
      // 下载答题卡
      answerDown: function () {

        // 字符串答题卡数据
        var answerData = $.parseJSON(JSON.stringify(app.data));
        // 下载答题卡接口
        function answerDownFunc(data) {

          var answerload = layer.msg("正在生成答题卡，请稍候...", {time: 0});

          var params = {
            sheetxml: JSON.stringify(data)
          };
          // 创建div接收程序返回js代码
          function createDiv(data) {
            $("body").append("<div id='dtktishi'></div>" + data);
          }

          $.post(U("Home/Index/arswerMyDown"), params, function (data) {

            layer.close(answerload);
            //错误提示
            if (typeof data.data === 'string') {
              createDiv(data.data);
              layer.alert($("#dtktishi").find("b").removeAttr("style").html(), {
                icon: 5
              })
            }
            //获取成功
            if (typeof data.data === 'object') {
              createDiv(data.data);
              layer.alert($("#dtktishi").html(), {
                icon: 6
              });
              setTimeout(function () {
                window.open($("#dtktishi").find("a").attr("href"));
              }, 500)
            }
          });
        };
        // AB卷切换
        function toggleABPaper(type, data) {
          var ansPaper = data.paper;
          $.each(ansPaper, function (i) {
            var ansList = ansPaper[i].list;
            $.each(ansList, function (j) {
              if (ansList[j].type == 0) {//是客观题
                if (type == "B") {
                  if (ansList[j].style == 1) {
                    ansList[j].style = 0;
                  } else {
                    ansList[j].style = 1;
                  }
                }
              }
            });
          });
          answerDownFunc(data);
        }

        // 获取答题卡版式，如果是AB卷弹出AB卷选择框，否则下载统一版式
        if (editData.getAttr(2) == '2') {
          layer.open({
            type: 0,
            icon: 0,
            content: "请选择AB卷！",
            area: ["240px", "160px"],
            btn: ["A卷", "B卷"],
            btn1: function () {
              toggleABPaper("A", answerData);
            },
            btn2: function () {
              toggleABPaper("B", answerData);
            }
          });
        } else {
          answerDownFunc(answerData);
        }
      }
    }
  }
</script>
