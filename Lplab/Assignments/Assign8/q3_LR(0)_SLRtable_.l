Write a program to find LR(0) items for the following
expression grammar and
construct SLR table assuming that the operators ‘+’
and ‘*’ are right associative and
+ has higher precedence than *
E → E + E | E * E | (E) | id

CODE :-
#include<bits/stdc++.h>
#include<unistd.h>
#include<fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
using namespace std;
struct slrEntry
{
map<char,vector<string> > action;
map<char,int> go2;
};
vector<slrEntry> table;
vector<vector<string> > grammar(26);
map<vector<vector<string> >,pair<int,bool> > itsets; //lr 0 item sets
int cntitsets = 0;
vector<set<char> > first(26),follow(26);

void printGr()
{

for(int j = 0; j < 26; j++)
{
for(int i=0;i<grammar[j].size();i++)
cout<<(char)(j+'A')<<" -> "<<grammar[j][i]<<"\n";

}
}
void printItsets(){
for(map<vector<vector<string> >,pair<int,bool> >::iterator
it=itsets.begin();it!=itsets.end();it++){
cout<<"Itemset "<<(it->second).first<<":\n";
for(int i=0;i<26;i++){
for(int j = 0; j < (it->first)[i].size(); j++){
cout<<(char)(i+'A')<<" -> "<<(it->first)[i][j]<<"\n";
}
}
cout<<"\n";
}
}
int findDot(string alp,string &befDot,string &aftDot)
{
int pos = -1;
for(int i=0;i<alp.size();i++)
{
if(alp[i] == '.')
{
pos = i;
if(i+1<alp.size())
befDot+=alp[i+1];
i++;
continue;
}
if(pos == -1)
{

befDot+=alp[i];
}
else
{
aftDot+=alp[i];
}
}
return pos;
}
void closure(vector<vector<string> > &curr)
{
bool f = 1;
bool vis[26] = {0};
while(f)
{
f = 0;
for(int i=0;i<26;i++)
{
if(curr[i].size()>0)
{

for(int j=0;j<curr[i].size();j++)
{

string prod = curr[i][j],ad,bd;
int pos = findDot(prod,bd,ad);
if(pos+1<prod.size())

{

char x = prod[pos+1];
if(isupper(x) && !vis[x-'A'])

{

int nidx = x-'A';
vis[nidx] = 1;
for(int k=0;k<grammar[nidx].size();k++)

{

curr[nidx].push_back("."+grammar[nidx][k]);
}
f = 1;
}
}
}
}
}
}
}

