template<unsigned MOD_> struct ModInt {
  static const unsigned MOD = MOD_;
  unsigned x;
  void undef() { x = (unsigned)-1; }
  bool isnan() const { return x == (unsigned)-1; }
  inline int geti() const { return (int)x; }
  ModInt() { x = 0; }
  ModInt(const ModInt &y) { x = y.x; }
  ModInt(int y) { if (y<0 || (int)MOD<=y) y %= (int)MOD; if (y<0) y += MOD; x=y; }
  ModInt(unsigned y) { if (MOD<=y) x = y % MOD; else x = y; }
  ModInt(long long y) { if (y<0 || MOD<=y) y %= MOD; if (y<0) y += MOD; x=y; }
  ModInt(unsigned long long y) { if (MOD<=y) x = y % MOD; else x = y; }
  ModInt &operator+=(const ModInt y) { if ((x += y.x) >= MOD) x -= MOD; return *this; }
  ModInt &operator-=(const ModInt y) { if ((x -= y.x) & (1u<<31)) x += MOD; return *this; }
  ModInt &operator*=(const ModInt y) { x = (unsigned long long)x * y.x % MOD; return *this; }
  ModInt &operator/=(const ModInt y) { x = (unsigned long long)x * y.inv().x % MOD; return *this; }
  ModInt operator-() const { return (x ? MOD-x: 0); }

  ModInt inv() const { return pow(MOD-2); }
  ModInt pow(long long y) const {
    ModInt b = *this, r = 1;
    if (y < 0) { b = b.inv(); y = -y; }
    for (; y; y>>=1) {
      if (y&1) r *= b;
      b *= b;
    }
    return r;
  }
 
  ModInt extgcd() const {
    unsigned a = MOD, b = x; int u = 0, v = 1;
    while (b) {
        int t = a / b;
        a -= t * b; swap(a, b);
        u -= t * v; swap(u, v);
    }
    if (u < 0) u += MOD;
    return ModInt(u);
  }
 
  friend ModInt operator+(ModInt x, const ModInt y) { return x += y; }
  friend ModInt operator-(ModInt x, const ModInt y) { return x -= y; }
  friend ModInt operator*(ModInt x, const ModInt y) { return x *= y; }
  friend ModInt operator/(ModInt x, const ModInt y) { return x *= y.inv(); }
  friend bool operator<(const ModInt x, const ModInt y) { return x.x < y.x; }
  friend bool operator==(const ModInt x, const ModInt y) { return x.x == y.x; }
  friend bool operator!=(const ModInt x, const ModInt y) { return x.x != y.x; }
};
 
typedef ModInt<MOD> Mint;

const int MAX = 2000011;
Mint inv[MAX], fact[MAX], fact_inv[MAX];
 
void init() {
  fact[0] = 1;
  for (int i=1; i<MAX; i++) fact[i] = fact[i-1] * i;
  fact_inv[MAX-1] = fact[MAX-1].inv();
  for (int i=MAX-2; i>=0; i--) fact_inv[i] = fact_inv[i+1] * (i+1);
  inv[0] = 0;
  for (int i=1; i<MAX; i++) inv[i] = fact_inv[i] * fact[i-1];
}
 
Mint nCk(int n, int k) {
  return fact[n] * fact_inv[k] * fact_inv[n-k];
}

Mint F(int r, int c) { return nCk(r+c, c); }

signed main() {
  init();
  in(r1,c1,r2,c2);
  Mint ans = F(r2+1,c2+1) - F(r1,c2+1) - F(r2+1,c1) + F(r1,c1);
  cout << ans.geti() << endl;
}
