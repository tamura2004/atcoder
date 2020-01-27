struct Problem {
  int n,w; // n:個数、w:重量上限
  vi a,b; // a:重さ、b:価値
  vvi dp;

  Problem(int n, int w) : n(n),w(w),a(n),b(n),dp(n+1,vi(w+1,0)) {}

  int solve() {
    rep(i,n) rep(j,w+1) {
      // 一つも選ばない場合
      chmax(dp[i+1][j], dp[i][j]);

      // 前に加えて選ぶ
      if (j - a[i] >= 0) chmax(dp[i+1][j], dp[i+1][j - a[i]] + b[i]);
    }

    // n番目まで選んだ時の、重量w*以下*の価値の最大値
    return dp[n][w];
  }

  void inspect() {
    rep(i,n+1) pp(dp[i]);
  }
};

signed main() {
  in(n,w);
  Problem p(n,w);
  rep(i,n) cin>>p.a[i]>>p.b[i];
  int ans = p.solve();
  pp(ans);
}
