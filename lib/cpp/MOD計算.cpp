#include <bits/stdc++.h>
using namespace std;

/* REPmacro */
#define FOR(i, s, n) for (int i = (s); i < (n); i++)
#define RFOR(i, s, n) for (int i = (s); i >= (n); i--)
#define rep(i, n) FOR(i, 0, n)
#define repi(i, n) FOR(i, 1, n + 1)
#define rrep(i, n) RFOR(i, n - 1, 0)
#define rrepi(i, n) RFOR(i, n, 1)

/* alias */
using ll = long long;

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
