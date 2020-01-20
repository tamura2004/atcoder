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

// 自然数の素因数分解表示
// 大きなＬＣＭの計算用
struct PrimeFactorInt {
  int n;
  mii m;
  PrimeFactorInt(int n) : n(n) {
    m = prime_factor(n);
  }
  PrimeFactorInt(mii m) : m(m) {
    n = 0;
    for (auto v : m) {
      n += v.first * v.second;
    }
  }
};
