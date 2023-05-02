Write a YACC Program to recognize a valid variable, which starts with a letter, followed binary number of letters or digits.[10]

Yacc
%token DIGIT LETTER NL UND
%%
stmt : variable NL { printf(“Valid Identifiers\n”); exit(0);}
;
variable : LETTER alphanumeric
;
alphanumeric: LETTER alphanumeric
| DIGIT alphanumeric
| UND alphanumeric
| LETTER
| DIGIT
| UND
;
%%
int yyerror(char *msg)
{
printf(“Invalid Expression\n”);
exit(0);
}
main ()
{
printf(“Enter the variable name\n”);
yyparse();
}



% { #include “y.tab.h” % } 
%% [a-zA-Z]  
{  return LETTER ; }
 [0-9]  
{  return  DIGIT ;  }
 [\n]  {  return NL ; } 
[_]  {  return UND;  }
 .  {  return yytext[0];
  } %%

: Thus the program is executed successfully
