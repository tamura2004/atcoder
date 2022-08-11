#include <bits/stdc++.h>
#include <atcoder/segtree>

using namespace std;
using namespace atcoder;

int op(int x, int y) { return x ^ y; }
int e() { return 0; }

int main() {
  int n, q;
  cin >> n >> q;

  vector<int> a(n);
  for (int i = 0; i < n; i++) { cin >> a[i]; }

  segtree<int, op, e> st(a);

  for (int i = 0; i < q; i++) {
    int t, x, y;
    cin >> t >> x >> y;
    x--;
    if (t == 1) st.set(x, st.get(x) ^ y);
    else cout << st.prod(x, y) << endl;
  }
}