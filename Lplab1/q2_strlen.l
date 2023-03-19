%{

//Amit kumar meena 207206


#include<stdio.h>
int len=0;
%}


%%

[a-z A-Z 0-9]+    {len=yyleng;}
.                 {}

%%

int main(){

printf("Enter the string ");

yylex();

printf("len of string is: %d\n",len);

}

int yywrap() {}
