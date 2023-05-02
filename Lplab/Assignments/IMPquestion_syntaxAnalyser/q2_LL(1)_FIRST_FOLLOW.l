Write a program to implement

Write a program to find FIRST
Write a program to find FOLLOW
Implementation of LL(1) Parsing Table
Give the parsing process to show that it is neither use backtracking nor using other alternatives.



File: B4_a.cpp
#include<stdio.h>
#include<conio.h>
#include<string.h>
#include<ctype.h>
void first(int ,int );
void format();
int n,i,m;
char a[10][10],ans[10][10];
//-----------Main program-----------
int main()
{
 int j;
 //clrscr();
 printf("Enter no of productions(epsilon (@)):");
 scanf("%d",&n);
for(i=1;i<=n;i++)
 {
 printf("Enter the production no %d:",i);
 scanf("%s",a[i]);
 }
//---calling the recursive function for each terminal(first)--------
 for(i=1;i<=n;i++)
 {
 m=0;
 first(i,0);
 }
//----displaying the productions-------------
 //clrscr();
 printf("The productions are:");
 for(i=1;i<=n;i++)
 printf("\n%s",a[i]);
 printf("\n-------------------------------");
//---------formatting the answer---------
 format();
//--------displaying the result--------------
for(i=1;i<=n;i++)
 if(a[i][0]!=' ')
 {
2
 printf("\nfirst(%c)",a[i][0]);
 for(j=0;j<=strlen(a[i]);j++)
 if(ans[i][j]!=' ')
 printf("%4c",ans[i][j]);
 }
getch();
}
// ---------End of main program--------------
// Recursive function first()------------
void first(int x,int y)
{
 int j,l=3;
 for(j=1;j<=n;j++)
 {
 if(a[j][0]==a[x][y])
 {
if(!isupper(a[j][l]) && a[j][l]!='@')
 {
 ans[i][m++]=a[j][l];
 }
else if (a[j][l]=='@')
{
 if(a[x][y+1]!='\0' && y!=0)
 {
 if(isupper(a[x][y+1]))
 first(x,y+1);
 else
 ans[i][m++]=a[x][y+1];
 }
else ans[i][m++]='@';
} //inner if
 else first(j,l);
 }//outer if
}//for
}
//-----------------end of function first()---------
// Formatting the answer
void format()
{
 int j,l,k;
 for(i=1;i<=n;i++)
 for(j=i+1;j<=n;j++)
 if(a[i][0]==a[j][0])
a[j][0]=' ';
 for(i=1;i<=n;i++)
 for(j=1;j<=strlen(ans[i]);j++)
3
 for(k=j+1;k<=strlen(ans[i]);k++)
if(ans[i][j]==ans[i][k])
 ans[i][k]=' ';
}
//------------------End of the program--------------





File: B4_b.cpp
#include<stdio.h>
#include<conio.h>
#include<ctype.h>
#include<string.h>
char p[10][10],fol[10][10];
int i,n,m;
void follow(int ,int );
void first(int , int );
//-----------Main program-----------
int main()
{
//clrscr();
printf("Enter no of productions:");
scanf("%d",&n);
for(i=1;i<=n;i++)
4
{
printf("Enter production no %d:",i);
scanf("%s",p[i]);
}
m=0;
for(i=1;i<=n;i++,m=0)
follow(i,0);
for(i=1;i<=n;i++)
printf("\nfollow(%c):%s",p[i][0],fol[i]);
getch();
}
//function to find follow
void follow(int x,int y)
{
int u,v;
if(p[x][y]==p[1][0]) fol[i][m++]='$';
for(u=1;u<=n;u++)
for(v=3;v<strlen(p[u]);v++)
if(p[u][v]==p[x][y])
{
if(islower(p[u][v+1])) fol[i][m++]=p[u][v+1];
else if(isupper(p[u][v+1]))
first(u,v+1);
else
follow(u,0);
}
}
//function to find first
void first(int x,int y)
{
int u,v;
for(u=1;u<=n;u++)
if(p[u][0]==p[x][y])
{
if(islower(p[u][3])) fol[i][m++]=p[u][3];
else first(u,3);
}
}
