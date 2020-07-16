extern void print(const char * string);

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

int main(int argc, char *argv[]) {
    char buff[10];
    numToStr(buff, argc);
    print("Cantidad de argumentos: ");
    print(buff);
    print("\n");

    int i = 0;
    while(argv[i] != '\0') {
        numToStr(buff, i);
        print("argv[");
        print(buff);
        print("]: ");
        print(argv[i]);
        print("\n");
        i++;
    }
    return 0;
}
