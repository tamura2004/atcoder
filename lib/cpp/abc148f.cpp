#include <bits/stdc++.h>
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
using namespace std;
using Graph = vector<vector<int>>;
using ll = long long;

Graph g; // グラフ
vector<int> dist; // 青木さんからの距離
vector<bool> seen; // 訪問済
void dfs(int v, int d) { // 頂点v(0-origin)を深さdとして訪問
  seen[v] = true;
  dist[v] = d;
  for (auto nv : g[v]) {
    if (!seen[nv]) dfs(nv,d+1);
  }
}

int cnt = 0;
int ans = 0; // 最長手番を更新
void escape(int v, int d) { // 高橋さんの逃走。頂点vをd手目に訪問
  cnt++;
  if (cnt > 1000000) {
    pp(v);
    pp(d);
    pp(dist[v]);
    pp(ans);
    exit(0);
  }
  ans = max(ans, d);
  for (auto nv : g[v]) {
    // pp(nv);
    // pp(dist[nv]);
    if (dist[nv] > d+1) {
      escape(nv, d+1);
    } else if (dist[nv] == d+1) {
      ans = max(ans, d+1); // 移動できるが直後につかまる
    }
  }
}

int main() {
  TIME;

  ios::sync_with_stdio(false);
  cin.tie(nullptr);

  int n,u,v;cin>>n>>u>>v;
  v--;u--;
  g.reserve(n);rep(i,n-1) {
    int a,b; cin>>a>>b; a--; b--;
    g[a].push_back(b);
    g[b].push_back(a);
  }
  TIME;
  // ppa(g[1]);
  // ppa(g[2]);
  // ppa(g[3]);
  // ppa(g[4]);

  dist.reserve(n);
  seen.reserve(n);
  TIME;
  fill(ALL(dist),0);
  fill(ALL(seen),false);
  exit(0);
  dfs(v,0); // 青木君の初期位置を距離０として開始
  TIME;

  escape(u,0); // 高橋君の初期位置から逃走開始
  TIME;
  exit(0);
  cout << ans << endl;
}
