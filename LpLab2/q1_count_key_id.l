%{
//Amit kumar meena 207206
//1. LEX program to recognises the keyword if, begin and identifier which is defined as any string starts with letter and followed by letter or digit.
#include <stdio.h>
%}

%%
if          printf("Keyword: if\n");
begin       printf("Keyword: begin\n");
[a-zA-Z][a-zA-Z0-9]*    printf("Identifier: %s\n", yytext);
%%

int main() {
    yylex();
    return 0;
}
