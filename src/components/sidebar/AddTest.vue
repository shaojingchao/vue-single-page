<template>
  <div class="panel-order addtest">
    <a href="javascript:;" v-on:click="showAlertXuanzeti(comeFrom)"><span>选</span>选择题</a>
    <a href="javascript:;" v-on:click="showAlertTiankongti(comeFrom)"><span>填</span>填空题</a>
    <a href="javascript:;" v-on:click="showAlertJiedati(comeFrom)"><span>解</span>解答题</a>
    <a href="javascript:;" v-on:click="showAlertXuandati(comeFrom)"><span>选</span>选答题</a>
    <a href="javascript:;" v-on:click="showAlertEnZuowen(comeFrom)"><span>英</span>英语作文</a>
    <a href="javascript:;" v-on:click="showAlertCnZuowen(comeFrom)"><span>文</span>语文作文</a>
  </div>
</template>

<script>
  /*添加试题*/
  export default {
    name: "add-test",
    props: ["modal"],
    data: function () {
      return {
        comeFrom: "bar"
      }
    },
    methods: {
      showAlertTiankongti: function (come) {
        Bus.$emit("showAlertTiankongti", come);
        app.alert.state_alertTiankongti = true
      },
      showAlertXuanzeti: function (come) {
        Bus.$emit("showAlertXuanzeti", come);
        app.alert.state_alertXuanzeti = true
      },
      showAlertJiedati: function (come) {
        Bus.$emit("showAlertJiedati", come);
        app.alert.state_alertJiedati = true
      },
      showAlertXuandati: function (come) {
        Bus.$emit("showAlertXuandati", come);
        app.alert.state_alertXuandati = true
      },
      showAlertEnZuowen: function (come) {
        Bus.$emit("showAlertEnZuowen", come);
        app.alert.state_alertEnZuowen = true
      },
      showAlertCnZuowen: function (come) {
        Bus.$emit("showAlertCnZuowen", come);
        app.alert.state_alertCnZuowen = true
      }
    }
  }
</script>
