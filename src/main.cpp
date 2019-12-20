#include <bits/stdc++.h>
#define ALL(a) (a).begin(), (a).end()
#define FOR(i, s, n) for (int i = (s); i < (n); i++)
#define rep(i, n) FOR(i, 0, n)
#define repi(i, n) FOR(i, 1, n + 1)
#define pp(v) cerr << #v "=" << (v) << endl;
#define ppa(v) cerr << "----\n"; rep(i,v.size()) cout << #v << "[" << i << "] = " << v[i] << endl;
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
  int n;cin>>n;
  vector<ll> a(n);
  vector<pair<ll,int>> cs(n+1);
  cs[0] = make_pair(0,0);
  rep(i,n) {
    cin>>a[i];
    cs[i+1].first = cs[i].first + a[i];
    cs[i+1].second = i+1;
  }
  int N = cs[n].first;
  pp(N/2);
  sort(ALL(cs));
}
