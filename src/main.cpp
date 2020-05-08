#include <bits/stdc++.h>
#define rep(i, n) for (int i = 0; i < (n); i++)
using namespace std;
using ll = long long;

void dfs(ll a, ll use, ll n, ll& ans) {
  if (a > n) return;
  if (use == 0b111) ans++;
  rep(i,3) {
    int j = i * 2 + 3;
    int mask = 1 << i;
    dfs(a * 10 + j, use | mask, n, ans);
  }
}

int main() {
  ll n; cin >> n;
  ll ans = 0;
  dfs(0, 0, n, ans);
  cout << ans << endl;
}
