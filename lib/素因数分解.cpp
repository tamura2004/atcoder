#include <bits/stdc++.h>
using namespace std;
using mii = map<int, int>;

// 素因数分解
// usage:
// mii p = prime_factor(12);
// { 2 => 2, 3 => 1 }
//
mii prime_factor(int n) {
  mii ans;
  for (int i = 2; i * i <= n; i++) {
    while (n % i == 0) { ans[i]++; n /= i; }
  }
  if (n != 1) ans[n] = 1;
  return ans;
}
