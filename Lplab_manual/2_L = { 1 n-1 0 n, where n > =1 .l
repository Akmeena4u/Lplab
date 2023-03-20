%{
int check(int,char*);
%}

%%
[ab]* {
        int leng=check(yyleng,yytext);

       if(leng==1)
       printf("\n accepted\n");
        else
        printf("\n not accepted\n");
    }
%%
main()
{
 yylex();
}

int check(int leng,char*token)
{
 int i, flag=0,c0=0,c1=0;
char ch;

for(i=1,ch=token[0]; ch=='1' && i<leng; i++)
{
 c1++;
 ch=token[i];
}
for(i=c1;ch=='0'&& i<leng; i++)
{
C0++;
ch=token[i];
}
if(((c0 + 1 ) = = c1) && (c0 + c1) = =leng))
flag=1;
return(flag);
}



