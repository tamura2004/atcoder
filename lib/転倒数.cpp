struct BIT {
  vi bit;
  int n;
  BIT(int n) : n(n), bit(n+1) {}

  void add(int a, int w) {
    for (int x = a; x <= n; x += x & -x) bit[x] += w;
    pp(a,bit);
  }

  int sum(int a) {
    int ans = 0;
    for (int x = a; x > 0; x -= x & -x) ans += bit[x];
    return ans;
  }
};

signed main() {
  in(n);
  vi a(n);cin>>a;
  BIT b(n);
  int ans = 0;
  rep(i,n) {
    ans += i - b.sum(a[i]);
    b.add(a[i],1);
  }
  cout << ans << endl;
}