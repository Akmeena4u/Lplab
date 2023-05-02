6.Write a program to find LR(1) items for the following expression grammar and
construct Canonical LR table assuming that the operators ‘+’ and ‘*’ are right
associative and + has higher precedence than *
E → E + E | E * E | (E) | id



NOTE- I am taking ‘id’ as ‘i’
#include <bits/stdc++.h>

using namespace std;



map<char,vector<string> > productions;

map<char,vector<char> > first,follows;

vector<vector<pair<char, pair<string, char> > > > itemsets;

map<pair<int, char>, int> goto1;

map<pair<int, char>, vector<string> > action;

vector<char> terms;

vector<pair<char, string> > closure(vector<pair<char, string> > kernel_item);

void build_items();

void build_actions();

void find_first(string s, vector<char> &first_set,char l)

{

	if(s[0]=='0')

	{

		first_set.push_back(s[0]); 

		return;

	}

	else if(s[0]!=l)

	{

		int flag=0;

		for(int i=0; i<s.size(); i++)

		{

		

			if(!(s[i]<='Z' && s[i]>='A'))

			{

				first_set.push_back(s[i]); 

				return;

			}

			else

			{

				vector<char> tmp_first_vec;

				for(int j=0; j<productions[s[i]].size(); j++)

				{

					if(productions[s[i]][j]!=s)

					{

						find_first(productions[s[i]][j],tmp_first_vec,s[i]);

					}

				}

				flag=1;

				for(int j=0;j<tmp_first_vec.size(); j++)

				{

					if(tmp_first_vec[j]!='0')

					{

						if(find(first_set.begin(),first_set.end(),tmp_first_vec[j])==first_set.end())

						first_set.push_back(tmp_first_vec[j]);

					}

					else

					flag=0; 

				}

			}

			if(flag==1)

			break;

		}

		if(flag==0)

		first_set.push_back('0');

	}

}

void build_first()

{

	map<char,vector<string> >::iterator it;

	for(it=productions.begin();it!=productions.end();it++)

	{

		vector<char> first_set;		

		for(int j=0;j<it->second.size();j++)

		{

			find_first(it->second[j],first_set,it->first);

		}

		for(int j=0;j<first_set.size();j++)

		first[it->first].push_back(first_set[j]);

	}

}



vector<pair<char, pair<string, char> > > closure(vector<pair<char, pair<string, char> > > kernel_item)

{

	vector<pair<char, pair<string, char> > > ret;

	vector<char> s1;

	vector<pair<string, char> >  s2;

	for(int it=0; it<kernel_item.size(); it++)

	{

		s1.push_back(kernel_item[it].first);

		s2.push_back(kernel_item[it].second);

		ret.push_back(kernel_item[it]);

	}

	int i=0;

	while(i<s1.size())

	{

		int pos=-1;

		string str=s2[i].first;

		for(int j=0; j<str.length(); j++)

		{

			if(s2[i].first[j]=='.')

			{

				pos=j;

				break;

			}

		}

		if(pos!=s2[i].first.length()-1 && s2[i].first[pos+1]!='0')

		{

			string str1="";

			for(int g=pos+2; g<s2[i].first.length(); g++)

			str1+=s2[i].first[g];

			if(s2[i].first.length()<=pos+2 || s2[i].second!='$')

			str1+=s2[i].second;

			int flag=1;

			vector<char> follow_set;

			for(int r=0;r<str1.length();r++)

			{

				if(flag==1)

				{

					if(str1[r]<='Z' && str1[r]>='A')

					{

						flag=0;

						for(int k=0;k<first[str1[r]].size();k++)

						{

							if(first[str1[r]][k]!='0' && find(follow_set.begin(),follow_set.end(),first[str1[r]][k])==follow_set.end())

							{

								follow_set.push_back(first[str1[r]][k]);

							}

							else if(first[str1[r]][k]=='0')

							flag=1;

						}

					}

					else

					{

						flag=0;

						if(find(follow_set.begin(),follow_set.end(),str1[r])==follow_set.end())

						{

							follow_set.push_back(str1[r]);

						}

					}

				}

			}

			char ch = s2[i].first[pos+1];

			map<char,vector<string> >::iterator it1;

			for(it1=productions.begin();it1!=productions.end();it1++)

			{

				for(int j=0;j<it1->second.size();j++)

				{

					for(int x=0;x<follow_set.size();x++)

					{

						string str=".";

						str=str+it1->second[j];

						pair<string, char> w;

						w.first=str;

						w.second=follow_set[x];

						if(it1->first==ch && find(s2.begin(),s2.end(),w)==s2.end())

						{

							s1.push_back(it1->first);

							s2.push_back(w);

							ret.push_back(make_pair(it1->first, w));

						}

					}

				}

			}

		}

		i++;

	}

	return ret;

}

void build_items(char sa)

