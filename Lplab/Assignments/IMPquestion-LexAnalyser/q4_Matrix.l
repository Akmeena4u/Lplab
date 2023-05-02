/* A10: Suppose an image is encodes as an n×m matrix M of ''light intensifies.'' Mij is a 
number from 0 to 15, with 0=black and 15=white. M may be stored row by row, with 
rows terminated by newline (n) characters. Call this string vM. For example, if M is
0 0 2 6
0 1 4 7
1 8 8 6
then vM is 0026 n 0147 n 1886. We can also encode M by its differences along rows, dM. 
For Example, for M above dM is 0+2+4 n +1+3+3 n+70-2. If we replace positive 
numbers by + and negative numbers by - in dM we get the sequence of changes, d'M. In 
this case, d'M=0++ n +++ n +0-. Suppose a ‘feature’ is defined to be a nonempty 
sequence of increasing value of intensity, followed by zero to three unchanging value of 
intensity followed by at least one decreasing value of intensity, all on one row.
a. Write a LEX program to find maximal features in d'M and surround them by 
parentheses. A maximal feature is not a proper substring of any other feature.
b. Display the longest maximal feature of each row. */
File: A10_1.l
digit [0-9]
newline [\n]
char [a-zA-Z_]
%{
/* This program is divided into two lex programs. This 
program is for encoding the numbers into +,-,0 notation 
 Input file is read and the encoded string is written 
into another textfile which acts as input for the second lex 
program.
*/
int i;
// File pointer for output file.
FILE* fd;
%}
%%
({digit})* {
// if it is a digit stream, encode.
char prev='\0';
// In every iteration the previous value is remembered and 
the difference is taken and appropriate symbol is retrieved.
for(i=0;i<yyleng;i++)
{ if(yytext[i]==' ')continue;
if(yytext[i]!='\n'&&prev!='\0')
{
int ans=yytext[i]-prev;
// If difference is 0 the encode it as '0', if 
difference is positive encode as '+' and '-' otherwise.
2
if(ans==0){fprintf(fd,"0");}
else if(ans>0)fprintf(fd,"+");
else fprintf(fd,"-");
}
else if(yytext[i]=='\n')
{
fprintf(fd,"\n");
prev='\0';continue;
}
prev=yytext[i];
}
}
{newline} {fprintf(fd,"\n");}
%%
int main(int argc, char const *argv[])
{
yyin=fopen("./A10_input.txt","r");
fd=fopen("./A10_text_in_plus.txt","w");
yylex();
return 0;
}
------------------------------------------------------------------------------------------------------------
File: A10_2.l
digit [0-9]
plus [+]
minus [-]
char [a-zA-Z_]
newline [\n]
%{
// This is the second lex program. It extracts the required 
features.
#include <bits/stdc++.h>
using namespace std;
int i;
vector<string> str_arr;
vector<string> overall_arr;
%}
%%
{plus}+(0|00|000){minus}+ {
// Found a feature in a row so store it in an 
array.
str_arr.push_back(yytext);
}
{newline} {
// End of a row so find the maximal feature for that row.
for (int j= 0; j< str_arr.size(); ++j)
{
3
//cout<<str_arr[j]<<" part\n";
overall_arr.push_back(str_arr[j]);
int flag=0;
/* Iterate through the entire array and check whether 
the current feature is a maximal feature or not, 
 i.e check if it is a substring of other feature, if 
no then it is a maximal feature for that row.
*/
for (int i = 0; i < str_arr.size(); ++i)
{
// Substring check
if(i!=j&&str_arr[i]!=str_arr[j]&&
str_arr[i].find(str_arr[j])!=string::npos)
{flag=1;break;}
}
if(flag==0)cout<<str_arr[j]<<" is maximal 
feature\n";
}
// Row is done, clear the array.
str_arr.clear();
int max=-1;
string ans="";
//cout<<overall_arr.size();
// Among the features find the one with the highest length, 
which is the overall maximum.
for (int i = 0; i < overall_arr.size(); ++i)
{
int temp=overall_arr[i].length();;
if(temp>max){max=overall_arr[i].length();ans=overall_arr[i]
;}
}
cout<<"Overall maximum length feature is "<<ans<<endl;
}
0*|{plus}*|{minus}* { }
%%
int main(int argc, char const *argv[])
{
yyin=fopen("./A10_text_in_plus.txt","r");
yylex();
return 0;
}
------------------------------------------------------------------------------------------------------------
File: A10_input.txt
234421567776543
234432348864310
