var data = {
    examPart: [
        {
            title: "第Ⅰ卷",
            desc: '（请用2B铅笔填涂）', //描述
            list: [
                {
                    'title': '选择题', //标题
                    'display': 1, //是否显示title
                    'type': 0, //客观题	0：客观题 1：解答题 2：选做题 3：语文作文 4英语作文
                    'style': 0, //横排0  竖排1
                    'content': [ //客观内容
                        {'style': 1, 'order': 1, 'small': 0, 'num': 4}, // 【类型，题号，小题序号例如（1），选项数量】
                        {'style': 1, 'order': 2, 'small': 0, 'num': 4},
                        {'style': 1, 'order': 3, 'small': 0, 'num': 4},
                        {'style': 2, 'order': 4, 'small': 0, 'num': 4},
                        {'style': 2, 'order': 5, 'small': 0, 'num': 4},
                        {'style': 2, 'order': 6, 'small': 0, 'num': 4},
                        {'style': 3, 'order': 7, 'small': 0, 'num': 4},
                        {'style': 3, 'order': 11, 'small': 1, 'num': 4}
                    ]
                }
            ]
        }, {
            title: "第Ⅱ卷 ",
            desc: '(请用0.5毫米黑色签字笔作答)', //描述
            list: [
                {
                    "type": 1,
                    "title": "填空题1",
                    "content": [
                        // 【题号，当前小题数，下划线，空数，行宽0.3代表1/3，分值】
                        {"order": 10, "small": 0, "uline": 1, 'kong': 2, 'hline': 0.5, "score": 5},
                        {"order": 11, "small": 0, "uline": 1, 'kong': 2, 'hline': 0.5, "score": 5}
                    ]
                },
                {
                    "type": 1,
                    "title": "填空题2",
                    "content": [
                        // 【题号，当前小题数，下划线，空数，行宽0.3代表1/3，分值】
                        {"order": 10, "small": 1, "uline": 1, 'kong': 1, 'hline': 0.5, "score": 5},
                        {"order": 10, "small": 2, "uline": 1, 'kong': 1, 'hline': 0.5, "score": 5},
                        {"order": 11, "small": 1, "uline": 1, 'kong': 1, 'hline': 0.5, "score": 5},
                        {"order": 11, "small": 2, "uline": 1, 'kong': 1, 'hline': 0.5, "score": 5},
                        {"order": 12, "small": 0, "uline": 1, 'kong': 1, 'hline': 0.5, "score": 5},
                        {"order": 13, "small": 0, "uline": 1, 'kong': 1, 'hline': 0.5, "score": 5},
                        {"order": 14, "small": 0, "uline": 1, 'kong': 3, 'hline': 0.5, "score": 5},
                        {"order": 15, "small": 0, "uline": 1, 'kong': 1, 'hline': 0.5, "score": 5}
                    ]
                },
                {
                    "type": 1,
                    "title": "填空题3",
                    "content": [
                        // 【题号，当前小题数，下划线，空数，行宽0.3代表1/3，分值】
                        {"order": 12, "small": 1, "uline": 1, 'kong': 3, 'hline': 0.3, "score": 5},
                        {"order": 12, "small": 2, "uline": 1, 'kong': 3, 'hline': 0.3, "score": 5},
                        {"order": 13, "small": 0, "uline": 1, 'kong': 3, 'hline': 0.3, "score": 5},
                        {"order": 14, "small": 1, "uline": 1, 'kong': 3, 'hline': 0.3, "score": 5},
                        {
                            "order": 14, "small": 2, "uline": 1, 'kong': 3, 'hline': 0.3, "score": 5,
                            'img': [['/Public/static/card/img/pic.jpg', '描述'], ['/Public/static/card/img/pic.jpg'], ['/Public/static/card/img/pic.jpg']]
                        }
                    ]
                },
                {
                    "type": 1,
                    "title": "解答题",
                    "content": [
                        {
                            'order': 14, 'small': 0, 'uline': 1, 'kong': 0, 'hline': 10, 'score': 6,
                            'img': [['/Public/static/card/img/pic.jpg', '描述'], ['/Public/static/card/img/pic.jpg'], ['/Public/static/card/img/pic.jpg']],
                            'desc': '试题描述'
                        },
                        {
                            'order': 15, 'small': 1, 'uline': 1, 'kong': 0, 'hline': 10, 'score': 6,
                            'desc': '试题描述'
                        },
                        {
                            'order': 15, 'small': 2, 'uline': 0, 'kong': 0, 'hline': 10, 'score': 6
                        }
                    ]
                },
                {
                    "type": 2,
                    "title": "选答题",
                    "display": 1,
                    "do": 1,
                    "content": [
                        {
                            'order': 32, 'small': 0, 'uline': 1, 'kong': 0, 'hline': 10, 'score': 6,
                            'img': [['/Public/static/card/img/pic.jpg', '描述'], ['/Public/static/card/img/pic.jpg', '描述']],
                            'desc': '试题描述'
                        },
                        {
                            'order': 33, 'small': 1, 'uline': 1, 'kong': 0, 'hline': 10, 'score': 6,
                            'img': [['/Public/static/card/img/pic.jpg', '描述'], ['/Public/static/card/img/pic.jpg', '描述']],
                            'desc': '试题描述'
                        }// 【类型问答题，题号，步骤序号，下划线，行数，分值，图像，描述】
                    ]
                },
                {
                    "type": 4,
                    "title": "英语作文1",
                    "content": [
                        {'order': 40, 'uline': 1, 'hline': 4, 'score': 20, 'desc': '试题描述'}// 【类型英文作文，题号，下划线，行数，分值，描述】
                    ]
                }, {
                    "type": 4,
                    "title": "英语作文2",
                    "content": [
                        {'order': 41, 'uline': 0, 'hline': 4, 'score': 20, 'desc': '试题描述'}// 【类型英文作文，题号，下划线，行数，分值，描述】
                    ]
                },
                {
                    'title': '语文作文',
                    'display': 1,
                    'type': 3, //语文作文     0：客观题 1：解答题 2：选做题 3：语文作文 4英语作文
                    'content': [
                        {'order': 25, 'char': 200, 'score': 60, 'desc': '描述'} //【题号，字数，分值，描述】
                    ]
                },
                {
                    "title": "填空题",
                    "display": 1,
                    "type": 1,
                    "content": [
                        {"order": 12, "small": 1, "uline": 1, 'kong': 3, 'hline': 0.3, "score": 5}
                    ]
                }
            ]
        }
    ]
}