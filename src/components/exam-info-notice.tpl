<!--<div class="notice">-->
    <!--<h3>注意事项</h3>-->
    <!--<p class="text">1．答题前，请将姓名、班级、考场、座位号、准考证号填写清楚。<br />-->
        <!--2．客观题需用（2B）铅笔按<span></span>图示规范填涂，修改时用橡皮擦干净。<br />-->
        <!--3．主观题使用黑色签字笔书写。<br />-->
        <!--4．必须在题号所对应的答题区域内作答，超出答题区域书写无效。</p>-->
<!--</div>-->
<div class="notice" v-if="data.care.display">
    <h3>注意事项</h3>
    <p class="text" v-html="data.care.content.replace(/\n/g,'<br>')"></p>
</div>