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

int n,m;

vector<bool> seen;
void dfs(Graph &g, int v, int depth) {
  seen[v] = true;
  if (depth > 2) return;
  if (depth <= 2 && (v + 1) == n) {
    cout << "POSSIBLE" << endl;
    exit(0);
  }
  for (auto next_v : g[v]) {
    if (seen[next_v]) continue;
    dfs(g, next_v, depth+1);
  }
}

int main() {
  cin>>n>>m;
  Graph g(n);rep(i,m) {
    int a,b;cin>>a>>b;a--;b--;
    g[a].push_back(b);
    g[b].push_back(a);
  }
  seen.assign(n,false);
  dfs(g, 0, 0);
  cout << "IMPOSSIBLE" << endl;
}
