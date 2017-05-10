<script>
  export default {
    name: 'ques-title-info',
    template: '<div class="q-title-inner" v-if="item.display==1"><p>{{item.title}}</p></div>',
    props: ["item", "score"]
  }
</script>
