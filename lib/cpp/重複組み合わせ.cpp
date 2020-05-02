// 動的計画法
// 重複組み合わせ
struct Problem {
  int n,m; // n:品物の種類、m:選ぶ個数
  vi a; // a:各品物の個数
  vvi dp;

  Problem(int n, int m) : n(n),m(m),a(n),dp(n+1,vi(m+1,0)) {
    pp(n,m,a);
    inspect();
  }

  // 補助関数
  int num(int i, int j) {
    return j < 0 ? 0 : dp[i][j];
  }

  // 実行
  int solve() {
    dp[0][0] = 1; // なにも選ばない場合の数は1
    rep(i,n) rep(j,m+1) {
      dp[i+1][j] = dp[i][j] + num(i+1, j-1) - num(i, j - a[i] - 1);
      inspect();
    }
    return dp[n][m];
  }

  void inspect() {
    pp("---");
    rep(i,n+1) pp(dp[i]);
  }
};

signed main() {
  in(n,m);
  Problem p(n,m);
  cin>>p.a;
  int ans = p.solve();
  cout << ans << endl;
}