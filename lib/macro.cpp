#include <bits/stdc++.h>
#define ALL(a) (a).begin(), (a).end()
#define FOR(i, s, n) for (int i = (s); i < (n); i++)
#define rep(i, n) FOR(i, 0, n)
#define repi(i, n) FOR(i, 1, n + 1)
#define pp(v) cerr << #v "=" << (v) << endl;
#define ppa(v) cerr << "- " << #v << endl; rep(i,v.size()) cerr << #v << "[" << i << "] = " << v[i] << endl;
#define div_ceil(a,b) ((a) + ((b) - 1)) / (b)
#define UNIQUE(v) v.erase( unique(v.begin(), v.end()), v.end() );
#define INF 0x3f3f3f3f
#define LLINF 1000111000111000111LL
#define TIME system("date +%M:%S.%N")
using namespace std;
using Graph = vector<vector<int>>;
using ll = long long;

int main() {
  int d,g; cin >> d >> g; g /= 100;
  vector<int> p(d), c(d);
  rep(i,d) {
    cin >> p[i] >> c[i];
    c[i] /= 100;
  }

  int ans = 1e9;
  rep(bit, 1<<d) {
    int sum = 0, cnt = 0, rest = -1;
    rep(i,d) if (bit >> i & 1) {
      sum += p[i] * (i + 1) + c[i];
      cnt += p[i];
    } else {
      rest = i;
    }

    if (sum < g) {
      if (rest == -1) continue;
      int need = div_ceil(g - sum, rest);
      // int need = (g - sum + rest) / (rest + 1);
      if (need >= p[rest]) continue;
      cnt += need;
    }
    ans = min(ans, cnt);
  }
  cout << ans << endl;
}