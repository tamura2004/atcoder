// 分割数
// dp[n][m] nをm個の非負整数の和に表す組合せの数
// dp[n][m] = dp[n-1][m] + dp[n-m][m]
//          = ゼロを含む組合せ + ゼロを含まない組合せ
struct Problem {
  int n;
  vvi dp;

  Problem(int n) : n(n),dp(n+1,vi(n+1,0)) {}

  void solve() {
    rep(i,n) dp[0][i] = 1;

    repi(i,n) repi(j,n) {
      int a = i < j ? 0 : dp[i-j][j];
      dp[i][j] = dp[i][j-1] + a;
    }
  }

  void inspect() {
    rep(i,n+1) pp(dp[i][i]);
  }
};

signed main() {
  in(n);
  Problem p(n);
  p.solve();
  p.inspect();
  // cout << ans << endl;
}
