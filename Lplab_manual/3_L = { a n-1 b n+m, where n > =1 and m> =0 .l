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
 int i, flag=0,ca=0,cb=0;
char ch;

for(i=1,ch=token[0]; ch=='a' && i<leng; i++)
{
 ca++;
 ch=token[i];
}
for(i=ca,ch=token[ca];ch=='b'&& i<leng; i++)
{
cb++;
ch=token[i];
}
if(((ca < cb) && (ca+cb)==leng))
flag=1;
return(flag);
}

