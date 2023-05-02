2. Write a program in YACC to convert binary to decimal (including
fractional numbers)



LEX.l

%{
#include<stdio.h>
#include<stdlib.h>
#include"y.tab.h"
extern int yylval;
%}
%%
0 {yylval=0;return ZERO;}
1 {yylval=1;return ONE;}
[ \t] {;}
\n return 0;
. return yytext[0];
%%
int yywrap()
{
return 1;
}














Yacc:











%{
#include<stdio.h>
#include<stdlib.h>
void yyerror(char *s);
%}
%token ZERO ONE
%%
NUMBER: L {printf("\nDecimal number = %d\n", $$);}
L: L B {$$=$1*2+$2;}| B {$$=$1;}
B:ZERO {$$=$1;}
|ONE {$$=$1;};
%%
int main()
{
printf("Enter the binary number: ");
while(yyparse());
}
yyerror(char *s)
{
fprintf(stdout, "\nERROR : %s", s);
}
