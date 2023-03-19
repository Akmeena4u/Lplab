%{

//Amit kumar meena
//9. Lex Program For checking a valid URL
#include <stdio.h>
%}

%%
^(http|https|ftp)://[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,}(\/\S*)? { printf("Valid URL: %s\n", yytext);}
.|\n {}
%%

int main() {
    yylex();
    return 0;
}
