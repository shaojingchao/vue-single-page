<template>
  <div class="panel-order testlist">
    <ul v-for="(partItem,partItemIndex) in examPart" v-if="examPart.length>0">
      <li class="text-primary">
        <span class="left">{{partItem.title}}</span>
        <a href="javascript:;"
           class="del-all-part"
           v-if="partItem.list.length>0"
           v-on:click="delAllQues(partItemIndex)">清空</a></li>
      <li v-for="(typeItem,typeItemIndex) in partItem.list">
        <a class="test-title" v-on:click="scrollThisPlace"
           v-bind:data-href="'#ques-anchor'+partItemIndex+'-'+typeItemIndex">{{typeItem.title}}</a>
        <span class="test-number">{{typeItem.content.length}} 题</span>
        <a href="javascript:;" v-on:click="barDelThisQuesType(partItemIndex,typeItemIndex)" class="icon"
           title="删除该题"></a>
      </li>
    </ul>
  </div>
</template>
<script>
  /*已添加试题*/
  export default {
    name: "test-list",
    props: ["modal", "examPart"],
    methods: {
      /*滚动到对应位置*/
      scrollThisPlace: function (e) {
        if ($("#left-con").is(":animated")) return false;
        var $thisItemDiv = $($(e.currentTarget).data("href"));
        var itemTop = $thisItemDiv.offset().top - 50;

        var conScrollTop = $("#left-con").scrollTop();
        $("#left-con").animate({
          scrollTop: itemTop + conScrollTop
        }, 600, function () {
          $thisItemDiv.addClass("animated-flash");
          setTimeout(function () {
            $thisItemDiv.removeClass("animated-flash");
          }, 1000);
        })
      },
      /*删除试题*/
      barDelThisQuesType: function (pid, tid) {
        app.delQuesType(pid, tid);
      },
      /*删除所有试题*/
      delAllQues: function (pid) {
        app.delAllQues(pid);
      }
    }
  }
</script>
