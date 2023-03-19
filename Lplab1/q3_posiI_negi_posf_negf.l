


%{
//QUESTION 3: To count the type of numbers-- +integer, -ve integer, +ve fraction, -ve fraction
//Amit kumar meena 207206

#include<stdio.h>
int  posint=0 ,negint=0 , posif=0 , negf=0;

%}

DIGIT    [0-9]

%%

[-+]?{DIGIT}+      { /* integer */
                      if (atoi(yytext) > 0) {
                          posint++;
                      } else {
                          negint++;
                      }
                  }
[-+]?{DIGIT}*\.{DIGIT}+  { /* fraction */
                          if (atof(yytext) > 0) {
                              posif++;
                          } else {
                              negf++;
                          }
                      }
.|\n              


%%


int main(){

printf("Enter Numbers:");
yylex();
printf("positive integer: %d\nNegative integer: %d\nPositive Fraction : %d\nNegative Fraction :%d\n", posint, negint,posif,negf);

return 0;

}

int yywrap()  {}

