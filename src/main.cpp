#include <bits/stdc++.h>
#define ALL(a) (a).begin(), (a).end()
#define FOR(i, s, n) for (int i = (s); i < (n); i++)
#define rep(i, n) FOR(i, 0, n)
#define repi(i, n) FOR(i, 1, n + 1)
#define pp(v) cout << #v "=" << (v) << endl;
#define ppa(v) cout << "----\n"; rep(i,v.size()) cout << #v << "[" << i << "] = " << v[i] << endl;
#define div_ceil(a,b) ((a) + ((b) - 1)) / (b)
#define UNIQUE(v) v.erase( unique(v.begin(), v.end()), v.end() );
using namespace std;
using Graph = vector<vector<int>>;
using ll = long long;

int main() {
  string s;cin>>s;
  int len = s.size();
  UNIQUE(s);
  bool ans = len == s.size();
  cout << (ans?"Yes":"No") << endl;
}
