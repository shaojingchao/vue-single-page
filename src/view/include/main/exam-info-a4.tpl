<script type="text/html" id="tpl-exam-info-a4">
    <div class="exam-intro hover">
        <div class="part-menu">
            <a href="javascript:;" class="btn" v-on:click="showAlertExamInfo">
                <i class="iconfont">&#xe601;</i>编辑
            </a>
        </div>
        <!-- A4高考仿真  -->
        <div class="exam-cont layer1 examtype-gk" v-if="type.display=='1'">
            <div class="intro-l left">
                <link rel="import" href="/app/card/view/include/exam-info-exam-number.tpl?__inline">
                <link rel="import" href="/app/card/view/include/exam-info-notice.tpl?__inline">
            </div>
            <div class="intro-r right">
                <link rel="import" href="/app/card/view/include/exam-info-barcode.tpl?__inline">
                <link rel="import" href="/app/card/view/include/exam-info-miss.tpl?__inline">
            </div>
        </div>
        <!-- A4期中期末  -->
        <div class="exam-cont layer1 examtype-qz" v-if="type.display=='2'">
            <div class="intro-l left">
                <link rel="import" href="/app/card/view/include/exam-info-num.tpl?__inline">
            </div>
            <div class="intro-r right">
                <link rel="import" href="/app/card/view/include/exam-info-barcode.tpl?__inline">
                <link rel="import" href="/app/card/view/include/exam-info-notice.tpl?__inline">
                <link rel="import" href="/app/card/view/include/exam-info-miss.tpl?__inline">
            </div>
        </div>
        <!-- A4单元测试 -->
        <div class="exam-cont layer1 examcard-no-a4 examtype-dy" v-if="type.display=='3'">
            <div class="intro-l left">
                <link rel="import" href="/app/card/view/include/exam-info-notice.tpl?__inline">
            </div>
            <div class="intro-r right">
                <link rel="import" href="/app/card/view/include/exam-info-barcode.tpl?__inline">
                <link rel="import" href="/app/card/view/include/exam-info-miss.tpl?__inline">
            </div>
        </div>
        <!-- A4课时训练 -->
        <div class="exam-cont layer1 barcode-no-a4 examtype-ks" v-if="type.display=='4'">
            <div class="intro-l left">
                <link rel="import" href="/app/card/view/include/exam-info-num.tpl?__inline">
            </div>
            <div class="intro-r right">
                <link rel="import" href="/app/card/view/include/exam-info-notice.tpl?__inline">
                <link rel="import" href="/app/card/view/include/exam-info-miss.tpl?__inline">
            </div>
        </div>
    </div>
</script>