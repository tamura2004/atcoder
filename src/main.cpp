#include <bits/stdc++.h>
#include <atcoder/all>

using namespace std;
using namespace atcoder;
using mint = modint998244353;

int main() {
  mint sum = 1;

  for (int i = 1; i < 10000; i++) {
    sum *= i;
  }

  cout << sum.val() << endl;
}