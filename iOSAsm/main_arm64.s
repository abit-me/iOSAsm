//
//  main_arm64.s
//  iOSAsm
//
//  Created by A on 2018/3/12.
//  Copyright © 2018年 A. All rights reserved.
//

;.section __TEXT,__text,regular,pure_instructions
;.ios_version_min 8, 0

.section __TEXT,__cstring

.text
.align 8
cstr_AppDelegate:
.asciz "AppDelegate"

.text
.align 8
hello_str:
.ascii "Hello, World!\n"

.text
.align 8
cstr_NSAutoreleasePool:
.asciz "NSAutoreleasePool"

.text
.align 8
cstr_alloc:
.asciz "alloc"

.text
.align 8
cstr_init:
.asciz "init"

.text
.align 8
cstr_drain:
.asciz "drain"

.global _main
.align 8
_main:
//bl hello

sub        sp, sp, #0x50
stp        x22, x21, [sp, #0x20]
stp        x20, x19, [sp, #0x30]
stp        x29, x30, [sp, #0x40]
add        x29, sp, #0x40
mov        x19, x1
mov        x20, x0
adr        x0, cstr_NSAutoreleasePool

bl         _objc_getClass
mov        x21, x0
adr        x0, cstr_alloc

bl         _sel_registerName
mov        x1, x0
mov        x0, x21
bl         _objc_msgSend
mov        x21, x0
adr        x0, cstr_init

bl         _sel_registerName
mov        x1, x0
mov        x0, x21
bl         _objc_msgSend
mov        x21, x0

adr        x8, cstr_AppDelegate

stp        xzr, x8, [sp, #0x8]
str        x19, [sp]
mov        x0, x20

mov x0, #0
mov x1, x8
mov x2, #0x0600 ; kCFStringEncodingASCII = 0x0600
bl _CFStringCreateWithCString

mov x3, x0
mov x2, #0
mov x1, #0
mov x0, #0

bl         _UIApplicationMain
adr        x0, cstr_drain                            ; "drain", argument "str" for method imp___stubs__sel_registerName

bl         _sel_registerName
mov        x1, x0                                      ; argument "selector" for method imp___stubs__objc_msgSend
mov        x0, x21                                     ; argument "instance" for method imp___stubs__objc_msgSend
bl         _objc_msgSend

movz       w0, #0x0
ldp        x29, x30, [sp, #0x40]
ldp        x20, x19, [sp, #0x30]
ldp        x22, x21, [sp, #0x20]
add        sp, sp, #0x50
ret

; UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
; CFStringCreateWithCString(CFAllocatorRef alloc, const char *cStr, CFStringEncoding encoding);
