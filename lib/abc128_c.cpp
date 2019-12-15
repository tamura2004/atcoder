#include <bits/stdc++.h>
using namespace std;
#define rep(i, n) for (int i = 0; i < (n); i++)
#define repi(i, n) for (int i = (n)-1; i >= 0; i--)
#define pp(v) cout << #v << "=" << (v) << endl;
#define div_ceil(a,b) ((a) + ((b) - 1)) / (b)

int main() {
  // input
  int n,m; cin >> n >> m;
  vector<int> k(m),p(m);
  vector<vector<int>> s(m);
  rep(i,m) {
    cin >> k[i];
    int len = k[i];
    s[i].resize(len);
    rep(j,len) {
      cin >> s[i][j];
      s[i][j]--;
    }
  }
  rep(i,m) cin >> p[i];

  // スイッチのon／offを全探索
  int ans = 0; // 組み合わせの戸数
  rep(bit, 1<<n) { // スイッチのon/off状態
    bool on = true;
    rep(i,m) { // 電球i
      int cnt = 0; // 電球iが繋がっているスイッチの数
      int len = k[i]; // 電球に繋がっているスイッチの個数
      rep(j,len) {
        int sw = s[i][j]; // スイッチ番号
        if (bit >> sw & 1) cnt++; // スイッチonならカウント
      }
      if (cnt % 2 != p[i]) { // 点灯していないスイッチがあったら
        on = false;
        break;
      }
    }
    if (on) ans++; // 全部の電球が点灯したらカウント
  }

  // output
  cout << ans << endl;


  // pp(n);
  // pp(m);
  // rep(i,m) {
  //   int len = k[i];
  //   pp(len);
  //   rep(j,len) pp(s[i][j]);
  // }

}
