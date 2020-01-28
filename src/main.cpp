#include <bits/stdc++.h>
using namespace std;

#define int long long
struct Fast {Fast(){std::cin.tie(0);ios::sync_with_stdio(false);}} fast;

/* short */
#define pb push_back
#define mp make_pair
#define fst first
#define snd second
#define F first
#define S second
#define ALL(v) begin(v), end(v)

/* REPmacro */
#define FOR(i, s, n) for (int i = (s); i < (n); i++)
#define RFOR(i, s, n) for (int i = (s); i >= (n); i--)
#define rep(i, n) FOR(i, 0, n)
#define repi(i, n) FOR(i, 1, n + 1)
#define rrep(i, n) RFOR(i, n - 1, 0)
#define rrepi(i, n) RFOR(i, n, 1)

/* alias */
using ll = long long;
using ull = unsigned long long;
using vi = vector<int>;
using vvi = vector<vi>;
using vvvi = vector<vvi>;
using vd = vector<double>;
using vvd = vector<vd>;
using vvvd = vector<vvd>;
using pii = pair<int, int>;
using vpii = vector<pii>;
using vvpii = vector<pii>;
using mii = map<int, int>;
using vs = vector<string>;
using vb = vector<bool>;
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

/* input */
#define _overload(_1,_2,_3,_4,_5,_6,name,...) name
#define _g1(a) int a;cin>>a;
#define _g2(a,b) int a,b;cin>>a>>b;
#define _g3(a,b,c) int a,b,c;cin>>a>>b>>c;
#define _g4(a,b,c,d) int a,b,c,d;cin>>a>>b>>c>>d;
#define _g5(a,b,c,d,e) int a,b,c,d,e;cin>>a>>b>>c>>d>>e;
#define _g6(a,b,c,d,e,f) int a,b,c,d,e,f;cin>>a>>b>>c>>d>>e>>f;
#define in(...) _overload(__VA_ARGS__,_g6,_g5,_g4,_g3,_g2,_g1)(__VA_ARGS__)

/* debug */
#define _pp_overload(_1,_2,_3,_4,_5,_6,name,...) name
#define _p1(a) cerr << #a "=" << (a) << endl;
#define _p2(a,b) cerr << #a "=" << (a) << "," #b "=" << (b) << endl;
#define _p3(a,b,c) cerr << #a "=" << (a) << "," #b "=" << (b) << "," #c "=" << (c) << endl;
#define _p4(a,b,c,d) cerr << #a "=" << (a) << "," #b "=" << (b) << "," #c "=" << (c) << "," #d "=" << (d) << endl;
#define _p5(a,b,c,d,e) cerr << #a "=" << (a) << "," #b "=" << (b) << "," #c "=" << (c) << "," #d "=" << (d) << "," #e "=" << (e) << endl;
#define _p6(a,b,c,d,e,f) cerr << #a "=" << (a) << "," #b "=" << (b) << "," #c "=" << (c) << "," #d "=" << (d) << "," #e "=" << (e) << "," #f "=" << (f) << endl;
#define pp(...) _pp_overload(__VA_ARGS__,_p6,_p5,_p4,_p3,_p2,_p1)(__VA_ARGS__)

/* const */
// const int INF = 1001001001;
const ll INF = 1001001001001001001ll;
const int MOD = 1e9 + 7;

/* func */
#define UNIQUE(v) v.erase( unique(ALL(v)), v.end() );
#define TIME system("date +%M:%S.%N")
inline bool inside(int y, int x, int H, int W) {return y >= 0 && x >= 0 && y < H && x < W;}
inline bool odd(int x) { return x % 2 == 1;}
inline bool even(int x) { return x % 2 == 0;}
inline int sum(vi a) { return accumulate(ALL(a),0); }
inline void yn(bool ans) { cout << (ans?"Yes":"No") << endl; }
inline void YN(bool ans) { cout << (ans?"YES":"NO") << endl; }
template <typename T> inline bool chmin(T& a, const T& b) {if (a > b) a = b; return a > b;}
template <typename T> inline bool chmax(T& a, const T& b) {if (a < b) a = b; return a < b;}
template<class T> T gcd(const T &a, const T &b) { return a < b ? gcd(b, a) : b ? gcd(b, a % b) : a; }
template<class T> T lcm(const T &a, const T &b) { return a / gcd(a, b) * b; }
template<class T> T div_ceil(const T &a, const T &b) { return (a + b - 1) / b; }
template<class T> bool by_snd(const T &a, const T &b) { return a.snd < b.snd; }
inline void print_and_exit(int x) { cout << x << endl; exit(0);}
const int dx[] = {0, 1, 0, -1, 1, -1, 1, -1}, dy[] = {1, 0, -1, 0, 1, -1, -1, 1};

struct Problem {
  int n,k,w;
  vvvi dp;
  vi a,b;

  Problem(int n, int k, int w) : n(n),k(k),w(w),a(n),b(n),dp(n+1,vvi(k+1,vi(w+1,0))) {}

  void solve() {
    rep(i,n) repi(j,k) rep(h,w+1) {
      pp(i,j,h);
      if (w-a[i] >= 0) chmax(dp[i+1][j][h], dp[i][j-1][w - a[i]] + b[i]);
      chmax(dp[i+1][j][h], dp[i][j][h]);
    }
  }

  void inspect() {
    pp(n,k,w);
    pp(a,b);
    rep(i,n+1) {
      pp("----");
      rep(j,k+1) pp(dp[i][j]);
    }
  }
};

signed main() {
  in(w,n,k);
  Problem p(n,k,w);
  rep(i,n) cin>>p.a[i]>>p.b[i];
  p.solve();
  p.inspect();
  // cout << ans << endl;
}
