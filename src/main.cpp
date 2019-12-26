#include <bits/stdc++.h>
#include <cmath>
using namespace std;

#define ALL(a) (a).begin(), (a).end()
#define FOR(i, s, n) for (int i = (s); i < (n); i++)
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
using ll = long long;
template<class T> T gcd(const T &a, const T &b) { return a < b ? gcd(b, a) : b ? gcd(b, a % b) : a; }
template<class T> T lcm(const T &a, const T &b) { return a / gcd(a, b) * b; }

struct Counter {
  map<int,int> acc;
  priority_queue<pair<int,int>> pq;
  void add(int a) {
    acc[a]++;
  }
  void collect() {
    for (auto p : acc) pq.push(make_pair(p.second,p.first));
  }
  int cnt() {
    return pq.empty() ? 0 : pq.top().first;
  }
  int num() {
    return pq.top().second;
  }
};

int main() {
  int n;cin>>n;
  Counter a,b;
  rep(i,n/2) {
    int x,y;cin>>x>>y;
    a.add(x); b.add(y);
  }
  a.collect(); b.collect();
  if (a.cnt() < b.cnt()) swap(a,b);

  int ans = n/2 - a.cnt();
  if (a.num() == b.num()) b.pq.pop();
  pp(ans);
  pp(a.cnt());pp(b.cnt());
  pp(a.num());pp(b.num());
  ans += n/2 - b.cnt(); 
  cout << ans << endl;
}
