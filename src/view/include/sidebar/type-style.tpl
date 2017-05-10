<script type="text/html" id="tpl-type-style">
    <div class="panel-order format">
        <ul>
            <li id="tabA4" v-on:click="chooseTypeA4">
                <span v-bind:class="['format-img',{'choice':layout.style=='A4' || layout.style==null}]"><img v-bind:src="typeA4.src" alt="A4尺寸"></span>
                <p>一栏（A4尺寸）</p>
            </li>
            <li id="tabA3" v-on:click="chooseTypeA3">
                <span v-bind:class="['format-img',{'choice':layout.style=='A3'}]"><img v-bind:src="typeA3.src" alt="A3尺寸"></span>
                <p>三栏（A3尺寸）</p>
            </li>
        </ul>
    </div>
</script>