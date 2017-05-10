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
    answerType: '',
    data: {
        /*====================标准格式=====================*/
        top: { //顶部信息
            display: 1,
            content: "姓名____________班级____________考号____________座位号____________"
        },
        title: { //标题
            display: 1,
            content: "[标题]XX县高级中学高二下学期月考"
        },
        sub: { //副标题
            display: 1,
            content: "[副标题]XX答题卡"
        },
        layout: { //版式
            style: "A4"
        },
        type: {
            display: 1 //顶部类型（显示类型，顶部区域有N种固定类型）
        },
        code: { //条形码
            display: 1
        },
        num: { //准考证号
            display: 1,
            length: 10
        },
        care: { //注意事项
            display: 1,
            content: "1．答题前，请将姓名、班级、考场、座位号、准考证号填写清楚。\n" +
                "2．客观题答题，必须使用2B铅笔填涂，修改时用橡皮擦干净。\n" +
                "3．主观题使用黑色签字笔书写。\n" +
                "4．必须在题号所对应的答题区域内作答，超出答题区域书写无效。"
        },
        miss: {
            display: 1 //缺考标记
        },
        score: {
            display: 1 //是否显示分值
        },
        paper: [{
            title: "第Ⅰ卷",
            desc: '（请用2B铅笔填涂）', //描述
            list: [{
                "title": "解答题",
                "display": 1,
                "type": 1,
                "content": [{
                    "order": 1,
                    "small": 0,
                    "uline": 0,
                    "kong": 1,
                    "hline": 1,
                    "score": 1
                }, {
                    "order": 2,
                    "small": 0,
                    "uline": 0,
                    "kong": 0,
                    "hline": 1,
                    "score": 1
                }, {
                    "order": 3,
                    "small": 0,
                    "uline": 0,
                    "kong": 0,
                    "hline": 1,
                    "score": 1
                }, {
                    "order": 4,
                    "small": 1,
                    "uline": 1,
                    "kong": 1,
                    "hline": 1,
                    "score": 1
                }, {
                    "order": 4,
                    "small": 2,
                    "uline": 1,
                    "kong": 0,
                    "hline": 1,
                    "score": 1
                }, {
                    "order": 5,
                    "small": 0,
                    "uline": 0,
                    "kong": 0,
                    "hline": 1,
                    "score": 1
                }, {
                    "order": 6,
                    "small": 0,
                    "uline": 0,
                    "kong": 0,
                    "hline": 1,
                    "score": 1
                }]
            }]
        }, {
            title: "第Ⅱ卷 ",
            desc: '(请用0.5毫米黑色签字笔作答)', //描述
            list: []
        }]
    }
};