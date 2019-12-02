#include <bits/stdc++.h>
#define rep(i, n) for (int i = 0; i < n; i++)
using namespace std;
typedef long long ll;
bool DP[30001][4][1000];

int main() {
  int N; cin >> N; 
  string S; cin >> S;
  DP[0][0][0] = true;
  rep(i,N) rep(j,4) rep(k,1000) {
    if (DP[i][j][k] == false) continue;
    DP[i+1][j][k] = true;
    if (j < 3) {
      DP[i+1][j+1][k*10+(S[i]-'0')] = true;
    }
  }
  int cnt = 0;
  rep(i,1000) {
    if (DP[N][3][i]) cnt++;
  }
  cout << cnt << endl;
  return 0;
}
