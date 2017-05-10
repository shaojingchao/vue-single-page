<script type="text/html" id="tpl-test-list">
    <div class="panel-order testlist">
        <ul v-for="(partItem,partItemIndex) in examPart" v-if="examPart.length>0">
            <li class="text-primary">
                <span class="left">{{partItem.title}}</span>
                <a href="javascript:;"
                   class="del-all-part"
                   v-if="partItem.list.length>0"
                   v-on:click="delAllQues(partItemIndex)">清空</a></li>
            <li v-for="(typeItem,typeItemIndex) in partItem.list">
                <a class="test-title" v-on:click="scrollThisPlace" v-bind:data-href="'#ques-anchor'+partItemIndex+'-'+typeItemIndex">{{typeItem.title}}</a>
                <span class="test-number">{{typeItem.content.length}} 题</span>
                <a href="javascript:;" v-on:click="barDelThisQuesType(partItemIndex,typeItemIndex)" class="icon" title="删除该题"></a>
            </li>
        </ul>
    </div>
</script>
<!--<i class="iconfont"></i>-->