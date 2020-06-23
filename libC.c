#include <stdio.h>

int strcmp(char * s1, char * s2) {
    int cmp = 1;
    int i;
    for ( i = 0; s1[i] != 0 && s2[i] != 0 && cmp; i++) {
        if (s1[i] != s2[i]) {
            cmp = 0;
        }
    }

    if ((s1[i] == 0 && s2[i] != 0) || (s1[i] != 0 && s2[i] == 0) ) {
        cmp = 0;
    }
    return cmp;
}

void numToStr(char * str, int num) {
    int dim = 0;
    if (num == 0) {
        str[dim++] = num + '0';
    }

    while (num != 0) {
        int res = num % 10;
        str[dim++] = res + '0';
        num /= 10;
    }
    int i = 0;
    int j = dim - 1;
    while (i < j) {
        char aux = str[i];
        str[i] = str[j];
        str[j] = aux;
        j--;
        i++;
    }
    str[dim] = 0;
}

int strToNum(char * str) {
    int x = 0;
    while (*str != 0) {
        x += *str++ - '0';
        if (*str != 0) x *= 10;
    }
    return x;
}

void orderArray(int * array, int dim) {
    int j, min;
    for (int i = 0; i < dim; i++) {
        j = i;
        min = i;
        while (j < dim) {
            if (array[min] > array[j]) min = j;
            j++;
        }
        int aux = array[i];
        array[i] = array[min];
        array[min] = aux;
    }
}