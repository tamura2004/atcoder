#include <bits/stdc++.h>
#include <atcoder/dsu>

using namespace std;
using namespace atcoder;

int main() {
  int n, q;
  cin >> n >> q;
  dsu uf(n);

  for (int i = 0; i < q; i++) {
    int t, v, nv;
    cin >> t >> v >> nv;
    if (t) cout << (uf.same(v, nv) ? "Yes" : "No") << endl;
    else uf.merge(v, nv);
  }
}