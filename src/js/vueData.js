module.exports = {
  computedPage: '',
  dataState: 0,
  /*====================辅助数据定义========================*/
  alert: {
    state_alertTitle: false,
    state_alertEditQuesTitle: false,
    state_alertExamInfo: false,
    state_alertTiankongti: false,
    state_alertXuanzeti: false,
    state_alertJiedati: false,
    state_alertEditJiedati: false,
    state_alertXuandati: false,
    state_alertEnZuowen: false,
    state_alertCnZuowen: false,
    state_alertPartInfo: false
  },
  examOrderIDArray: {
    order: [],
    outOrder: [],
    max: 0,
    min: 0
  },
  // answerType: '',
  data: {
    "top": {"display": 1, "content": "姓名____________班级____________考号____________座位号____________"},
    "title": {"display": 1, "content": "[标题]XX县高级中学高二下学期月考"},
    "sub": {"display": 1, "content": "[副标题]XX答题卡"},
    "layout": {"style": "A3"},
    "type": {"display": 3},
    "code": {"display": 1},
    "num": {"display": 1, "length": 10},
    "care": {
      "display": 1,
      "content": "1．答题前，请将姓名、班级、考场、座位号、准考证号填写清楚。\n2．客观题答题，必须使用2B铅笔填涂，修改时用橡皮擦干净。\n3．主观题使用黑色签字笔书写。\n4．必须在题号所对应的答题区域内作答，超出答题区域书写无效。"
    },
    "miss": {"display": 1},
    "score": {"display": 1},
    "paper": [{
      "title": "第Ⅰ卷",
      "desc": "（请用2B铅笔填涂）",
      "list": [{
        "title": "选择题",
        "display": 1,
        "type": 0,
        "style": 0,
        "content": [{"order": 1, "style": 1, "small": 0, "num": 4}, {
          "order": 2,
          "style": 1,
          "small": 0,
          "num": 4
        }, {"order": 3, "style": 1, "small": 0, "num": 4}, {"order": 4, "style": 1, "small": 0, "num": 4}, {
          "order": 5,
          "style": 1,
          "small": 0,
          "num": 4
        }, {"order": 6, "style": 1, "small": 0, "num": 4}, {"order": 7, "style": 1, "small": 0, "num": 4}, {
          "order": 8,
          "style": 1,
          "small": 0,
          "num": 4
        }, {"order": 9, "style": 1, "small": 0, "num": 4}, {
          "order": 10,
          "style": 1,
          "small": 0,
          "num": 4
        }, {"order": 11, "style": 1, "small": 0, "num": 4}, {
          "order": 12,
          "style": 1,
          "small": 0,
          "num": 4
        }, {"order": 13, "style": 1, "small": 0, "num": 4}, {
          "order": 14,
          "style": 1,
          "small": 0,
          "num": 4
        }, {"order": 15, "style": 1, "small": 0, "num": 4}, {
          "order": 16,
          "style": 1,
          "small": 0,
          "num": 4
        }, {"order": 17, "style": 1, "small": 0, "num": 4}, {
          "order": 18,
          "style": 1,
          "small": 0,
          "num": 4
        }, {"order": 19, "style": 1, "small": 0, "num": 4}, {
          "order": 20,
          "style": 1,
          "small": 0,
          "num": 4
        }, {"order": 21, "style": 1, "small": 0, "num": 4}, {
          "order": 22,
          "style": 1,
          "small": 0,
          "num": 4
        }, {"order": 23, "style": 1, "small": 0, "num": 4}, {
          "order": 24,
          "style": 1,
          "small": 0,
          "num": 4
        }, {"order": 25, "style": 1, "small": 0, "num": 4}, {
          "order": 26,
          "style": 1,
          "small": 0,
          "num": 4
        }, {"order": 27, "style": 1, "small": 0, "num": 4}, {
          "order": 28,
          "style": 1,
          "small": 0,
          "num": 4
        }, {"order": 29, "style": 1, "small": 0, "num": 4}, {"order": 30, "style": 1, "small": 0, "num": 4}]
      }]
    }, {
      "title": "第Ⅱ卷 ",
      "desc": "(请用0.5毫米黑色签字笔作答)",
      "list": [{
        "title": "填空题",
        "display": 1,
        "type": 1,
        "content": [{
          "order": 31,
          "small": 0,
          "uline": 1,
          "kong": 2,
          "hline": 0.5,
          "desc": "",
          "img": [],
          "score": 2
        }, {
          "order": 32,
          "small": 0,
          "uline": 1,
          "kong": 2,
          "hline": 0.5,
          "desc": "",
          "img": [],
          "score": 2
        }, {
          "order": 33,
          "small": 0,
          "uline": 1,
          "kong": 3,
          "hline": 0.3,
          "desc": "",
          "img": [],
          "score": 2
        }, {"order": 34, "small": 0, "uline": 1, "kong": 3, "hline": 0.3, "desc": "", "img": [], "score": 2}]
      }, {
        "title": "解答题",
        "display": 1,
        "type": 1,
        "content": [{
          "order": 35,
          "small": 0,
          "uline": 0,
          "kong": 0,
          "hline": 10,
          "score": 15,
          "desc": "",
          "img": []
        }, {
          "order": 36,
          "small": 0,
          "uline": 0,
          "kong": 0,
          "hline": 8,
          "score": 10,
          "desc": "",
          "img": []
        }, {
          "order": 37,
          "small": 0,
          "uline": 0,
          "kong": 0,
          "hline": 12,
          "score": 10,
          "desc": "",
          "img": []
        }, {"order": 38, "small": 0, "uline": 0, "kong": 1, "hline": 15, "score": 8, "desc": "", "img": []}]
      }, {
        "title": "书面表达",
        "display": 1,
        "type": 4,
        "content": [{"order": 39, "uline": 1, "hline": 10, "score": 20, "desc": ""}]
      }, {"title": "作文", "display": 1, "type": 3, "content": [{"order": 40, "char": 600, "score": 60, "desc": ""}]}]
    }]
  }
};
