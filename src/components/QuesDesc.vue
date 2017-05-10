<script>
  /*描述*/
  export default {
    name: "ques-desc",
    template: '<p class="J_ques-desc" v-if="viewIf" v-html="vHtml"></p>',
    props: ["contentItem"],
    data: function () {
      return {}
    },
    computed: {
      viewIf: function () {
        return this.contentItem.desc && this.contentItem.desc.length > 0
      },
      vHtml: function () {
        if (this.viewIf) {
          return this.contentItem.desc.replace(/\n/g, "<br\>")
        }
      }
    }
  }
</script>
