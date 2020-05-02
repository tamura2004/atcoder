#include <bits/stdc++.h>
#define rep(i, n) for (int i = 0; i < (n); i++)
using namespace std;
using ll = long long;

int main() {
  int n;
  string s;
  cin >> n >> s;
  vector<int> a(n);
  rep(i,n) a[i] = s[i] % 3;

  vector<ll> cnt(3);
  rep(i,n) cnt[a[i]]++;
  ll ans = 1;
  rep(i,3) ans *= cnt[i];
  rep(j,n) rep(i,j) {
    int k = j + (j - i);
    if (k < n) {
      if (a[i] == a[j]) continue;
      if (a[k] == a[j]) continue;
      if (a[i] == a[k]) continue;
      ans--;
    }
  }
  cout << ans << endl;
}
