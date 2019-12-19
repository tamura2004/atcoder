#include <bits/stdc++.h>
#define ALL(a) (a).begin(), (a).end()
#define FOR(i, s, n) for (int i = (s); i < (n); i++)
#define rep(i, n) FOR(i, 0, n)
#define repi(i, n) FOR(i, 1, n + 1)
#define pp(v) cout << #v "=" << (v) << endl;
#define ppa(v) cout << "----\n"; rep(i,v.size()) cout << #v << "[" << i << "] = " << v[i] << endl;
#define div_ceil(a,b) ((a) + ((b) - 1)) / (b)
#define UNIQUE(v) v.erase( unique(v.begin(), v.end()), v.end() );
using namespace std;
using Graph = vector<vector<int>>;
using ll = long long;

// abc067c 方針
// 累積和をpair<sum,index>で作成（単調性なし）
// sumでソート（単調性あり）
// 総合計Nに対し、N/2以下、以上で二分探索
// どちらかのみ見つかればそちらを
// 両方見つかれば差の小さい方を回答とする

int main() {
  int n,m;cin>>n>>m;
  vector<vector<int>> g(n+1);
  repi(i,m) {
    int a,b;cin>>a>>b;
    if (a!=1&&a!=n&&b!=1&&b!=n) continue;
    g[a].push_back(b);
    g[b].push_back(a);
  }

  bool ans = false;
  for (int x : g[1]) {
    for (int y : g[x]) {
      if (y == n) ans = true;
    }
  }
  cout << (ans?"POSSIBLE":"IMPOSSIBLE") << endl;
}
