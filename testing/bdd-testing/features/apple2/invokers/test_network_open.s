        .export     _main
        .export     t_devicespec
        .export     t_mode
        .export     t_translate
        .export     t_cb
        .export     t_cb_executed

        .import     _network_open
        .import     pusha
        .import     pushax
        .import     return0
        .import     spe_cb

        .include    "macros.inc"

.proc _main
        ; setup callback
        mwa     #t_cb, spe_cb

        ; call function under test
        pushax  t_devicespec
        pusha   t_mode
        lda     t_translate
        jmp     _network_open
.endproc


.proc t_cb
        ; the callback for the open routine.
        ; set some values for out test to detect
        inc     t_cb_executed

        jmp     return0
.endproc

.bss
t_devicespec:   .res 2
t_mode:         .res 1
t_translate:    .res 1

.data
t_cb_executed:  .byte 0