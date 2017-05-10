<template>
  <div class="panel-order format">
    <ul>
      <li id="tabA4" v-on:click="chooseTypeA4">
        <span v-bind:class="['format-img',{'choice':layout.style=='A4' || layout.style==null}]">
          <img v-bind:src="typeA4.src" alt="A4尺寸"></span>
        <p>一栏（A4尺寸）</p>
      </li>
      <li id="tabA3" v-on:click="chooseTypeA3">
        <span v-bind:class="['format-img',{'choice':layout.style=='A3'}]">
          <img v-bind:src="typeA3.src" alt="A3尺寸">
        </span>
        <p>三栏（A3尺寸）</p>
      </li>
    </ul>
  </div>
</template>

<script>
  //选择版式

  export default {
    name: "type-style",
    props: ["layout"],
    data: function () {
      return {
        typeA4: {
          src: "/Public/default/image/answer/formatA4.png"
        },
        typeA3: {
          src: "/Public/default/image/answer/formatA3.png"
        }
      }
    },
    methods: {
      chooseTypeA3: function () {
        this.typeA3.checked = true;
        this.typeA4.checked = false;
        app.data.layout.style = 'A3';
        app.dataState += 1;
      },
      chooseTypeA4: function () {
        this.typeA3.checked = false;
        this.typeA4.checked = true;
        app.data.layout.style = 'A4';
        app.dataState += 1;
      }
    }
  }
</script>
