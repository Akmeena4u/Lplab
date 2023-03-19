%{

//Amit kumar meena 207206
//5. Lex program to check perfect numbers. Perfect number, a positive integer that is equal to the sum of its properdivisors, for example: 6 = 1+2+3.
#include <stdio.h>
int isPerfect(int num);
%}

%%

[0-9]+ { 
    int num = atoi(yytext);
    if (isPerfect(num)) {
        printf("%d is a perfect number.\n", num);
    } else {
        printf("%d is not a perfect number.\n", num);
    }
}

%%

int isPerfect(int num) {
    int sum = 0;
    for (int i = 1; i < num; i++) {
        if (num % i == 0) {
            sum += i;
        }
    }
    if (sum == num) {
        return 1;
    } else {
        return 0;
    }
}

int yywrap() {
    return 0;
}

int main() {
    yylex();
    return 0;
}
