

%{

//Amit kumar meena --207206
#include<stdio.h>
int vowel_count = 0;
int consonant_count = 0;
%}

%%

[AaEeIiOoUu]   { vowel_count++; }
[^AaEeIiOoUu]] { consonant_count++; }
.              {}

%%

int main()
{

    printf(" Enter the input string ");
    yylex();
    printf("Vowel count: %d\nConsonant count: %d\n", vowel_count, consonant_count);
    return 0;
   
}


int yywrap() {}


