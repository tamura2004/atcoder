#include <bits/stdc++.h>
using namespace std;
#define ALL(a) (a).begin(), (a).end()
#define FOR(i, s, n) for (int i = (s); i < (n); i++)
#define rep(i, n) FOR(i, 0, n)
#define repi(i, n) FOR(i, 1, n + 1)
#define pp(v) cout << #v "=" << (v) << endl;
#define ppa(v) cout << "----\n"; rep(i,v.size()) cout << #v << "[" << i << "] = " << v[i] << endl;
#define div_ceil(a,b) ((a) + ((b) - 1)) / (b)

int center_height(int x, int y, int cx, int cy, int h) {
  return abs(x-cx) + abs(y-cy) + h;
}

// ABC112C Pyramid 方針
// cx,cyで全探索
// 全座標が1万以上、観測地点100以下より、高度が0でない観測地点が一つ以上ある
// 高度が0でない観測地点を一つ選び、頂上の高さHを算出
// 観測地点の頂上からのマンハッタン距離をLとする
// 観測地点の高度が0の時、L < Hなら矛盾
// 観測地点の高度altが0以外の時、L + alt <> Hなら矛盾

int main() {
  int a;
  cout << a << endl;
  exit(0);
  int n; cin >> n;
  vector<int> x(n),y(n),h(n);
  rep(i,n) cin >> x[i] >> y[i] >> h[i];

  rep(cx,101) rep(cy,101) {
    bool valid = true;
    int H, L;
    rep(i,n) {
      if (h[i] == 0) continue;
      H = center_height(x[i],y[i],cx,cy,h[i]);
      break;
    }

    rep(i,n) {
      L = center_height(x[i],y[i],cx,cy,h[i]);
      if (h[i] == 0 && L < H) valid = false;
      if (h[i] != 0 && L != H) valid = false;
      if (!valid) break;
    }

    if (valid) {
      cout << cx << " " << cy << " " << H << endl;
      exit(0);
    }
  }
}