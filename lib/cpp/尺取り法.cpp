#include <bits/stdc++.h>
using namespace std;

#define int long long
struct Fast {Fast(){std::cin.tie(0);ios::sync_with_stdio(false);}} fast;

/* short */
#define pb push_back
#define mp make_pair
#define fst first
#define snd second
#define ALL(v) begin(v), end(v)

/* REPmacro */
#define FOR(i, s, n) for (int i = (s); i < (n); i++)
#define RFOR(i, s, n) for (int i = (s); i >= (n); i--)
#define rep(i, n) FOR(i, 0, n)
#define repi(i, n) FOR(i, 1, n + 1)
#define rrep(i, n) RFOR(i, n - 1, 0)
#define rrepi(i, n) RFOR(i, n, 1)

/* debug */
#define pp(v) cerr << #v "=" << (v) << endl;

/* alias */
using ll = long long;
using ull = unsigned long long;
using vi = vector<int>;
using vvi = vector<vi>;
using vvvi = vector<vvi>;
using pii = pair<int, int>;
using vpii = vector<pii>;
using mii = map<int, int>;
using vs = vector<string>;
using Graph = vvi;
template <typename T> using PQ = priority_queue<T>;
template <typename T> using minPQ = priority_queue<T, vector<T>, greater<T>>;

/* iostream */
template<typename T> istream &operator>>(istream &is, vector<T> &vec){ for (auto &v : vec) is >> v; return is; }
template<typename T> istream &operator>>(istream &is, pair<T,T> &p){ int a,b;is>>a>>b;p=mp(a,b);return is;}
template<typename T> ostream &operator<<(ostream &os, const vector<T> &vec){ os << "["; for (auto v : vec) os << v << ","; os << "]"; return os; }
template<typename T> ostream &operator<<(ostream &os, const deque<T> &vec){ os << "deq["; for (auto v : vec) os << v << ","; os << "]"; return os; }
template<typename T> ostream &operator<<(ostream &os, const set<T> &vec){ os << "{"; for (auto v : vec) os << v << ","; os << "}"; return os; }
template<typename T> ostream &operator<<(ostream &os, const multiset<T> &vec){ os << "{"; for (auto v : vec) os << v << ","; os << "}"; return os; }
template<typename T1, typename T2> ostream &operator<<(ostream &os, const pair<T1, T2> &pa){ os << "(" << pa.first << "," << pa.second << ")"; return os; }
template<typename TK, typename TV> ostream &operator<<(ostream &os, const map<TK, TV> &mp){ os << "{"; for (auto v : mp) os << v.first << "=>" << v.second << ","; os << "}"; return os; }

/* const */
const int INF = 1001001001;
const ll LINF = 1001001001001001001ll;
const int MOD = 1e9 + 7;
const int dx[] = {0, 1, 0, -1, 1, -1, 1, -1}, dy[] = {1, 0, -1, 0, 1, -1, -1, 1};

/* func */
#define UNIQUE(v) v.erase( unique(ALL(v)), v.end() );
#define TIME system("date +%M:%S.%N")
inline bool inside(int y, int x, int H, int W) {return y >= 0 && x >= 0 && y < H && x < W;}
template <typename T> inline bool chmin(T& a, const T& b) {if (a > b) a = b; return a > b;}
template <typename T> inline bool chmax(T& a, const T& b) {if (a < b) a = b; return a < b;}
template<class T> T gcd(const T &a, const T &b) { return a < b ? gcd(b, a) : b ? gcd(b, a % b) : a; }
template<class T> T lcm(const T &a, const T &b) { return a / gcd(a, b) * b; }
template<class T> T div_ceil(const T &a, const T &b) { return (a + b - 1) / b; }
template<class T> bool by_snd(const T &a, const T &b) { return a.snd < b.snd; }
// usage: vpii a(n);rep(i,n) cin>>a[i]; sort(ALL(a),by_snd<pii>);

signed main() {
  int n,k;cin>>n>>k;
  vi s(n);cin>>s;

  bool zero = false;
  rep(i,n) if (s[i]==0) zero = true;
  if (zero) {
    cout << n << endl;
    exit(0);
  }

  int lo = 0, hi = 0, ans = 0;
  int len = 0;
  int cp = 1;
  while (lo < n) {
    if (cp * s[hi] <= k) { // 伸ばす
      cp *= s[hi];
      len++;
      hi++;
    } else {
      chmax(ans,len);
      while (lo <= hi && cp * s[hi] > k) { // 縮める
        len--;
        cp /= s[lo];
        lo++;
      }
      if (lo > hi) {
        cp = 1;
        hi++;
      }
    }
  }
  cout << max(ans,len) << endl;
}
