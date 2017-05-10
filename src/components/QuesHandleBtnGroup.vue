
<div class="J_ques-handle-group" v-if="hoverThis===1">
    <div class="J_layer-box"></div>
    <div class="ques-handle-group">
        <a href="javascript:;"
           class="btn"
           v-on:click="showAlertEditJiedati(partItemIndex,typeItemIndex,subOrderID)">
            <i class="iconfont">&#xe601;</i>编辑
        </a>
        <a href="javascript:;"
           class="btn"
           v-on:click="delThisQues(partItemIndex,typeItemIndex,subOrderID)">
            <i class="iconfont">&#xe600;</i>删除
        </a>
        <a v-show="subOrderID != itemLength-1"
        href="javascript:;"
        class="btn"
        @click="moveDownThisQues(partItemIndex,typeItemIndex,subOrderID)">
        <i class="iconfont">&#xe605;</i>下移
        </a>
        <a v-show="subOrderID !=0"
        href="javascript:;"
        class="btn"
        @click="moveUpThisQues(partItemIndex,typeItemIndex,subOrderID)">
        <i class="iconfont">&#xe604;</i>上移
        </a>
    </div>
</div>