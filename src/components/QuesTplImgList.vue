<span class="jd-img-list big-block">
    <span class="img-item-cell"
          v-for="(imgItem,imgItemIndex) in contentItem.img">
        <span class="img-item">
            <!--<a href="javascript:;" class="del-img" v-on:click="delThisQuesImg(partItemIndex,typeItemIndex,subOrderID,imgItemIndex)">删除</a>-->
            <img v-bind:src="imgItem[0]" v-bind:alt="contentItem.order">
          <!--<br>-->
          <!--<span class="img-item-desc" v-if="imgItem[1]">{{imgItem[1]}}</span>-->
        </span>
    </span>
</span>
