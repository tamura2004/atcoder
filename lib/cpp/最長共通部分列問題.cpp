// 文字列 s および t が与えられます。 s の部分列かつ t の部分列であるような文字列のうち、
// 最長のものをひとつ求めてください。
// 文字列 x の部分列とは、 x から 0 個以上の文字を取り除いた後、
// 残りの文字を元の順序で連結して得られる文字列のことです。

// 最長共通部分列問題
signed main() {
  string s,t;cin>>s>>t;
  int n = s.size(), m = t.size();
  vvi dp(n+1,vi(m+1,0));

  repi(i,n) repi(j,m) {
    if (s[i-1] == t[j-1]) { // 文字列のインデックス参照は0オリジン
      dp[i][j] = dp[i-1][j-1] + 1;
    } else {
      dp[i][j] = max(dp[i-1][j], dp[i][j-1]);
    }
  }
  // rep(i,n+1) pp(dp[i]);
  int i = n, j = m;
  string ans = "";
  while (dp[i][j] > 0) {
    if (dp[i-1][j] == dp[i][j]) i--;
    else if (dp[i][j-1] == dp[i][j]) j--;
    else ans = s[i-1] + ans, i--, j--;
  }
  // pp(ans);
  cout << ans << endl;
}