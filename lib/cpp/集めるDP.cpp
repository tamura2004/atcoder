struct Problem {
  int n,w; // n:個数、w:重量上限
  vi a,b; // a:重さ、b:価値
  vvi dp;

  Problem(int n, int w) : n(n),w(w),a(n),b(n),dp(n+1,vi(w+1,0)) {}

  int solve() {
    rep(i,n) rep(j,w+1) {
      // 品物を選ばない場合（DP表の一つ上）
      int now = dp[i][j];

      // 重量超過なら、選ばない場合の価値を引き継ぐ
      if (j < a[i]) dp[i+1][j] = now;

      // 選べるなら、両方の場合を比較
      else dp[i+1][j] = max(now, dp[i][ j - a[i] ] + b[i]);
    }

    // n番目まで選んだ時の、重量w*以下*の価値の最大値
    return dp[n][w];
  }
};

signed main() {
  in(n,w);
  Problem p(n,w);
  rep(i,n) cin>>p.a[i]>>p.b[i];
  int ans = p.solve();
  pp(ans);
}