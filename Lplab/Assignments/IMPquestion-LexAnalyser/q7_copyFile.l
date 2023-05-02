/* A5: Write a LEX program that copies file, replacing each 
nonempty sequence of white spaces by a single blank */
File: A5.l
s[ ]
%%
[ ]([ ])* { /* Pattern for recognizing multiple spaces */
 fprintf(yyout," "); 
 }
([ ])*(\n)([ ])* { /* spaces followed by newline followed by 
spaces */
 fprintf(yyout," "); 
}
%%
int main()
{
// Point yyin to a file with text, this acts as input to 
our program
 yyin = fopen("A5_input.txt","r");
// Point yyout to output file. 
yyout = fopen("A5_output.txt","w"); 
 yylex();
 return 0;
}
----------------------------------------------------------------
File: A5_input.txt
Hello, Friends
Service to humanity
is
service to divinity.
If
 you
 don't
 know
 how 
 compiler works,
then
 you don't
know how
2
 computer works
