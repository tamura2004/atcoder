#include <bits/stdc++.h>
#define ALL(a) (a).begin(), (a).end()
#define FOR(i, s, n) for (int i = (s); i < (n); i++)
#define rep(i, n) FOR(i, 0, n)
#define repi(i, n) FOR(i, 1, n + 1)
#define pp(v) cout << #v "=" << (v) << endl;
#define ppa(v) cout << "----\n"; rep(i,v.size()) cout << #v << "[" << i << "] = " << v[i] << endl;
#define div_ceil(a,b) ((a) + ((b) - 1)) / (b)
using namespace std;
using Graph = vector<vector<int>>;

int main() {
  int n,m;cin>>n>>m;
  Graph g(n);
  rep(i,m) {
    int a,b;cin>>a>>b;
    g[a].push_back(b);
    g[b].push_back(a);
  }
  vector<int> dist(n,-1);
  queue<int> que;

  dist[0] = 0;
  que.push(0);

  while (!que.empty()) {
    int v = que.front();
    que.pop();

    for (auto nv: g[v]) {
      if (dist[nv] != -1) continue;
      
      dist[nv] = dist[v] + 1;
      que.push(nv);
    }
  }
  ppa(dist);
}
