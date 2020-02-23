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

template <class T>
void exgcd(T a, T b, T& x, T& y)
{
	if (b != 0) { exgcd(b, a % b, y, x); y -= a / b * x; }
	else { x = 1; y = 0; }
}

// https://gist.github.com/ttsuki/f3bb54694c90fa9031a7
// Mod な n! nCr nPr nHr を求める。
// 初期化に O(n) sizeof(ll) * n * 3 のメモリを要する 1000万(10^7)で256MBギリ
// 初期化してしまえば、あとは O(1)
struct ModCombination
{
	// modFact[n] = MODを法とした n!
	vector<ll> modFact{};
	void initModFact(int N, ll MOD)
	{
		modFact.clear();
		modFact.reserve(N + 1);
		ll r = 1;
		modFact.push_back(r);
		FOR(i, 1, N + 1)
		{
			r = r * i % MOD;
			modFact.push_back(r);
		}
	}

	// modInv[n] = MODを法とした n の逆元
	vector<ll> modInv{};
	void initModInv(int N, ll MOD)
	{
		modInv.clear();
		modInv.reserve(N + 1);
		modInv.push_back(0);
		modInv.push_back(1);
		FOR(i, 2, N + 1)
		{
			modInv.push_back(modInv[MOD % i] * (MOD - MOD / i) % MOD);
		}
	}

	// modFactInv[n] = MODを法とした n! の逆元
	vector<ll> modFactInv{};
	void initModFactInv(int N, ll MOD)
	{
		modFactInv.clear();
		modFactInv.reserve(N + 1);
		ll r = 1;
		modFactInv.push_back(r);
		FOR(i, 1, N + 1)
		{
			r = r * modInv[i] % MOD;
			modFactInv.push_back(r);
		}
	}

	int N;
	ll MOD;
	ModCombination(int N, ll MOD) : N(N), MOD(MOD)
	{
		initModFact(N + 1, MOD);
		initModInv(N + 1, MOD);
		initModFactInv(N + 1, MOD);
	}

	ll Fact(int n) { return modFact[n]; }
	ll Permutation(int n, int k) { return k >= 0 && n >= k ? modFact[n] * modFactInv[n - k] % MOD : 0; }
	ll Combination(int n, int k) { return k >= 0 && n >= k ? Permutation(n, k) * modFactInv[k] % MOD : 0; }
	ll HomogeneousProduct(int n, int k) { return n == 0 && k == 0 ? 1 : Combination(n + k - 1, k); }
};


// modを法としたxのy乗を求める。(繰り返し二乗法)
inline ll modPow(ll x, ll y, ll mod)
{
	ll r = 1;
	for (; y > 0; y >>= 1)
	{
		if (y & 1) { r = r * x % mod; }
		x = x * x % mod;
	}
	return r;
}

// modを法としたaの逆元を求める。
// 要件: a と mod は互いに素
ll modInv(ll a, ll mod) { ll x, y; exgcd(a, mod, x, y); return x >= 0 ? x : x + mod; }

// modを法とした1..nの逆元をまとめて求める。O(n)
// 要件: 1..n と mod は互いに素。
vector<int> modInvs(int n, int mod)
{
	vector<int> ret(n + 1);
	ret[1] = 1;
	for (int i = 2; i <= n; ++i)
	{
		ret[i] = ret[mod % i] * (mod - mod / i) % mod;
	}
	return ret;
}

// modを法としてx/yを計算する。O(exgcd)
inline ll modDiv(ll x, ll y, ll mod)
{
	return (x * modInv(y, mod) + mod) % mod;
}


// modが素数のとき、modを法としたaの逆元を求める。O(log mod_prime)
inline ll modInvPrime(ll a, ll mod_prime) { return modPow(a, mod_prime - 2, mod_prime); }

// modが素数のとき、modを法としてx/yを計算する。O(log mod_prime)
inline ll modDivPrime(ll x, ll y, ll mod_prime) { return x * modInvPrime(y, mod_prime) % mod_prime; }

ModCombination m(500000, MOD);

int nCk(int n, int k) {
  int ans = n;
  FOR(i,2,k+1) {
    (ans *= n - i + 1) %= MOD;
    (ans *= m.modInv[i]) %= MOD;
    
  }
  return ans;
}

signed main() {
  in(n,k);
  if (k < n) {
    int ans = m.HomogeneousProduct(n,k);
    (ans *= m.Combination(n,k)) %= MOD;
    cout << ans << endl;
  } else {
    int ans = m.HomogeneousProduct(n,n);
    cout << ans << endl;
  }
}