void genNewItset(vector<vector<string> > &curr,char
x,vector<vector<string> > &nitset)
{
for(int i=0;i<26;i++){
if(curr[i].size()>0){
for(int j=0;j<curr[i].size();j++){
string prod = curr[i][j],bd,ad;
int pos = findDot(prod,bd,ad);
if(pos == prod.size()-1)
continue;
if(prod[pos+1] == x){
string nextrhs = bd+"."+ad;
nitset[i].push_back(nextrhs);
}
}
}
}
}
void addElems(set<char> &a,set<char> &b)
{

for(set<char>::iterator it = b.begin();it!=b.end();it++)
{
a.insert((*it));
}
}
void computeFirst(int v)
{
for(int i=0;i<grammar[v].size();i++)
{
if(isupper(grammar[v][i][0]))
{
if((grammar[v][i][0]-'A' == v))
{

continue;
}
if(first[grammar[v][i][0]-'A'].size()==0)
computeFirst(grammar[v][i][0]-'A');
addElems(first[v],first[grammar[v][i][0]-'A']);
}
else
{
first[v].insert(grammar[v][i][0]);
}
}
}
void computeFollow(int v)
{
char x = v+'A';
for(int i=0;i<26;i++)
{
if(grammar[i].size()>0)

{
for(int j=0;j<grammar[i].size();j++)
{

string prod = grammar[i][j];
for(int k=0;k<prod.size();k++)
{

if(prod[k] == x)

{

if(k == prod.size()-1)

{

if(follow[i].size()==0)
computeFollow(i);
addElems(follow[v],follow[i]);
}

else
{

if(isupper(prod[k+1]))

{

addElems(follow[v],first[prod[k+1]-'A']);
}

else
{

follow[v].insert(prod[k+1]);
}
}
}
}
}
}
}
}
void read(vector<vector<string> > &curr,bool &end,int tableindex)
{
int f;

set<char> vis;
for(int i=0;i<26;i++)
{
if(curr[i].size()>0)
{
for(int j=0;j<curr[i].size();j++)
{

string prod = curr[i][j],bd,ad;
f = 1;
int pos = findDot(prod,bd,ad);
if(pos == prod.size()-1)
{

for(set<char>::iterator
it=follow[i].begin();it!=follow[i].end();it++)

{

if((*it) == '$' && i==25)

{

table[tableindex].action[(*it)].push_back("acc");

}

else
{

string ent = "R ";
ent+=((char)(i+'A'));
ent+="->";
ent+=bd;
cout<<"Reduce entry of itemset

"<<tableindex<<": "<<ent<<"\n";
table[tableindex].action[(*it)].push_back(ent);

}
}
continue;
}
char x = prod[pos+1];

if(vis.find(x) == vis.end())
{

vector<vector<string> > nit(26);
genNewItset(curr,x,nit);
vis.insert(x);
closure(nit);
map<vector<vector<string> >,pair<int,bool>

>::iterator it = itsets.find(nit);

int transitset;
if(itsets.find(nit) == itsets.end())

{

transitset = cntitsets;
itsets.insert(make_pair(nit,make_pair(cntitsets++,0)));

slrEntry e;
table.push_back(e);
end = 1;
}

else

transitset = (it->second).first;
if(isupper(x))

{

table[tableindex].go2.insert(make_pair(x,transitset));

}

else
{

string tmp="S";
tmp+=to_string(transitset);
table[tableindex].action[x].push_back(tmp);

cout<<"Shift entry of itemset

"<<tableindex<<": "<<tmp<<"\n";
}
}
}
}
}
}
void printFirst(){
for(int i=0;i<26;i++){
if(first[i].size()>0){
cout<<"First("<<(char)(i+'A')<<") = ";
for(set<char>::iterator it = first[i].begin();it!=first[i].end();it++)
cout<<(*it)<<" ";
cout<<"\n";
}
}
}
void printFollow(){
for(int i=0;i<26;i++){
if(follow[i].size()>0){
cout<<"Follow("<<(char)(i+'A')<<") = ";
for(set<char>::iterator it =
follow[i].begin();it!=follow[i].end();it++)
cout<<(*it)<<" ";
cout<<"\n";
}
}
}
void printTable()
{
for(int i=0;i<table.size();i++)
{
cout<<"State "<<i<<"\n";
cout<<"action:\n";

for(map<char,vector<string> >::iterator
it=table[i].action.begin();it!=table[i].action.end();it++){

cout<<"("<<it->first<<", ";
for(int j=0;j<(it->second).size();j++)
cout<<(it->second)[j]<<" ";
cout<<")\n";
}
cout<<"goto:\n";
for(map<char,int>::iterator
it=table[i].go2.begin();it!=table[i].go2.end();it++){

cout<<"("<<it->first<<","<<(it->second)<<")\n";
}
cout<<"\n";
}
}
int findOp(string s)
{
for(int i=0;i<s.size();i++)
{
if(s[i] == '+' || s[i] == '*')
return i;

}
return -1;
}
//assoc = 1, implies right ; prec = 1, implies + > *
void resolveAmbiguity(bool assoc,bool prec)
{
for(int i=0;i<table.size();i++)
{
for(map<char,vector<string> >::iterator
it=table[i].action.begin();it!=table[i].action.end();it++)
{
if((it->second).size()==2)
{

int r,s;
if((it->second)[0][0] == 'R')
{

r = 0;
s = 1;
}
else
{

r = 1;
s = 0;
}
int opPos = findOp((it->second)[r]);
if((it->first) == (it->second)[r][opPos])
{//in this case, since operators are same, we have to resolve the

associativity

if(assoc)

{

(it->second).erase((it->second).begin()+r);
}

else
{

(it->second).erase((it->second).begin()+s);
}
}
else
{

if(prec)

{

if((it->first == '+') &&

(it->second)[r][opPos]=='*')

{

(it->second).erase((it->second).begin()+r);

}

if((it->first == '*') &&

(it->second)[r][opPos]=='+')

{

(it->second).erase((it->second).begin()+s);

}
}

else
{

if((it->first == '+') &&

(it->second)[r][opPos]=='*')

{

(it->second).erase((it->second).begin()+s);

}
if((it->first == '*') &&

(it->second)[r][opPos]=='+')

{

(it->second).erase((it->second).begin()+r);

}
}
}
}
}
}
}
int main()
{
int infd = open("input.txt",O_RDONLY);
dup2(infd,0);
int n;
cin>>n;
char start='.';

for(int i=0;i<n;i++)
{
string s;
cin>>s;
if(start == '.')
{
start = s[0];
}
string prod;
bool f = 0;
for(int i=0;i<s.length();i++)
{
if(s[i] == '-' && s[i+1] == '>')
{

f = 1;
i++;
continue;
}
if(f)
prod+=s[i];

}
int idx = s[0]-'A';
grammar[idx].push_back(prod);
}
cout<<"Augmented Grammar\n";
fflush(stdout);
string rhs;
rhs+=start;
grammar[25].push_back(rhs);
printGr();
vector<vector<string> > is0(26);
is0[25].push_back("."+rhs);
closure(is0);
itsets.insert(make_pair(is0,make_pair(cntitsets++,0)));

slrEntry e0;
table.push_back(e0);
//computing first of all variables
for(int i=0;i<26;i++)
{
if(grammar[i].size()>0 && first[i].size()==0)
{
computeFirst(i);
}
}
printFirst();
follow[25].insert('$');
//computing follow of all variables in the grammar
for(int i=0;i<26;i++)
{
if(grammar[i].size()>0 && follow[i].size()==0)
{
computeFollow(i);
}
}
printFollow();
//printItsets();
bool f = 1;
while(f)
{
f = 0;
for(map<vector<vector<string> >,pair<int,bool> >::iterator
it=itsets.begin();it!=itsets.end();it++)
{
if((it->second).second == 0)
{

vector<vector<string> > is = it->first;
int idx = (it->second).first;

read(is,f,idx);
(it->second).second = 1;
}
}
}
cout<<"Itemsets are\n";
printItsets();
resolveAmbiguity(1,1);
cout<<"-------------------> SLR Parsing Table <--------------------\n";
printTable();
return 0;
}

OUTPUT :-
