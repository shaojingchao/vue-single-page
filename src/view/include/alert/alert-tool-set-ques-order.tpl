<script type="text/html" id="tpl-set-ques-order">
    <span v-show="selectedAddedTestNum==1" class="unselect" style="vertical-align:-1px">
        <label>
            <input type="checkbox"
               style="vertical-align:-2px"
               v-model="toggleSetOrderID"
               v-bind:disabled="selectedAddedTestNum>1">设置题号
        </label>
        <span class="f12 text-muted" v-if="toggleSetOrderID">
            <input id="userSetOrderID" class="w5em center" type="number"
                   v-bind:value="computedOrderID"
               v-on:change="checkSetterOrderID">
            <a href="javascript:;" class="text-primary"
               v-on:mouseleave="hideSuggestOrderID"
               v-on:mouseenter="showSuggestOrderID"> 提示
            </a>
        </span>
    </span>
</script>
