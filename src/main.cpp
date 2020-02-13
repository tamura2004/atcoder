#include <bits/stdc++.h>
using namespace std;

struct Fast {Fast(){std::cin.tie(0);ios::sync_with_stdio(false);}} fast;
#define int long long

/* short */
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
template<typename T> istream &operator>>(istream &is, pair<T,T> &p){ int a,b;is>>a>>b;p=make_pair(a,b);return is;}
template<typename T> ostream &operator<<(ostream &os, const vector<T> &vec){ os << "["; for (auto v : vec) os << v << ","; os << "]"; return os; }
template<typename T> ostream &operator<<(ostream &os, const deque<T> &vec){ os << "deq["; for (auto v : vec) os << v << ","; os << "]"; return os; }
template<typename T> ostream &operator<<(ostream &os, const set<T> &vec){ os << "{"; for (auto v : vec) os << v << ","; os << "}"; return os; }
template<typename T> ostream &operator<<(ostream &os, const multiset<T> &vec){ os << "{"; for (auto v : vec) os << v << ","; os << "}"; return os; }
template<typename T1, typename T2> ostream &operator<<(ostream &os, const pair<T1, T2> &pa){ os << "(" << pa.first << "," << pa.second << ")"; return os; }
template<typename TK, typename TV> ostream &operator<<(ostream &os, const map<TK, TV> &mp){ os << "{"; for (auto v : mp) os << v.first << "=>" << v.second << ","; os << "}"; return os; }
template<typename T> istream &operator>>(istream &is, complex<T> &c){ T x,y;is>>x>>y;c=complex<T>(x,y);return is;}

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

/* 基本要素 */

typedef double D;      // 座標値の型。doubleかlong doubleを想定
typedef complex<D> P;  // Point
typedef pair<P, P> L;  // Line
typedef vector<P> VP;
const D EPS = 1e-9;    // 許容誤差。問題によって変える
#define X real()
#define Y imag()
#define LE(n,m) ((n) < (m) + EPS)
#define GE(n,m) ((n) + EPS > (m))
#define EQ(n,m) (abs((n)-(m)) < EPS)

// 内積　dot(a,b) = |a||b|cosθ
D dot(P a, P b) {
  return (conj(a)*b).X;
}
// 外積　cross(a,b) = |a||b|sinθ
D cross(P a, P b) {
  return (conj(a)*b).Y;
}

// 点の進行方向
int ccw(P a, P b, P c) {
  b -= a;  c -= a;
  if (cross(b,c) >  EPS) return +1;  // counter clockwise
  if (cross(b,c) < -EPS) return -1;  // clockwise
  if (dot(b,c)   < -EPS) return +2;  // c--a--b on line
  if (norm(b) < norm(c)) return -2;  // a--b--c on line or a==b
  return 0;                          // a--c--b on line or a==c or b==c
}

/* 交差判定　直線・線分は縮退してはならない。接する場合は交差するとみなす。isecはintersectの略 */

// 直線と点
bool isecLP(P a1, P a2, P b) {
  return abs(ccw(a1, a2, b)) != 1;  // return EQ(cross(a2-a1, b-a1), 0); と等価
}

// 直線と直線
bool isecLL(P a1, P a2, P b1, P b2) {
  return !isecLP(a2-a1, b2-b1, 0) || isecLP(a1, b1, b2);
}

// 直線と線分
bool isecLS(P a1, P a2, P b1, P b2) {
  return cross(a2-a1, b1-a1) * cross(a2-a1, b2-a1) < EPS;
}

// 線分と線分
bool isecSS(P a1, P a2, P b1, P b2) {
  return ccw(a1, a2, b1)*ccw(a1, a2, b2) <= 0 &&
         ccw(b1, b2, a1)*ccw(b1, b2, a2) <= 0;
}

// 線分と点
bool isecSP(P a1, P a2, P b) {
  return !ccw(a1, a2, b);
}


/* 距離　各直線・線分は縮退してはならない */

// 点pの直線aへの射影点を返す
P proj(P a1, P a2, P p) {
  return a1 + dot(a2-a1, p-a1)/norm(a2-a1) * (a2-a1);
}

// 点pの直線aへの反射点を返す
P reflection(P a1, P a2, P p) {
  return 2.0*proj(a1, a2, p) - p;
}

D distLP(P a1, P a2, P p) {
  return abs(proj(a1, a2, p) - p);
}

D distLL(P a1, P a2, P b1, P b2) {
  return isecLL(a1, a2, b1, b2) ? 0 : distLP(a1, a2, b1);
}

D distLS(P a1, P a2, P b1, P b2) {
  return isecLS(a1, a2, b1, b2) ? 0 : min(distLP(a1, a2, b1), distLP(a1, a2, b2));
}

D distSP(P a1, P a2, P p) {
  P r = proj(a1, a2, p);
  if (isecSP(a1, a2, r)) return abs(r-p);
  return min(abs(a1-p), abs(a2-p));
}

D distSS(P a1, P a2, P b1, P b2) {
  if (isecSS(a1, a2, b1, b2)) return 0;
  return min(min(distSP(a1, a2, b1), distSP(a1, a2, b2)),
             min(distSP(b1, b2, a1), distSP(b1, b2, a2)));
}

// 2直線の交点
P crosspointLL(P a1, P a2, P b1, P b2) {
  D d1 = cross(b2-b1, b1-a1);
  D d2 = cross(b2-b1, a2-a1);
  if (EQ(d1, 0) && EQ(d2, 0)) return a1;  // same line
  if (EQ(d2, 0)) throw "kouten ga nai";   // 交点がない
  return a1 + d1/d2 * (a2-a1);
}


/* 円 */

D distLC(P a1, P a2, P c, D r) {
  return max(distLP(a1, a2, c) - r, 0.0);
}

D distSC(P a1, P a2, P c, D r) {
  D dSqr1 = norm(c-a1), dSqr2 = norm(c-a2);
  if (dSqr1 < r*r ^ dSqr2 < r*r) return 0;  // 円が線分を包含するとき距離0ならここをORに変える
  if (dSqr1 < r*r & dSqr2 < r*r) return r - sqrt(max(dSqr1, dSqr2));
  return max(distSP(a1, a2, c) - r, 0.0);
}

VP crosspointLC(P a1, P a2, P c, D r) {
  VP ps;
  P ft = proj(a1, a2, c);
  if (!GE(r*r, norm(ft-c))) return ps;

  P dir = sqrt(max(r*r - norm(ft-c), 0.0)) / abs(a2-a1) * (a2-a1);
  ps.push_back(ft + dir);
  if (!EQ(r*r, norm(ft-c))) ps.push_back(ft - dir);
  return ps;
}

// 三角形の外心。点a,b,cは同一線上にあってはならない
P circumcenter(P a, P b, P c) {
  a = (a-c)*0.5;
  b = (b-c)*0.5;
  return c + crosspointLL(a, a*P(1,1), b, b*P(1,1));
}

signed main() {
  P a(0,0),b(9,1),c(1,9);
  P ans = circumcenter(a,b,c);
  pp(ans);
}
