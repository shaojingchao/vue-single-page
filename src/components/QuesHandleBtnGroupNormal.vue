<a href="javascript:;"
   class="btn"
   v-on:click="delThisQues(partItemIndex,typeItemIndex)">
    <i class="iconfont">&#xe600;</i>删除
</a>
<a v-show="typeItemIndex != partItem.list.length-1"
   href="javascript:;"
   class="btn"
   @click="moveDownThisQues(partItemIndex,typeItemIndex)">
    <i class="iconfont">&#xe605;</i>下移
</a>
<a v-show="typeItemIndex !=0"
   href="javascript:;"
   class="btn"
   @click="moveUpThisQues(partItemIndex,typeItemIndex)">
    <i class="iconfont">&#xe604;</i>上移
</a>

