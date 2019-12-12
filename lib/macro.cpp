#include <bits/stdc++.h>
#define rep(i, n) for (int i = 0; i < (n); i++)
#define repi(i, n) for (int i = (n)-1; i >= 0; i--)
#define pp(v) cout << #v "=" << (v) << endl;
#define div_ceil(a,b) ((a) + ((b) - 1)) / (b)
using namespace std;

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