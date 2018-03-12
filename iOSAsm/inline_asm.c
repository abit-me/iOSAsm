//
//  inline_asm.c
//  iOSAsm
//
//  Created by A on 2018/3/12.
//  Copyright © 2018年 A. All rights reserved.
//

// https://blog.noctua-software.com/arm-asm.html
// http://www.ethernut.de/en/documents/arm-inline-asm.html
// http://shervinemami.info/armAssembly.html
// http://shervinemami.info/arm64bit.html

#include "inline_asm.h"

//#ifdef __arm64__
#if defined(__LP64__) || defined(__arm64__)

long add_two_int(long x, long y) {
    
    long ret = 0;
    asm volatile (
                  "add %[ret], %[x], %[y]"
                  : [ret]"=r"(ret)
                  : [x]"r"(x), [y]"r"(y)
    );
    return ret;
}

#else

__attribute__((__naked__))
static int add_two_int(int x, int y) {
    int ret;
    asm volatile (
                  "add %[ret], %[x], %[y]"
                  // outputs
                  : [ret]"=r"(ret)
                  // inputs
                  : [x]"r"(x), [y]"r"(y)
                  );
    return ret;
}
#endif

#if defined __arm__ && defined __ARM_NEON__

static void div_by_2(int16_t *x, int n)
{
    assert(n % 8 == 0);
    assert(x % 16 == 0);
    asm volatile (
                  "Lloop:                         \n\t"
                  "vld1.16    {q0}, [%[x]:128]    \n\t"
                  "vshr.s16   q0, q0, #1          \n\t"
                  "vst1.16    {q0}, [%[x]:128]!   \n\t"
                  "sub        %[n], #8            \n\t"
                  "cmp        %[n], #0            \n\t"
                  "bne Lloop                      \n\t"
                  // output
                  : [x]"+r"(x), [n]"+r"(n)
                  :
                  // clobbered registers
                  : "q0", "memory"
                  );
}

#else

static void div_by_2(int16_t *x, int n)
{
    int i;
    for (i = 0; i < n; i++)
        x[i] /= 2;
}

#endif
