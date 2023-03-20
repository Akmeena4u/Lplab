
10. LEX program which demonstrate the use of unput function

This function unput(a) puts or returns character a back into the input stream and it will be the nect character to be scanned.   

Example1

%{
    
%}

%%

“un” {
            printf(“\n The unput char = ”);
            ECHO;
         }

[a-z]+ {
             printf(“\n String contains only lower case letters= ”);
	 ECHO; unput(‘n’); unput(‘u’);
             printf(“\n The string after unput= ”); ECHO;
          } 

[a-zA-Z]+ {
                    printf(“\n String contains both lower & upper case letters= ”);
	        ECHO; 
                  } 
%%

main()
{
yylex();
}

$ ./a.out 
good Day

Example2

%{
    
#define YYLMAX 10

%}

%array yytext

%%

“un” {
            printf(“\n The unput char = ”);
            ECHO;
         }

[a-z]+ {
             printf(“\n String contains only lower case letters= ”);
	 ECHO; unput(‘n’); 
             printf(“\n The string after first unput= ”); ECHO;
             unput(‘u’);
             printf(“\n The string after second unput= ”); ECHO;
          } 

[a-zA-Z]+ {
                    printf(“\n String contains both lower & upper case letters= ”);
	        ECHO; 
                  } 
%%

main()
{
yylex();
}

$ ./a.out 
good Day










