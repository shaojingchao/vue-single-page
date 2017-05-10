<template>
    <div class="main-top hover">
        <div class="part-menu">
            <a href="javascript:;" class="btn" @click="showTitleAlert">
                <i class="iconfont">&#xe601;</i>编辑
            </a>
        </div>
        <div class="name center" id="paper-name" v-show="title.top.display">
            {{title.top.content}}
        </div>
        <div class="paper-title mintitle red center" v-show="title.title.display">
            {{title.title.content}}
        </div>
        <div class="paper-title subtitle center" v-show="title.sub.display">
            {{title.sub.content}}
        </div>
    </div>
</template>

<script>
export default {
    name:"main-top",
    props: ["title"],
    methods: {
        showTitleAlert: function () {
            app.alert.state_alertTitle = true;
        }
    }
}
</script>