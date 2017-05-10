<div class="part-menu">
    <a href="javascript:"
       class="btn"
       v-on:click="showAlertEditQuesTitle(partItemIndex,typeItemIndex)">
        <i class="iconfont">&#xe601;</i>编辑
    </a>
    <a href="javascript:"
       class="btn"
       v-on:click="showAlertJiedati(partItemIndex,typeItemIndex)">
        <i class="iconfont">&#xe602;</i>添加
    </a>
    <a href="javascript:"
       class="btn"
       v-on:click="delThisQues(partItemIndex,typeItemIndex)">
        <i class="iconfont">&#xe600;</i>删除
    </a>
    <a v-show="typeItemIndex != partItem.list.length-1"
       href="javascript:"
       class="btn"
       v-on:click="moveDownThisQues(partItemIndex,typeItemIndex)">
        <i class="iconfont">&#xe605;</i>下移
    </a>
    <a v-show="typeItemIndex !=0"
       href="javascript:"
       class="btn"
       v-on:click="moveUpThisQues(partItemIndex,typeItemIndex)">
        <i class="iconfont">&#xe604;</i>上移
    </a>
</div>

