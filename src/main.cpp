#include <bits/stdc++.h>
#include <cmath>
using namespace std;
using ll = long long;

#define ALL(a) (a).begin(), (a).end()
#define FOR(i, s, n) for (ll i = (s); i < (n); i++)
#define rep(i, n) FOR(i, 0, n)
#define repi(i, n) FOR(i, 1, n + 1)
#define pp(v) cerr << #v "=" << (v) << endl;
#define ppa(v) cerr << "- " << #v << endl; rep(i,v.size()) cerr << #v << "[" << i << "] = " << v[i] << endl;
#define div_ceil(a,b) ((a) + ((b) - 1)) / (b)
#define UNIQUE(v) v.erase( unique(ALL(v)), v.end() );
#define INF 0x3f3f3f3f
#define LLINF 1000111000111000111LL
#define MOD 1000000007
#define TIME system("date +%M:%S.%N")
using Graph = vector<vector<int>>;
template<class T> T gcd(const T &a, const T &b) { return a < b ? gcd(b, a) : b ? gcd(b, a % b) : a; }
template<class T> T lcm(const T &a, const T &b) { return a / gcd(a, b) * b; }

#define mp make_pair

int score_index(char c) {
  if (c == 'r') return 0;
  if (c == 's') return 1;
  if (c == 'p') return 2;
}

ll query(ll x) {
  
}

int main() {
  ll n,m;cin>>n>>m;
  vector<ll> a(n);rep(i,n) cin>>a[i];
  sort(ALL(a));
  reverse(ALL(a));
  ll ok = 0, ng = 1e6;
  while (ng - ok > 1) {
    ll mid = (ok + ng) / 2;
    ll cnt = 0;
    int j = n - 1;
    rep(i,n) {
      while (j >= 0 && a[i] + a[j] < mid) j--;
      cnt += j + 1;
    }
    if (cnt >= m) ok = mid;
    else ng = mid;
  }
  pp(ok);
  pp(ng);
}
