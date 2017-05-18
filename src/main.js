//使用`import`命令加载的Vue构建版本
// 已经在webpack.base.conf中使用别名设置了//（仅运行时或独立）。

// import jQuery from 'jquery'
import _vue_data from './js/vueData.js'
import layer from '../bower_components/layer/build/layer.js'
import cookie from '../bower_components/jquery.cookie/jquery.cookie.js'
import Vue from 'vue'
import App from './App.vue'


console.log(layer);

// vue config
Vue.config.errorHandler = function (a, b, c) {
  console.log(a, b, c)
};
Vue.config.devtools = true;
Vue.config.silent = false;
Vue.config.keyCodes = {
  v: 86
}
console.log(_vue_data);

// Vue.config.productionTip = false


 // eslint-disable no-new

// if (!Object.create) {
//   alert("您的浏览器版本过低，\n 请更换更高版本的浏览器进行操作！");
//   $("#app").html('');
//   $(".is-old-ie").show();
// }


//扩展数组方法@去重
Array.prototype.unique = function () {
  var _this = this;
  _this.sort();
  var newArray = [_this[0]];
  for (var i = 1; i < _this.length; i++) {
    if (_this[i] !== newArray[newArray.length - 1]) {
      newArray.push(_this[i])
    }
  }
  return newArray;
};

$.extend({
  console: console
});


//组件间通信
window.Bus = new Vue();

