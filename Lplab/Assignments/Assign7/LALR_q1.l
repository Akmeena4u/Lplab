/* C1: Write a program to design LALR parsing using YACC */


File: C1.y

%{ 
 /* Definition section */
 #include <ctype.h> 
 #include<stdio.h>
 #include<stdlib.h>
%} 
%token digit
/* Rule Section */
%% 
/*After Evaluating the expression E,S prints Reached*/
S: E {printf("Reached\n\n");}
;
/*The expression parser uses three different symbols T,F and P, to 
set the
 precedence and associativity of operators*/
E: E '+' T 
| E '-' T 
| T 
; 
T: T '*' P 
| T '/' P 
| P 
; 
P: F '^' P 
| F 
;
F: '(' E ')'
 | digit 
 ;
%% 
 
//driver code 
int main()
{ 
 printf("Enter infix expression: "); 
 yyparse(); 
} 
yyerror()
{
 printf("NITW Error"); 
} 





File: C1.l


%{
 #include "y.tab.h"
 extern int yylval;
%}
%%
//If the token is an Integer number,then return it's value.
[0-9]+ {yylval=atoi(yytext); return digit;}
//If the token is space or tab,then just ignore it.
[\t] ;
//If the token is new line,return 0.
[\n] return 0;
//For any other token, return the first character read since the last 
match.
. return yytext[0];
%%
