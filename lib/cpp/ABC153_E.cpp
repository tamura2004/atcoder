struct Problem {
  int n,w; // n:個数、w:重量上限
  vi a,b; // a:重さ、b:価値　ダメージ、マナ
  vvi dp;

  Problem(int n, int w) : n(n),w(w),a(n),b(n),dp(n+1,vi(w+1,INF)) {}

  int solve() {
    rep(i,n) rep(j,w+1) {
      
      // i番目の呪文を使用しない
      chmin(dp[i+1][j], dp[i][j]);

      // ひとつ前の呪文のマナ
      int mana = 0;
      if (j - a[i] > 0) mana = dp[i+1][j - a[i]];

      // 前に加えて選ぶ
      chmin(dp[i+1][j],mana + b[i]);
    }

    // n番目まで選んだ時の、重量w*以下*の価値の最大値
    return dp[n][w];
  }

  void inspect() {
    rep(i,n+1) pp(dp[i]);
  }
};

signed main() {
  in(h,n);
  Problem p(n,h);
  rep(i,n) cin>>p.a[i]>>p.b[i];
  int ans = p.solve();
  // p.inspect();
  cout << ans << endl;
}
