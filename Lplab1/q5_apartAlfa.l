%{
//QUESTION 5: To find if a character apart from alphabets occurs in a string.
//Amit kumar meena

#include<stdio.h>
int flag=0;
%}

%%

[^a-zA-Z\n]    {flag==1;}

%%

int main(){

printf("Enter the string\n");
yylex();

if(flag==0)  printf("There is all character belongs to alphabet only\n");
else      printf("There is other character also persent apart alphabets\n");

return 0;

}

int yywrap()   {}
