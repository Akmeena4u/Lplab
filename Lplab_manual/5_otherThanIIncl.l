%{
        int nw=0; 
%}

%%

incl  nw;
REJECT;
[^ \t\n]+ nw++;

%%

main(int argc, char* argv[ ])
{

Extern FILE* yyin;
yyin = fopen(argv[1],”r”);
yylex();
printf(“ No of occurrences of  other than words incl = %d\n”, nw);
return 0;
}

