struct Problem {
  int n,w; // n:個数、w:重量上限
  vi a,b; // a:重さ、b:価値
  vvi dp;

  Problem(int n, int w) : n(n),w(w),a(n),b(n),dp(n+1,vi(w+1,0)) {}

  int solve() {
    rep(i,n) rep(j,w+1) {

      // 選ばない場合が良いとき
      chmax(dp[i+1][j], dp[i][j]);

      // 重量超過しないなら、選んだ時と比較
      if (j + a[i] <= w) chmax(dp[i+1][j + a[i]], dp[i][j] + b[i]);
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