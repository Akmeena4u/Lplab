%{
//QUESTION 4: To count the no of words, character, and lines.

//Amit kumar meena

#include<stdio.h>
int wordc=1 , charc=0 ,linec=0;
%}


%%
[ \t]          {wordc++;}
[a-zA-Z]       {charc++;}
\n             {linec++;}
.              {}

%%

int main(){

printf("Enter textual data\n");
yylex();
printf("Word_count: %d\nCharacter_count: %d\nLine_count : %d\n", wordc, charc,linec);

return 0;

}

int yywrap()  {}
