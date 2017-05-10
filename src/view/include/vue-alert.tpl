 <script type="text/x-template" id="modal-template">
        <transition name="modal">
            <div class="modal-mask">
                <div class="modal-wrapper">
                    <div class="modal-container" style="max-height:700px">

                        <div class="modal-header">
                            <slot name="header">
                                信息提示
                            </slot>
                        </div>

                        <div class="modal-body">
                            <slot name="body">
                                default body
                            </slot>
                        </div>

                        <div class="modal-footer">
                            <slot name="footer">
                                footer
                            </slot>
                        </div>
                    </div>
                </div>
            </div>
        </transition>
</script>
<script>
    Vue.component('modal', {
        template: '#modal-template'
    });
</script>