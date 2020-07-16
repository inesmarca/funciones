#!/bin/bash

nasm -f elf32 $1.asm
gcc -c -m32 $2.c
gcc -m32 $1.o $2.o -o $2
rm $1.o
rm $2.o