window.app = new Vue({
  // el: '',
  template: '<App/>',
  data:_vue_data,
  components: { App },

  watch: {
    //dataState 数据状态标记，数据更改时执行 函数【setCardStorage】，自动更新 本地缓存数据【storageDATA】
    dataState: "setCardStorage"
  },
  // 项目实例创建完成过后执行
  created: function () {
    // 显示页面
    $("#answer-content").fadeIn();
    // 联考配置流程
    // jQuery.myRepeat.examProcess('#left-con', 2);
  },
  // html生成后执行
  mounted: function () {
    var _this = this;
    _this.updateCurrCardOrderIDArray();
    // _this.getSavedData();
    _this.windowCloseAlertInfo();
  },

  // 程序入口方法
  methods: {

    //关闭网页提示信息
    windowCloseAlertInfo: function () {
      window.onbeforeunload = function () {
        return false;
      };
    },

    // 缓存试题数据
    setCardStorage: function () {
      if (window.localStorage) {
        var localData = {
          subjectID: /*Cookie.Get("SubjectId")*/ 12,
          id: /*editData.getAttr(1)*/ 1,
          data: JSON.parse(JSON.stringify(this.data))
        };
        localStorage.setItem("cardDataStorage", JSON.stringify(localData));
      }
      var _this = this;
      setTimeout(function () {
        _this.computedPage = _this.computedPageHtml();
      }, 100);
      console.log('data updated!')
    },

    // 添加新试题
    addToListNewTypeItem: function (newType, index) {
      var _this = this;
      _this.data.paper[index].list.push(newType);
      layer.msg("添加成功！", {time: 1500});
      _this.updateDom();
      return true;
    },

    // 添加更多试题
    addToListNewContentItem: function (newItem, from) {
      var _this = this;
      var toPart = from.part,
        toBlock = from.block,
        content = _this.data.paper[toPart].list[toBlock].content;
      _this.data.paper[toPart].list[toBlock].content = content.concat(newItem);
      layer.msg("添加成功！", {time: 1500});
      _this.updateDom();
      return true;
    },

    /*移动*/
    quesTypeMove: function (pid, tid, num) {
      var _this = this;
      var spliceItem = _this.data.paper[pid].list.splice(tid, 1);
      _this.data.paper[pid].list.splice(tid + num, 0, spliceItem[0]);
    },

    /*移动*/
    quesItemMove: function (pid, tid, oid, num) {
      var _this = this;
      var spliceItem = _this.data.paper[pid].list[tid].content.splice(oid, 1);
      _this.data.paper[pid].list[tid].content.splice(oid + num, 0, spliceItem[0]);
    },

    /*上移*/
    moveUp: function (pid, tid) {
      this.quesTypeMove(pid, tid, -1);
      layer.msg("上移");
    },

    /*下移*/
    moveDown: function (pid, tid) {
      this.quesTypeMove(pid, tid, 1);
      layer.msg("下移")
    },

    /*item上移*/
    itemMoveUp: function (pid, tid, oid) {
      this.quesItemMove(pid, tid, oid, -1);
      layer.msg("上移");
    },

    /*item下移*/
    ItemMoveDown: function (pid, tid, oid) {
      this.quesItemMove(pid, tid, oid, 1);
      layer.msg("下移")
    },

    /**删除试题-自定义
     * param @pid number 分卷
     * param @tid number 大题
     * param @oid number orderID [可选]
     * */
    delQuesType: function (pid, tid, oid) {
      var _this = this;
      layer.confirm("确定删除该题？", {icon: 3, title: '提示'},
        function () {

          // orderID 不存在
          if (oid == null) {

            _this.data.paper[pid].list.splice(tid, 1);
          } else {

            //单题删除
            _this.data.paper[pid].list[tid].content.splice(oid, 1);

            // 判断是否要清空题型type
            if (_this.data.paper[pid].list[tid].content.length === 0) {
              _this.data.paper[pid].list.splice(tid, 1)
            }
          }
          layer.msg('删除成功！', {icon: 1, time: 1000});
          _this.updateDom();
        })
    },

    /*删除试题-全部*/
    delAllQues: function (pid) {
      var _this = this;
      var partname = "第" + ((pid + 1) === 2 ? 'II' : 'I') + "卷";
      layer.confirm("确定删除 [" + partname + "] 所有试题？", {icon: 3, title: '提示'},
        function () {
          _this.data.paper[pid].list = [];
          layer.msg('删除成功！', {icon: 1, time: 1000});
          _this.updateDom();
        })
    },
    /*更新dom 获取已添加试题题号时使用*/
    updateDom: function () {
      var _this = this;

      //更新dom时同时更新本地缓存数据
      _this.dataState += 1;

      // html更新后调用
      _this.$nextTick(function () {
        _this.updateCurrCardOrderIDArray();
        _this.computedPage = _this.computedPageHtml();
      });
    },
    computedPageHtml: function () {
      var pageStyle = this.data.layout.style;
      var pages = ($(".con-height").height() / 994) - 0.15; //误差;
      var pagesCeil = Math.ceil(pages);
      var stylePageNum = this.data.layout.style === "A4" ? 2 : 6;
      return "预计打印" + Math.ceil(pagesCeil / stylePageNum) + "张  " +
        "<small title='" + (Math.ceil(pages * 100) / 100) + "'>(" + pageStyle + " 共" + pagesCeil + "页)</small>";
    },
    // 检查用户设置题号
    checkUserSetOrderID: function () {
      var _this = this;
      // 如果是用户设置题号
      var $SetOrderIpt = $("#userSetOrderID");
      // 当前设置项为显示状态时
      if ($SetOrderIpt.filter(":visible").length > 0) {
        // 题号存在
        if ($.inArray($SetOrderIpt.val() - 0, _this.examOrderIDArray.order) != -1) {
          layer.msg("题号 " + $SetOrderIpt.val() + " 不可用，请更换 ！");
          return false;
        }
        // 题号小于0
        if ($SetOrderIpt.val() - 0 <= 0) {
          return false;
        }
        // 题号可用
        if ($.inArray($SetOrderIpt.val() - 0, _this.examOrderIDArray.order) == -1) {
          return $SetOrderIpt.val() - 0;
        }
        return true;
      }
    },

    // 更新已添加试题题号
    updateCurrCardOrderIDArray: function () {
      // 初始化试题序号，检查试题序号是否重复
      var _this = this;
      var $quesID = $("[card-ques-id]");//题号id
      console.log($quesID.length, '$quesID');
      var arrProto = []; //原始序号数据
      var arrInt = [];
      // 当前有试题
      if ($quesID.length > 0) {
        $quesID.each(function () {
          var $this = $(this),
            item = $this.attr("card-ques-id");
          arrProto.push(item - 0);
          arrInt.push(parseInt(item));
        });
        // 当前无试题
      } else {
        _this.examOrderIDArray.min = 0;
        _this.examOrderIDArray.max = 0;
        _this.examOrderIDArray.order = [];
        _this.examOrderIDArray.outOrder = [];
        layer.msg("当前没有试题哦！")
      }
      // 获取到试题题号后
      if (arrInt.length > 0) {
        var savedArr = arrProto;
        // 数组排重排序
        arrInt = arrInt.unique().sort(function (a, b) {
          return a - b
        });
        // 题号中不存在的值
        var outArr = [];
        for (var i = 1; i < _this.examOrderIDArray.max; i++) {
          if ($.inArray(i, arrInt) == -1) {
            outArr.push(i);
          }
        }
        _this.examOrderIDArray.outOrder = outArr;
        _this.examOrderIDArray.min = arrInt.slice(0, 1)[0];
        _this.examOrderIDArray.max = arrInt.slice(-1)[0];
        _this.examOrderIDArray.order = arrInt;

        console.log("已添加：" + arrInt.length);

        // 找出重复的题号
        savedArr = savedArr.unique().sort(function (a, b) {
          return a - b
        });
        /*无小题题号 与 有小题题号相同*/
        var sameNumArr = [];
        for (var i = 0; i < savedArr.length; i++) {
          if (savedArr[i] === Math.floor(savedArr[i + 1])) {
            sameNumArr.push(savedArr[i]);
          }
        }
        /*题号相同 且 小题相同*/
        var sameNumArr1 = [];
        for (var i = 0; i < arrProto.length; i++) {
          if (arrProto[i] === arrProto[i + 1]) {
            sameNumArr1.push(parseInt(arrProto[i]));
          }
        }
        // 判断是否重复
        if (sameNumArr.length > 0 || sameNumArr1.length > 0) {
          var sameOrderTips = JSON.stringify([].concat(sameNumArr, sameNumArr1).unique());
          layer.alert("当前试题中：序号<span class='text-primary'> " + sameOrderTips + " </span>有重复，请检查！", {icon: 0})
        }
      }
    },

    // 检查数据合法性
    _checkForTypeKey: function (type, item) {
      var inLength = 0;//检查项目数量统计
      for (var m = 0; m < type.length; m++) {
        if (type[m] in item && item.hasOwnProperty(type[m])) {
          inLength++;
        } else {
          $.console.warn("题号：" + item.order + " 数据验证未通过！" + type[m] + "为必须字段")
        }
      }
      return inLength === type.length ? true : false
    },

    // 检查数据方法
    _checkAnswerJson: function (data) {
      // 检查项目
      var checkType = [
        ['style', 'order', 'small', 'num'],
        ["order", "small", "uline", 'kong', 'hline', "score"],
        ["order", "small", "uline", 'kong', 'hline', "score"],
        ['order', 'char', 'score'],
        ['order', 'uline', 'hline', 'score']
      ];

      var _dataPaper = data.paper;

      // JSON.parse(JSON.stringify(data.paper));//缓存答题卡数据

      console.log(_dataPaper);

      var isPassCheck = true;//默认检查通过
      $.each(_dataPaper, function (i) {//检查答题卡数据，通过返回true，否则返回false
        var list = _dataPaper[i].list;
        $.each(list, function (j) {
          var quesType = list[j].type - 0;//缓存题型
          var content = list[j].content;//缓存试题列表
          $.each(content, function (k) {
            var contentItem = content[k];
            isPassCheck = app._checkForTypeKey(checkType[quesType], contentItem);//调用检查数据方法

            //修正hline
            if ("hline" in contentItem && contentItem.hline > 1 && contentItem.hline != parseInt(contentItem.hline)) {
              var cacheHline = contentItem.hline;
              contentItem.hline = parseInt(cacheHline);//修正字段数值
              $.console.warn("题号:" + contentItem.order + ",type=" + quesType + "; hline" + cacheHline + " 为大于1非整数;" + "已修正为:" + contentItem.hline);
            }

            if (quesType == 4) {//英语作文题型
              if (contentItem.hline < 1) {
                contentItem.hline = 10;//修正字段数值
                $.console.warn("type=" + quesType + "; hline 不可以小于0;" + "已修正为10");
              }
            }
          })
        })
      });
      return isPassCheck;
    },

    /*@params
     * @params content string html
     * @params btnGroup array ['btn1','btn2']
     * @params fn1 btn1 执行函数
     * @params fn2 btn2 执行函数
     * @*/
    layerMsg: function (content, btnGroup, fn1, fn2) {
      var fn2 = fn2 || function () {
          localStorage.setItem("cardDataStorage", null)
        };
      var layIndex = layer.open({
        type: 0,
        icon: 0,
        content: content,
        btn: btnGroup,
        btn1: function () {
          fn1();
          layer.close(layIndex)
        },
        btn2: function () {
          fn2();
          layer.close(layIndex)
        }
      })
    },

    // 获取保存的答题卡id
    tryGetSavedData: function () {
      var id = 0;
      try {
        id = editData.getAttr(1);
      } catch (e) {
        $.console.warn(e);
      }
      return id;
    },

    //获取保存的数据（本地缓存的，服务器自动生成的，已保存的）
    getSavedData: function () {
      var _this = this;
      var params = {
        CookieStr: editData.getall(),
        SaveID: _this.tryGetSavedData(),
        Style: 2
      };

      // this.getSaveDataHandle({});
      // 数据加载提示
      var cardLoading = layer.msg("数据加载中...", {'time': 0, 'shade': 0.3});
      $.post(U('Home/Index/getAnswerJson'), params, function (data) {

        console.log(data);

        // 数据获取成功隐藏提示
        layer.close(cardLoading);
        app.getSaveDataHandle(data);

      })
    },

    // 撤销数据恢复
    alertBackData: function (autoData, defaultData) {
      var Vue$this = this;
      layer.msg("数据恢复有问题？是否撤销恢复，使用默认数据？", {
        offset: [0], time: 0, btn: ["撤销恢复", "关闭提示"],
        success: function (layero) {
          layero.find(".layui-layer-btn").css({"text-align": "center"});
        },
        btn1: function () {
          if (autoData) {
            Vue$this.data = autoData;
          } else {
            Vue$this.data = defaultData
          }
          app.updateDom();
        }
      });
    },

    getSaveDataHandle: function (data) {

      var Vue$this = this,
        savedData = null,
        autoData = null,
        cardDataStorage = null,
        defaultData = JSON.parse(JSON.stringify(_vue_data.data));

      /* @当前数据状态
       * a. 修改状态 b. 保存状态 c. 系统默认数据
       * 1. 上次修改未保存，提示是否恢复到之前修改状态
       * 2. 有保存记录，且有上次修改未保存状态
       * 3. 有保存记录，*/
      /*1.修改状态*/

      cardDataStorage = $.parseJSON(localStorage.getItem("cardDataStorage"));

      if (data.data && typeof data.data == "object") {

        // 用户保存
        if (data.data.Data) {
          if (Vue$this._checkAnswerJson(data.data.Data.DataStr)) {
            savedData = data.data.Data.DataStr;
          } else {
            $.console.warn("已保存答题卡数据有误，不可使用！")
          }
        }

        // 程序生成
        if (data.data.Auto) {
          if (Vue$this._checkAnswerJson(data.data.Auto)) {
            autoData = data.data.Auto;
          } else {
            $.console.warn("生成答题卡数据有误，不可使用！")
          }
        }

        //使用自动数据
        if (autoData) {
          Vue$this.data = autoData;
        }

      } else {
        layer.msg(data.toString());
      }
      Vue$this.updateDom();


      var contentStr = "<strong>当前有以下答题卡数据可用:</strong><br>" +
        "(1).【上次操作】是您最近一次的修改未保存状态！<br>" +
        "(2).【保存状态】是上次配置答题卡的保存状态！<br>请选择！";
      var btn = ["确定", "取消"];
      var isThisLocalData = cardDataStorage &&
        cardDataStorage.id == editData.getAttr(1) &&
        cardDataStorage.subjectID == Cookie.Get("SubjectId");

      // 有保存记录，且有上次修改未保存状态
      if (isThisLocalData && savedData) {
        btn = ["上次操作", "保存状态"];
        Vue$this.layerMsg(contentStr, btn, function () {
          Vue$this.data = $.extend(true, {}, Vue$this.data, cardDataStorage.data);
          Vue$this.updateDom();
          Vue$this.alertBackData(autoData, defaultData);
        }, function () {
          Vue$this.data = $.extend(true, {}, Vue$this.data, savedData);
          Vue$this.updateDom();
          Vue$this.alertBackData(autoData, defaultData);
        });
        return;
      }

      //上次修改未保存，提示是否恢复到之前修改状态
      if (isThisLocalData) {
        contentStr = "<strong>有未保存的数据:</strong><br>是否恢复到上次编辑状态？";
        Vue$this.layerMsg(contentStr, btn, function () {
          Vue$this.data = $.extend(true, {}, Vue$this.data, cardDataStorage.data);
          Vue$this.updateDom();
          Vue$this.alertBackData(autoData, defaultData);
        });
        return;
      }

      //有保存记录
      if (savedData) {
        contentStr = "<strong>当前有已保存的数据:</strong><br>是否使用已保存数据？";
        Vue$this.layerMsg(contentStr, btn, function () {
          Vue$this.data = $.extend(true, {}, Vue$this.data, savedData);
          Vue$this.updateDom();
          Vue$this.alertBackData(autoData, defaultData);
        });
      }
    }
  }
}).$mount("#app");
