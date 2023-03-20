%{
    
%}

%%

[a-zA-Z0-9]+ {
                            printf(“\n String contains mixed letters= ”);
	                ECHO; 
                        } 
“/*” {
            printf(“\n The comment begins ”);
            char c;
            while(( c=input() )!= ‘*’);
	if ((c=input()) = = ’/’)
                     printf(“\n The comment ends ”);
           
%%

main()
{
yylex();
}
$ ./a.out 
This program is written by /* Name */













