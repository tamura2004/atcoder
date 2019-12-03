#include <bits/stdc++.h>
#define rep(i, s, n) for (int i = s; i < n; i++)
using namespace std;
typedef long long ll;
template<class T>bool chmax(T &a, const T &b) { if (a<b) { a=b; return 1; } return 0; }
template<class T>bool chmin(T &a, const T &b) { if (b<a) { a=b; return 1; } return 0; }

const int L = 3000;
int dp[L+1][L+1];

int main() {
  string s,t;
  cin >> s >> t;
  int n = s.size() + 1; int m = t.size() + 1;

  rep(i,1,n) rep(j,1,m) {
    if (s[i-1] == t[j-1]) {
      dp[i][j] = dp[i-1][j-1] + 1;
    } else {
      chmax(dp[i][j], dp[i-1][j]);
      chmax(dp[i][j], dp[i][j-1]);
    }
  }

  int idx = n;
  while (dp[idx][m] != 0) {
    if (dp[idx][m] == dp[idx-1][m]) {
      idx--;
    } else {
      cout << s[dp[idx][m]] << ",";
    }
  }
  cout << endl;

  // rep(i,0,n) {
  //   rep(j,0,m) cout << dp[i][j] << ",";
  //   cout << "\n";
  // }
  return 0;
}
