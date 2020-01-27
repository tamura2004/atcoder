
// 重さと価値がそれぞれai,biであるようなn個の品物がある
// 重さの総和がwを超えないように選んだ時の
// 価値の総和を求める

struct Problem {
  int n; // 品物の個数
  vector<int> a,b; // a:重さ、b:価値
  vector<vector<int>> dp; // メモ化テーブル

  Problem(int n, int w) : n(n),a(n),b(n),dp(n+1,vector<int>(w+1,-1)) {}

  // i番目以降の品物から、重さの総和がw以下になるように選ぶ
  int solve(int i, int w) {
    // すでに調べたことがあるならその結果を利用
    if (dp[i][w] >= 0) return dp[i][w];

    // もう品物は残っていない
    if (i == n) return 0;

    // 重量超過
    else if (w < a[i]) return solve(i+1, w);

    // 入れる場合と入れない場合の両方試す
    else return max(
      solve(i+1, w),
      solve(i+1, w-a[i]) + b[i]
    );
  }
};

signed main() {
  in(n,w);
  Problem p(n,w);
  rep(i,n) cin>>p.a[i]>>p.b[i];
  int ans = p.solve(0,w);
  pp(ans);
}