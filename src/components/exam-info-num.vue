<template>
  <!-- 准考证号 -->
  <div class="tab-card" v-if="data.num.display == 1">
    <table class="card">
      <tbody>
      <tr>
        <td colspan="13" class="title"><em>准考证号</em></td>
      </tr>
      <tr class="pad8">
        <td v-for="item in 13"></td>
      </tr>
      <tr>
        <td v-for="itemtr in 13">
          <div v-for="item in 10">
            [ <span class="pad4"> {{item-1}} </span> ]
          </div>
        </td>
      </tr>
      </tbody>
    </table>
  </div>
</template>
<script>
  export default {
    name: "exam-info-num",
    props: ["data"],
    data: function () {
      return {}
    }
  }
</script>
