#include <iostream>
#include <string>
#include <vector>

using namespace std;

bool cyk(string w, vector<vector<string>> P) {
    int n = w.length();
    int r = P.size();
    bool T[n][n][r];
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < r; j++) {
            T[i][i][j] = false;
            for (string p : P[j]) {
                if (p == string(1,w[i])) {
                    T[i][i][j] = true;
                    break;
                }
            }
        }
    }

    for (int l = 2; l <= n; l++) {
        for (int i = 0; i <= n-l; i++) {
            int j = i + l - 1;
            for (int k = 0; k < r; k++) {
                T[i][j][k] = false;
                for (string p : P[k]) {
                    if (p.length() == 2) {
                        int A,B;
                        A = p[0]-'A';
                        B = p[1]-'A';
                        for (int s=i;s<j;s++){
                            if(T[i][s][A] && T[s+1][j][B]){
                                T[i][j][k]=true;
                                break;
                            }
                        }
                    }
                }
            }
        }
    }

    return T[0][n-1][0];
}

int main() {

    vector<vector<string>> P(3);
    P[0].push_back("AB");
    P[0].push_back("BC");
    P[1].push_back("CC");
    P[1].push_back("a");
    P[2].push_back("AB");
    P[2].push_back("b");

    string w;

    cout << "Enter the string: ";
    cin >> w;

   if(cyk(w,P))
       cout << "The string is accepted." << endl;
   else
       cout << "The string is rejected." << endl;

   return 0;
}
