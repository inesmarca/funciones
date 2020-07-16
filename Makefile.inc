GCC=gcc
LD=ld
AR=ar
ASM=nasm

GCCFLAGS= -Wall -nostdlib -fno-common -std=c99 -m32
ARFLAGS=rvs
ASMFLAGS= -felf32
LDFLAGS= -melf_i386
