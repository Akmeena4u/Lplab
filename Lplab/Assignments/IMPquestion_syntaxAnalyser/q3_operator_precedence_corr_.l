B6: Write a program to implement operator precedence parsing. (Precedence table construction and parsing from precedence table)


/* B6: Write a program to implement operator precedence parsing. (Precedence table 
construction and parsing from precedence table) */
#include<bits/stdc++.h>
using namespace std;
vector< pair<char,string> > p;
vector< pair<char,vector<char> > > leading_vector,trailing_vector;
vector<char> non_terminals;
vector<char> terminals;
map<char,int> m;
char table[20][20];
vector<char> tt[20][20];
int tab[20][20];
vector<char> v;
void parse_the_string();
void print_stack_contents(stack<pair<char,char> > s1);
int search(string s);
void f1(int i);
int findnon_terminals(char c);
bool is_nonterminals(char c);
bool is_terminals(char c);
int main()
{
 int n;
 char c;
 string s,str;
 cout<<"Enter the number of productions : \n";
 cin>>n;
 for(int i=0;i<n;i++)
 {
 cout<<"enter production A->BC as A 
BC:\n";
 cin>>c;
cin>>s;
p.push_back(make_pair(c,s));
 }
 for(int i=0;i<p.size();i++)
 {
 int x=1;
if(find(non_terminals.begin(),non_terminals.end(),p[i].first)==non_t
erminals.end())
 {
 
non_terminals.push_back(p[i].first);
vector<char> x,y;
leading_vector.push_back(make_pair(p[i].first,x));
trailing_vector.push_back(make_pair(p[i].first,y));
 }
 for(int j=0;j<p[i].second.size();j++)
2
 {
 
if(!is_nonterminals(p[i].second[j]) && 
find(terminals.begin(),terminals.end(),p[i].second[j])==terminals.en
d())
 {
 
terminals.push_back(p[i].second[j]);
 }
 }
 }
 //add $ as one of the terminals as it denotes end of 
input
 terminals.push_back('$');
 for(int i=0;i<terminals.size();i++)
 {
 m[terminals[i]]=i;
 }
 cout<<endl;
 
 for(int i=0;i<p.size();i++)
 {
 int k = findnon_terminals(p[i].first);
 
 if( !is_nonterminals(p[i].second[0]) )
{
 
leading_vector[k].second.push_back(p[i].second[0]);
 }
else if(is_nonterminals(p[i].second[0]))
{
 if(p[i].second[0] != 
p[i].first) { leading_vector[k].second.push_back(p[i].second[0]); }
if(p[i].second.size()>1 && 
!is_nonterminals(p[i].second[1])) { 
leading_vector[k].second.push_back(p[i].second[1]); }
 }
 
 int s = p[i].second.size();
if( !is_nonterminals(p[i].second[s-1]) )
{
 
trailing_vector[k].second.push_back(p[i].second[s-1]);
 }
else if(is_nonterminals(p[i].second[s1]))
 {
 if(p[i].second[s-1] != 
p[i].first) { trailing_vector[k].second.push_back(p[i].second[s-1]); 
}
 if(s>1 && 
!is_nonterminals(p[i].second[s-2])) { 
trailing_vector[k].second.push_back(p[i].second[s-2]); }
 }
 }
 
3
 int flag=1;
 while(flag)
 {
 flag=0;
for(int i=0;i<leading_vector.size();i++)
{
 for(int 
j=0;j<leading_vector[i].second.size();j++)
 {
 
if(is_nonterminals(leading_vector[i].second[j]))
{
 v.clear(); 
f1(i); flag=1;
 
leading_vector[i].second.clear();
for(int 
r=0;r<v.size();r++) { leading_vector[i].second.push_back(v[r]); }
v.clear();
break;
 }
 }
 }
 }
 
 flag=1;
 while(flag)
 {
 flag=0;
for(int 
i=0;i<trailing_vector.size();i++)
 {
 for(int 
j=0;j<trailing_vector[i].second.size();j++)
{
 
if(is_nonterminals(trailing_vector[i].second[j]))
{
 v.clear(); 
flag=1;
for(int 
r=0;r<trailing_vector[i].second.size();r++)
 {
 
if(r!=j) { v.push_back(trailing_vector[i].second[r]); }
 }
 int k = 
findnon_terminals(trailing_vector[i].second[j]);
 for(int 
r=0;r<trailing_vector[k].second.size();r++)
{
 
if(find(v.begin(),v.end(),trailing_vector[k].second[r])==v.end()) { 
v.push_back(trailing_vector[k].second[r]); }
 }
4
 
trailing_vector[i].second.clear();
 for(int 
r=0;r<v.size();r++) { trailing_vector[i].second.push_back(v[r]); }
 break;
 }
 }
 }
 }
 
 cout<<"leading_vector arrays are : \n";
 for(int i=0;i<leading_vector.size();i++)
 {
 cout<<leading_vector[i].first<<" : ";
for(int 
j=0;j<leading_vector[i].second.size();j++)
 {
 
cout<<leading_vector[i].second[j]<<" ";
 }
cout<<endl;
 }
 
 cout<<"trailing_vector arrays are : \n";
 for(int i=0;i<trailing_vector.size();i++)
 {
 cout<<trailing_vector[i].first<<" : ";
for(int 
j=0;j<trailing_vector[i].second.size();j++)
 {
 
cout<<trailing_vector[i].second[j]<<" ";
 }
cout<<endl;
 }
 
 memset(table,' ',400);
 memset(tab,0,400);
 
 for(int i=0;i<p.size();i++)
 {
 int l = p[i].second.size();
if(l>1)
{
 for(int j=0;j<l-1;j++)
 {
 vector<char> vz;
if(j<l-1 && 
!is_nonterminals(p[i].second[j]) && 
!is_nonterminals(p[i].second[j+1]) )
 {
 
table[m[p[i].second[j]]][m[p[i].second[j+1]]] = '=';
tab[m[p[i].second[j]]][m[p[i].second[j+1]]]++;
5
 
vz=tt[m[p[i].second[j]]][m[p[i].second[j+1]]];
 
if(find(vz.begin(),vz.end(),'=')==vz.end())
{
 
tt[m[p[i].second[j]]][m[p[i].second[j+1]]].push_back('=');
 }
 }
if(j<l-2 && 
!is_nonterminals(p[i].second[j]) && 
!is_nonterminals(p[i].second[j+2]) && 
is_nonterminals(p[i].second[j+1]))
 {
 
table[m[p[i].second[j]]][m[p[i].second[j+2]]] = '=';
tab[m[p[i].second[j]]][m[p[i].second[j+2]]]++;
vz=tt[m[p[i].second[j]]][m[p[i].second[j+2]]];
 
if(find(vz.begin(),vz.end(),'=')==vz.end())
 {
 
tt[m[p[i].second[j]]][m[p[i].second[j+2]]].push_back('=');
 }
 }
if(!is_nonterminals(p[i].second[j]) && 
is_nonterminals(p[i].second[j+1]))
 {
 int k = 
findnon_terminals(p[i].second[j+1]);
for(int 
r=0;r<leading_vector[k].second.size();r++)
 {
 
table[m[p[i].second[j]]][m[leading_vector[k].second[r]]] = '<';
 
tab[m[p[i].second[j]]][m[leading_vector[k].second[r]]]++;
 
vz=tt[m[p[i].second[j]]][m[leading_vector[k].second[r]]];
if(find(vz.begin(),vz.end(),'<')==vz.end())
{
 
tt[m[p[i].second[j]]][m[leading_vector[k].second[r]]].push_back('<')
;
 
}
 }
 }
6
 
if(is_nonterminals(p[i].second[j]) && 
!is_nonterminals(p[i].second[j+1]))
{
 int k = 
findnon_terminals(p[i].second[j]);
for(int 
r=0;r<trailing_vector[k].second.size();r++)
{
 
table[m[trailing_vector[k].second[r]]][m[p[i].second[j+1]]] = '>';
tab[m[trailing_vector[k].second[r]]][m[p[i].second[j+1]]]++;
 
vz=tt[m[trailing_vector[k].second[r]]][m[p[i].second[j+1]]];
 
if(find(vz.begin(),vz.end(),'>')==vz.end())
{
 
tt[m[trailing_vector[k].second[r]]][m[p[i].second[j+1]]].push_back('
>');
 
}
 }
 }
 } 
 }
 }
 
 int k = findnon_terminals(p[0].first);
 for(int i=0;i<leading_vector[k].second.size();i++)
 {
 vector<char> vz;
table[m['$']][m[leading_vector[k].second[i]]] = '<';
 
tab[m['$']][m[leading_vector[k].second[i]]]++;
 
vz=tt[m['$']][m[leading_vector[k].second[i]]];
 
if(find(vz.begin(),vz.end(),'<')==vz.end())
 {
 
tt[m['$']][m[leading_vector[k].second[i]]].push_back('<');
 }
 }
 for(int i=0;i<trailing_vector[k].second.size();i++)
 {
 vector<char> vz;
table[m[trailing_vector[k].second[i]]][m['$']] = '>';
 
tab[m[trailing_vector[k].second[i]]][m['$']]++;
7
 
vz=tt[m[trailing_vector[k].second[i]]][m['$']];
 
if(find(vz.begin(),vz.end(),'<')==vz.end())
 {
 
tt[m[trailing_vector[k].second[i]]][m['$']].push_back('>');
 }
 }
 
 cout<<"Table\n\n";
 int l = terminals.size();
 cout<<" ";
 for(int i=0;i<l;i++)
 {
 cout<<terminals[i]<<" ";
 }
 cout<<"\n\n";
 int ff=0; 
 for(int i=0;i<l;i++)
 {
 cout<<terminals[i]<<" ";
for(int j=0;j<l;j++)
{
 cout<<" ";
if(tt[i][j].size()>1) { ff=1; 
}
for(int 
e=0;e<tt[i][j].size();e++)
{
 cout<<tt[i][j][e];
 }
 cout<<" ";
 }
cout<<endl;
 }
 
 if(ff) { cout<<"Conflicts in table\n"; exit(0); }
 
 parse_the_string();
 return 0;
}
//identify if given character is a terminal
bool is_terminals(char c)
{
 if(c>='a' && c<='z') { return 1; }
 else { return 0; }
}
//identify if a given character is a non terminal
bool is_nonterminals(char c)
{
 if(c>='A' && c<='Z') { return 1; }
8
 else { return 0; }
}
//find index of given non terminal in vector of non terminals
int findnon_terminals(char c)
{
 for(int i=0;i<non_terminals.size();i++)
 {
 if(non_terminals[i]==c) { return i; }
 }
}
void f1(int i)
{
 for(int j=0;j<leading_vector[i].second.size();j++)
 {
 char l = leading_vector[i].second[j];
if(!is_nonterminals(l) && 
find(v.begin(),v.end(),l)==v.end()) { v.push_back(l); }
 }
 for(int j=0;j<leading_vector[i].second.size();j++)
 {
 char l = leading_vector[i].second[j];
if(is_nonterminals(l)) { 
f1(findnon_terminals(l)); }
 }
}
int search(string s)
{
 int k=-1;
 if(s.size()==2)
 {
 if(s[0]=='F') { return 3; }
else if(s[0]=='T') { return 1; }
 }
 for(int i=0;i<p.size();i++)
 {
 if(p[i].second.size()==s.size())
{
 int flag=1;
for(int 
j=0;j<p[i].second.size();j++)
 {
 
if(s[j]!=p[i].second[j]) { flag=0; break; }
 }
if(flag) { k=i; return k; }
 }
 }
 
 if(k==-1 && s.size()==3)
 {
9
 if(is_nonterminals(s[0]) && 
is_nonterminals(s[2]))
 {
 if(s[1]=='+') { return 0; }
else if(s[1]=='*') { return 2; 
}
 }
 }
 
 return k;
}
void print_stack_contents(stack<pair<char,char> > s1)
{
 if(!s1.empty())
 {
 char c = s1.top().first; s1.pop();
print_stack_contents(s1);
cout<<c;
 }
}
//parse an input string using the generated parse table
void parse_the_string()
{
 char start = p[0].first; 
 string input;
 cout<<"Enter the input string : ";
 cin>>input;
 stack< pair<char,char> > s;
 s.push(make_pair('$','$'));
 int i=0;
 while(1)
 {
 print_stack_contents(s);
cout<<" ";
for(int j=i;j<input.size();j++) { 
cout<<input[j]; }
 cout<<"$"<<endl;
 vector<char> handle;
if(s.size()==2 && s.top().first==start) 
{ break; }
 
 while(input[i]!='$' && 
table[m[s.top().second]][m[input[i]]]=='<' || 
table[m[s.top().second]][m[input[i]]]=='=' )
 {
 
s.push(make_pair(input[i],input[i])); i++;
 }
if(table[m[s.top().second]][m[input[i]]]==' ') { cout<<"error\n"; 
exit(0); }
 
10
 print_stack_contents(s);
cout<<" ";
for(int j=i;j<input.size();j++) { 
cout<<input[j]; }
 cout<<"$"<<endl;
 char x; int u;
while(s.size()>1 && 
(is_nonterminals(s.top().first)) )
 { handle.push_back(s.top().first); 
s.pop(); }
 handle.push_back(s.top().first); 
x=s.top().first;s.pop();
 
 while(1)
{
 if(s.size()>1 && 
is_nonterminals(s.top().first)) 
{ 
handle.push_back(s.top().first); s.pop(); }
else if(s.size()>1 && ( 
table[m[s.top().second]][m[x]]=='>' || 
table[m[s.top().second]][m[x]]=='=' ))
 { 
handle.push_back(s.top().first); x=s.top().first; s.pop(); }
 else if(s.size()==1 || 
table[m[s.top().second]][m[x]]=='<') { break; }
else if(s.size()>1 && 
table[m[s.top().second]][m[x]]==' ') { cout<<"error\n"; exit(0); }
 }
 
 string y="";
 for(int l=handle.size()-1;l>=0;l--) { 
y=y+handle[l]; }
 
 int pn = search(y);
if(pn==-1) { cout<<"errorinhandle\n"; 
exit(0); }
 
s.push(make_pair(p[pn].first,s.top().second));
 }
 cout<<"The string is accepted\n";
}
