//1. Write a lex specification to generate a scanner that will take a decimal between 1 to 999 in words and prints its numeric value as output.


%{
#include <stdio.h>
#include <string.h>
int num=0;
%}
%%
[Oo]ne {num+=1;}
[Tt]wo {num+=2;}
[Tt]hree {num+=3;}
[Ff]our{num+=4;}
[Ff]ive {num+=5;}
[Ss]ix {num+=6;}
[Ss]even {num+=7;}
[Ee]ight {num+=8;}
[Nn]ine {num+=9;}
[Tt]en {num+=10;}
[Ee]leven {num+=11;}
[Tt]welve {num+=12;}
[Tt]hirteen {num+=13;}
[Ff]ourteen {num+=14;}
[Ff]ifteen {num+=15;}
[Ss]ixteen {num+=16;}
[Ss]eventeen {num+=17;}
[Ee]ighteen {num+=18;}
[Nn]ineteen {num+=19;}
[Tt]wenty {num+=20;}
[Tt]hirty {num+=30;}
[Ff]orty {num+=40;}
[Ff]ifty{num+=50;}
[Ss]ixty {num+=60;}
[Ss]eventy {num+=70;}
[Ee]ighty {num+=80;}
[Nn]inety {num+=90;}
[Hh]undred {num*=100;}
[\n] {
printf("Number: %d\n\n", num);
num=0;
}
. {;}
%%
int yywrap(){}
int main()
{
printf("Enter Numbers:\n");
yylex();
return 0;
}
