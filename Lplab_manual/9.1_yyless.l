9. LEX program which demonstrate the use of yyless function

This function yyless(n) returns all characters, except the first n characters of the current tokens, back to the input stream, where they will be re-scanned when the scanner looks for the next match.
 
Example

%{
    
%}

%%

[a-z]+ {
             printf(“\n The string is= ”);
	 ECHO; 
             yyless(2); 
             printf(“ The string after yyless=  ”); ECHO;
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
Nice morning

