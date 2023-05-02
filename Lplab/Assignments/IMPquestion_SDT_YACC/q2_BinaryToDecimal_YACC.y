/* C2: Use YACC to Convert Binary to Decimal (including fractional numbers). */
File: C2.y
/* definition section*/
%{
#include<stdio.h>
#include<stdlib.h>
#include<math.h>
//#define YYSTYPE double
void yyerror(char *s);
float x = 0;
%}
// creating tokens whose values are given by lex
%token ZERO ONE POINT
// following a grammer rule which is converting binary number to 
decimal number (float value)
%%
L: X POINT Y {printf("%f",$1+x);}
| X {printf("%d", $$);}
X: X B {$$=$1*2+$2;}
| B {$$=$1;}
Y: B Y {x=$1*0.5+x*0.5;}
| {;}
B:ZERO {$$=$1;}
|ONE {$$=$1;};
%%
// main function
int main()
{
printf("Enter the binary number : ");
// calling yyparse function which execute grammer rules and 
lex
while(yyparse());
printf("\n");
}
// if any error 
void yyerror(char *s)
{
fprintf(stdout,"\n%s",s);
}
2
File: C2.l
/* definitions */
%{
// including required header files
#include<stdio.h> 
#include<stdlib.h>
#include"y.tab.h"
// declaring a external variable yylval
extern int yylval;
%}
/* rules
if 0 is matched ,make yylval to 0 and return ZERO which is 
variable in Yacc program
if 1 is matched ,make yylval to 1 and return ONE which is 
variable in Yacc program
if . is matched ,return POINT which is variable in Yacc program
if line change , return 0
otherwise ,ignore*/
%%
0 {yylval=0;return ZERO;} 
1 {yylval=1;return ONE;} 
"." {return POINT;}
[ \t] {;}
\n return 0;
%%
