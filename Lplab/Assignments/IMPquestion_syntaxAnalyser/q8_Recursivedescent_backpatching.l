1
/* B2: Write a program to implement: Recursive Descent Parsing with back tracking 
(Brute Force Method)
(a) 
S aaSaa aa  | 
(b)
S aaaSaaa aa  | 
(c) 
S aaaaSaaaa aa  |
(d) 
S aaaSaaa aa  | aSa |
Record the tracing and submit the video to show it is using Backtracking and working 
with other alternatives. */
File: B2.cpp
/* S->aaSaa | aa */
#include<bits/stdc++.h>
using namespace std;
int curr;
//??
int S(char b[],int l)
{
//match with aa
char prod[20];
int isave=curr;
strcpy(prod,"aaSaa");
if(curr<l && b[curr]=='a')
{
curr++;
if(curr<l && b[curr]=='a')
{
curr++;
//recursive call to match S
if(S(b,l))
{
if(curr<l && b[curr]=='a')
{
curr++;
if(curr<l && b[curr]=='a')
{
curr++;
return 1;
}
}
}
}
}
//match with aa
strcpy(prod,"aa");
curr=isave;
if(curr<l && b[curr]=='a')
2
{
curr++;
if(curr<l && b[curr]=='a')
{
curr++;
return 1;
}
}
return 0;
}
int main()
{
curr=0;
char a[500];
cout<<"Enter the string : ";
cin.getline(a,500,'\n');
int l=strlen(a);
cout<<"length = "<<l<<endl;
if(S(a,l) && curr==l)
{
cout<<"Accepted\n";
}
else
{
cout<<"Not Accepted\n";
}
return 0;
}
3
4
File: B2_a.cpp
#include<bits/stdc++.h>
using namespace std;
int i;
//??
//tries all possible centres recursively and try to match the 
string
int S(char b[],int l)
{
int isave=i;
//match with aa
if(i<l && b[i]=='a')
{
i++;
if(i<l && b[i]=='a')
{
i++;
//match with S recursively
if(S(b,l))
{
//match with aa
if(i<l && b[i]=='a')
{
i++;
if(i<l && b[i]=='a')
{
i++;
return 1;
}
}
}
}
}
i=isave;
//match with middle aa
if(i<l && b[i]=='a')
{
i++;
if(i<l && b[i]=='a')
{
i++;
return 1;
}
}
return 0;
}
int main()
{
5
i=0;
char a[500];
memset(a,'\0',500);
for(int j=0;j<400;j++)
{
a[j]='a';
i=0;
if(S(a,j+1) && i==j+1)
{
cout<<j+1<<" ";
}
}
return 0;
}
6
File: B2_b.cpp
#include<bits/stdc++.h>
using namespace std;
int i;
//??
//checks for grammer S->aaaSaaa | aa
//tries all possible centres recursively and try to match the 
string
int S(char b[],int l)
{
int isave=i;
//match with aaa
if(i<l && b[i]=='a')
{
i++;
if(i<l && b[i]=='a')
{
i++;
if(i<l && b[i]=='a')
{
i++;
//match with S recursively
if(S(b,l))
{
//match with aaa
if(i<l && b[i]=='a')
{
i++;
if(i<l && b[i]=='a')
{
i++;
if(i<l && b[i]=='a')
{
i++;
return 1;
}
}
}
}
}
}
}
i=isave;
//match with middle aa
if(i<l && b[i]=='a')
{
i++;
if(i<l && b[i]=='a')
7
{
i++;
return 1;
}
}
return 0;
}
int main()
{
i=0;
char a[500];
memset(a,'\0',500);
for(int j=0;j<400;j++)
{
a[j]='a';
i=0;
if(S(a,j+1) && i==j+1)
{
cout<<j+1<<" ";
}
}
return 0;
}
8
File: B2_c.cpp
#include<bits/stdc++.h>
using namespace std;
int i;
//??
//checks for grammer S->aaaaSaaaa | aa
//tries all possible centres recursively and try to match the 
string
int S(char b[],int l)
{
int isave=i;
//match with aaaa
if(i<l && b[i]=='a')
{
i++;
if(i<l && b[i]=='a')
{
i++;
if(i<l && b[i]=='a')
{
i++;
if(i<l && b[i]=='a')
{
i++;
//match with S recursively
if(S(b,l))
{
//match with aaaa
if(i<l && b[i]=='a')
{
i++;
if(i<l && b[i]=='a')
{
i++;
if(i<l && b[i]=='a')
{
i++;
if(i<l && 
b[i]=='a')
{
i++;
return 1;
}
}
}
}
}
}
}
}
9
}
i=isave;
//match with middle aa
if(i<l && b[i]=='a')
{
i++;
if(i<l && b[i]=='a')
{
i++;
return 1;
}
}
return 0;
}
int main()
{
i=0;
char a[500];
memset(a,'\0',500);
for(int j=0;j<400;j++)
{
a[j]='a';
i=0;
if(S(a,j+1) && i==j+1)
{
cout<<j+1<<" ";
}
}
return 0;
}
10
File: B2_d.cpp
#include<bits/stdc++.h>
using namespace std;
int i;
//??
//checks for grammer S->aaaSaaa | aSa | aa
//tries all possible centres recursively and try to match the 
string
int S(char b[],int l)
{
int isave=i;
//match with aaa
if(i<l && b[i]=='a')
{
i++;
if(i<l && b[i]=='a')
{
i++;
if(i<l && b[i]=='a')
{
i++;
//match with S recursively
if(S(b,l))
{
//match with aaa
if(i<l && b[i]=='a')
{
i++;
if(i<l && b[i]=='a')
{
i++;
if(i<l && b[i]=='a')
{
i++;
return 1;
}
}
}
}
}
}
}
i=isave;
//match with a
if(i<l && b[i]=='a')
{
i++;
//match with S recursively
11
if(S(b,l))
{
//match with a
if(i<l && b[i]=='a')
{
i++;
return 1;
}
}
}
i=isave;
//match with middle aa
if(i<l && b[i]=='a')
{
i++;
if(i<l && b[i]=='a')
{
i++;
return 1;
}
}
return 0;
}
int main()
{
i=0;
char a[500];
memset(a,'\0',500);
for(int j=0;j<400;j++)
{
a[j]='a';
i=0;
if(S(a,j+1) && i==j+1)
{
cout<<j+1<<" ";
}
}
return 0;
}
12
