%{
//Amit kumar meena
//2. LEX program to recognises the keyword if, begin and identifier which is defined as any string starts with letter and followed byletter or digit and count the number of identifiers, keywords and operators encountered in the input.
#include <stdio.h>
int id_count = 0;
int keyword_count = 0;
int operator_count = 0;
%}

%%
if          { printf("Keyword: if\n"); keyword_count++; }
begin       { printf("Keyword: begin\n"); keyword_count++; }
[+-/*=]     { printf("Operator: %s\n", yytext); operator_count++; }
[a-zA-Z][a-zA-Z0-9]*    { printf("Identifier: %s\n", yytext); id_count++; }
[ \t\n]     
.           
%%

int main() {
    yylex();
    printf("Number of identifiers: %d\n", id_count);
    printf("Number of keywords: %d\n", keyword_count);
    printf("Number of operators: %d\n", operator_count);
    return 0;
}
