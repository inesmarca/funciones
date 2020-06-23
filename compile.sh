#!/bin/bash

nasm -f elf64 $1.asm
nasm -f elf64 $2.asm
ld $2.o $1.o -o $1
rm $2.o
rm $1.o

