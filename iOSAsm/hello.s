.globl	hello
.p2align	2

hello:

sub	    sp, sp, #32            ; =32
stp	    x29, x30, [sp, #16]     ; 8-byte Folded Spill
add	    x29, sp, #16            ; =16
stur    wzr, [x29, #-4]
adrp    x0, l.str@PAGE
add	    x0, x0, l.str@PAGEOFF
bl      _printf
mov     w8, #0
str     w0, [sp, #8]            ; 4-byte Folded Spill
mov     x0, x8
ldp     x29, x30, [sp, #16]     ; 8-byte Folded Reload
add     sp, sp, #32             ; =32
ret

.section	__TEXT,__cstring,cstring_literals
l.str:
.asciz	"Hello world!\n"


//.subsections_via_symbols