{

	pair<char, string> curr_production;

	curr_production.first=sa;

	curr_production.second=productions[sa][0];

	curr_production.second.insert(curr_production.second.begin(), '.');

	vector<pair<char, pair<string, char> > > init; 

	init.push_back(make_pair(curr_production.first, make_pair(curr_production.second, '$'))); 

	itemsets.push_back(closure(init)); 

	vector<vector<pair<char, pair<string, char> > > > s; 

	s.push_back(closure(init)); 

	int z=0;

	while(z<s.size())

	{

		vector<pair<char, pair<string, char> > > now; 

		now=s[z]; 

		z++;

		int index = 0;

		for(int i=0; i<itemsets.size(); i++)

		{

			if(now==itemsets[i])

			{

				index=i; 

				break;

			}

		}

		int u=0;

		vector<char> k1;

		vector< vector<pair<char, pair<string, char> > > > kernels;

		for(int i=0; i<now.size(); i++)

		{

			string rhs = now[i].second.first;

			for(int j=0; j<rhs.size(); j++)

			{

				if(rhs[j]=='.' && j!=rhs.size()-1)

				{

					swap(now[i].second.first[j], now[i].second.first[j+1]);

					int p=-1;

					for(int w=0;w<u;w++)

					{

						if(k1[w]==now[i].second.first[j])

						p=w;

					}

					if(p!=-1)

					kernels[p].push_back(now[i]);

					else

					{

						u++;

						vector<pair<char, pair<string, char> > > k2;

						k2.push_back(now[i]);

						kernels.push_back(k2);

						k1.push_back(now[i].second.first[j]);

					}

				}

			}

		}

		for(int it=0; it<u; it++)

		{

			vector<pair<char, pair<string, char> > > curr_close = closure(kernels[it]);

			int flag = 0;

			for(int i=0; i<itemsets.size(); i++)

			{

				if(itemsets[i]==curr_close)

				{

					goto1[make_pair(index, k1[it])] = i;

					flag = 1; 

					break;

				}

			}

			if(flag==0)

			{

				goto1[make_pair(index, k1[it])] = itemsets.size();

				itemsets.push_back(curr_close);

				s.push_back(curr_close);

			}

		}

	}

}

void build_actions(char sa)

{

	for(int i=0; i<itemsets.size(); i++)

	{

		for(int j=0; j<itemsets[i].size(); j++)

		{

			string tmp = itemsets[i][j].second.first;

			for(int k=0; k<tmp.size(); k++)

			{

				if(tmp[k]=='.' && k!=tmp.size()-1)

				{

					if(!(tmp[k+1]>='A'&&tmp[k+1]<='Z'))

					{

						stringstream ss; 

						ss<<goto1[make_pair(i, tmp[k+1])];

						string str="shift "+ss.str();

						if(find(action[make_pair(i, tmp[k+1])].begin(),action[make_pair(i, tmp[k+1])].end(),str)==action[make_pair(i, tmp[k+1])].end())

						action[make_pair(i, tmp[k+1])].push_back(str);

					}

				}

				else if(tmp[k]=='.' && k==tmp.size()-1)

				{

					if(itemsets[i][j].first==sa)

					{

						string str="accept";

						if(find(action[make_pair(i, '$')].begin(),action[make_pair(i, '$')].end(),str)==action[make_pair(i, '$')].end())

                        action[make_pair(i, '$')].push_back(str);

						break;

                    }

                    pair<char, pair<string, char> > reduce_this = itemsets[i][j];

                    reduce_this.second.first.erase(reduce_this.second.first.find('.'));

                    stringstream ss; 

					ss<<"reduce "<<reduce_this.first<<"->"<<reduce_this.second.first;

					if(find(action[make_pair(i, reduce_this.second.second)].begin(),action[make_pair(i, reduce_this.second.second)].end(),ss.str())==action[make_pair(i, reduce_this.second.second)].end())

    					action[make_pair(i, reduce_this.second.second)].push_back(ss.str());

				}

			}

		} 

	}

}

char lastop(stack<char> s,char c)

{

	char ch;

	int l=-1,r=-1;

	for(int i=s.size()-1;i>=0;i--)

	{

		if(s.top()=='+' || s.top()=='*')

		{

			ch=s.top();

			if(ch=='+')

			l=2;

			else

			l=1;

			break;

		}

		s.pop();

	}

	if(c=='+')

	r=2;

	else

	r=1;

	if(l>r)

	return 'r';

	else

	return 's';

}

