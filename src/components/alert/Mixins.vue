<!--VueMixin_AddQuesOrderConfig-->
<script>
  export default {
    props: ["modal", "examOrderIDArray"],
    data: function () {
      return {
        addFrom: '', //何种方式添加试题
        selectedAddedTestNum: 1,
        toggleSetOrderID: false, //是否设置题号
        getOrderID:''
      }
    },
    created: function () {
      var _this = this;
      Bus.$on("toggleSetOrderID", function (val) {
        _this.toggleSetOrderID = val;
      });

      // 监听组件传递的值并更新
      Bus.$on("sendSetterOrderID", function (val) {
        _this.getOrderID = val;
      })
    },
    computed: {
      getOrderIDInit:function(){
        return this.examOrderIDArray.max + 1
      },
      computedOrderID: function () {
        var _this = this;

        /*仅当添加题数为1，且设置题号为true时，使用自定义题号，否则使用自动题号*/
        if (_this.selectedAddedTestNum == 1) {
          if (_this.toggleSetOrderID) {
            return _this.getOrderID || _this.getOrderIDInit
          }
        }
        return _this.examOrderIDArray.max + 1;
      },

      /*添加试题题号范围提示*/
      computedOrderRange: function () {
        if (this.selectedAddedTestNum <= 1) {
          return "第" + this.computedOrderID + "题";
        } else {
          return "第" + this.computedOrderID + "题" + " ~ " +
            "第" + (this.computedOrderID + this.selectedAddedTestNum - 1) + "题";
        }
      }
    }
  }
</script>
