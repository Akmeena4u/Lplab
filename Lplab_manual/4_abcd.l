//22. Lex program which take string  “abcd ”  and print the following output

abcd
abc
ab
a



%{
        
%}

%%
a | ab | abc | abcd {
                                 printf(“%s\n”, yytext);
                                 REJECT;
                              }
%%

main(int argc, char* argv[ ])
{

Extern FILE* yyin;
yyin = fopen(argv[1],”r”);
yylex();
return 0;
}