void parse(){

	string w;

	cin>>w; 

	w+='$';

	char ch;

	int i=0;

	stack<int> s;

	stack<char> s1;

	s1.push('$');

	s.push(0);

	cout<<"\nParsing actions:\n";

	cout<<"String is:"<<w<<"\n";

	while(1)

	{

		string acc;

		cout << "ACTION[" << s.top() << ", " <<w[i]<<"]\t";

		if(action[make_pair(s.top(), w[i])].size()==1)

		acc=action[make_pair(s.top(), w[i])][0];

		else

		{

			ch=lastop(s1,w[i]);

			if(action[make_pair(s.top(), w[i])][0][0]==ch)

			acc=action[make_pair(s.top(), w[i])][0];

			else

			acc=action[make_pair(s.top(), w[i])][1];

		}

		if(acc[0]=='s')

		{

			cout<<acc<<endl;

			string tmp; 

			for(int j=6; j<acc.size(); j++)

			tmp+=acc[j]; 

			s.push(atoi(tmp.c_str()));

			s1.push(w[i]); 

			i++;

		}

		else if(acc[0]=='r')

		{

			cout<<acc;

			char lhs=acc[7]; 

			string rhs;

			for(int j=10; j<acc.size(); j++)

			rhs+=acc[j];

			//cout<<rhs<<" ";

			int popoff=rhs.size();

			while(popoff--)

			{

				s.pop();

				s1.pop();

			}

			s.push(goto1[make_pair(s.top(), lhs)]);

			s1.push(lhs);

			cout<<endl;

		}

		else if(acc=="accept")

		{

			cout<<"Accepted"<<endl;

			break;

		}

		else

		{

			cout<<"Error()\n";

			break;

		}

	}

}

int main()

{

	int n,in=0; 

	vector<char> nonter;

	vector<string> gra;

	cout<<"Enter number of productions:"; 

	cin>>n;

	char s;

	while(in<n)

	{

		char lhs; 

		string rhs,s2;

		cin>>lhs;

		cin>>rhs;

		s2+=lhs;

		s2+="->";

		s2+=rhs;

		gra.push_back(s2);

		productions[lhs].push_back(rhs);

		for(int i=0; i<rhs.size(); i++)

		{

			if(!(rhs[i]>='A' && rhs[i]<='Z') && find(terms.begin(),terms.end(),rhs[i])==terms.end())

			terms.push_back(rhs[i]);

			else if(find(nonter.begin(),nonter.end(),rhs[i])==nonter.end())

			nonter.push_back(rhs[i]);

		}

		if(in==0)

		s=lhs;

		in++;

	}

	terms.push_back('$');

	build_first();

	map<char,vector<char> >::iterator it;

	cout<<"first:\n";

	for(it=first.begin();it!=first.end();it++)

	{

		cout<<it->first<<"-> ";

		for(int j=0;j<it->second.size();j++) 

		{

			cout<<it->second[j]<<" ";

		}

		cout<<"\n";	

	}

	build_items(s);

	cout<<"\nItemsets:\n";

	for(int i=0; i<itemsets.size(); i++)

	{

		cout << "I-" << i <<":\n";

		for(int j=0; j<itemsets[i].size(); j++)

		{

			cout<<itemsets[i][j].first<<" -> "<<itemsets[i][j].second.first<<" , "<<itemsets[i][j].second.second<<endl;

		}

		cout<<endl;

	}

	cout<<"\nGo to computations:\n";

	map<pair<int, char>, int>::iterator it1;

	for(it1=goto1.begin(); it1!=goto1.end(); it1++)

	{

		cout<<"GOTO["<<(it1->first).first<<", "<<(it1->first).second<<"] = "<<it1->second<<endl;

	}

	build_actions(s);

	cout<<"\nActions in parsing table:\n";

	map<pair<int, char>, vector<string> >::iterator it2;

	for(it2=action.begin(); it2!=action.end(); it2++)

	{

		cout<<"ACTION["<<(it2->first).first<<", "<<(it2->first).second<<"] = ";

		for(int j=0; j<it2->second.size(); j++)

		{

			if(j!=0)

			cout<<"\t";

			cout<<it2->second[j];

		}

		cout<<endl;

	}

	cout<<"item";

	for(int i=0;i<terms.size();i++)

	cout<<"\t"<<terms[i];

	for(int i=0;i<nonter.size();i++)

	cout<<"\t"<<nonter[i];

	cout<<"\n";

	for(int i=0; i<itemsets.size(); i++)

	{

		cout<<i;

		int k=0,l=0;

		while(l==0)

		{

			//cout<<"\t";

			l=1;

			for(int j=0;j<terms.size();j++)

			{

				cout<<"\t";

				if(action[make_pair(i,terms[j])].size()>k+1)

				l=0;

				if(action[make_pair(i,terms[j])].size()>k)

				{

					string acc=action[make_pair(i,terms[j])][k];

					if(acc[0]=='s')

					{

						string tmp; 

						for(int w=6; w<acc.size(); w++)

						tmp+=acc[w];

						cout<<"s"<<atoi(tmp.c_str());

					}

					else if(acc[0]=='r')

					{

						cout<<acc[0]; 

						string rhs;

						int w;

						for(w=7; w<acc.size(); w++)

						rhs+=acc[w];

						for(w=0;w<gra.size();w++)

						{

							if(gra[w].compare(rhs)==0)

							break;

						}

						cout<<w;

					}

					else if(acc=="accept")

					{

						cout<<"acc";

					}

			//		l=0;

				}

			}

			for(int j=0;j<nonter.size();j++)

			{

				cout<<"\t";

				if(k==0)

				{

			//		l=0;

					if(goto1[make_pair(i,nonter[j])]!=0)

					cout<<goto1[make_pair(i,nonter[j])];

				}

			}

//			if(l==0)

			cout<<"\n";

			k++;

		}

	}

	parse();

	return 0;

}
