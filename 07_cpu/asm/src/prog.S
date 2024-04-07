.text
.globl _start
.globl _finish

.macro halt
    ebreak
.endm

_start:
    xori x5,  x0,  11
    ori  x6,  x0,  12
    add  x7,  x5,  x6
    or   x8,  x7,  x6
    li   x11, 0x52
    li   x7,  0x10
    sw   x11, 0x10(x7)

_finish:
    halt
