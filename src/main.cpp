#include <bits/stdc++.h>
#define rep(i, n) for (int i = 0; i < n; i++)
using namespace std;
typedef long long ll;
template<class T>bool chmax(T &a, const T &b) { if (a<b) { a=b; return 1; } return 0; }
template<class T>bool chmin(T &a, const T &b) { if (b<a) { a=b; return 1; } return 0; }

const ll INF = 1LL<<60;
int N,M;
vector<vector<int>> G;

int dp[100100];
int rec(int v) {
  if (dp[v] != -1) return dp[v];
  int res = 0;
  for (auto nv : G[v]) {
    chmax(res, rec(nv) + 1);
  }
  return dp[v] = res;
}

int main() {
  cin >> N >> M;
  G.assign(N, vector<int>());
  rep(i,M) {
    int x,y; cin >> x >> y;
    --x; --y;
    G[x].push_back(y);
  }

  rep(v,N) dp[v] = -1;

  int res = 0;
  rep(v,N) chmax(res, rec(v));
  cout << res << endl;
}
