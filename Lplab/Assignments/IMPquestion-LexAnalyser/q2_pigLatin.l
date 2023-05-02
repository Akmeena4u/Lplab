/* A6: Write a LEX program that converts a file to “Pig Latin”. 
Specifically, assume the file is a sequence of words (groups of 
letters) separated by whitespace. Every time you encounter a word:
(a) If the first letter is a consonant, move it to the end of the word 
and then add ay.
(b) If the first letter is a vowel, just add ay to the end of the word.
All non-letters are copied intact to the output. */
File: A6.l
c[a-zA-Z]
vowel[aeiouAEIOU]
cons[^aeiouAEIOU]
%%
{vowel}{c}* {
/* First character is vowel */
/* copy yytext into an array and append "ay" to it */
char s[100]; 
strcpy(s,yytext); 
strcat(s,"ay"); 
printf("%s ",s); 
fprintf(yyout,"%s",s); 
 }
{c}{c}* { 
/* First character is consonant */
/* copy yytext into an array except first character 
and then add the first character and append "ay" to it */
char s[100]; 
strcpy(s,yytext+1); 
printf("%s%cay ",s,yytext[0]); 
fprintf(yyout,"%s%cay",s,yytext[0]); 
}
%%
int main()
{
 printf("The output is : \n");
 yyin = fopen("A6_input.txt","r");
 yyout = fopen("A6_outputfile1.txt","w");
 yylex();
 printf("\n\n\n\n\n");
 fclose(yyin);
 fclose(yyout);
 yyin = fopen("A6_outputfile1.txt","r");
2
 yyout = fopen("A6_outputfile2.txt","w");
 yylex();
 printf("\n");
 return 0;
}
------------------------------------------------------------------------------------------------------------
File: A6_input.txt
Many of Lifes failures are people who did not realize how close 
they were to success when they gave up- Thomas Edison
