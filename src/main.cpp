#include <bits/stdc++.h>
using namespace std;

#define ALL(a) (a).begin(), (a).end()
#define FOR(i, s, n) for (int i = (s); i < (n); i++)
#define rep(i, n) FOR(i, 0, n)
#define repi(i, n) FOR(i, 1, n + 1)
#define pp(v) cerr << #v "=" << (v) << endl;
#define ppa(v) cerr << "- " << #v << endl; rep(i,v.size()) cerr << #v << "[" << i << "] = " << v[i] << endl;
#define div_ceil(a,b) ((a) + ((b) - 1)) / (b)
#define UNIQUE(v) v.erase( unique(v.begin(), v.end()), v.end() );
#define INF 0x3f3f3f3f
#define LLINF 1000111000111000111LL
#define TIME system("date +%M:%S.%N")
using Graph = vector<vector<int>>;
using ll = long long;
template<class T> T gcd(const T &a, const T &b) { return a < b ? gcd(b, a) : b ? gcd(b, a % b) : a; }
template<class T> T lcm(const T &a, const T &b) { return a / gcd(a, b) * b; }

int main() {
  int a,d;cin>>a>>d;
  int ans = a > d ? a*(d+1) : (a+1)*d;
  cout << ans << endl;
}
