struct WeightedGraph {
  int n;
  vector<vector<pair<int,int>>> edges;
  WeightedGraph(int n) : n(n),edges(n,vpii()) {}

  void add(int a, int b, int c) {
    edges[a].pb(mp(c,b));
  }

  vi dijkstra(int s) {
    vi d(n, INF);
    priority_queue<pii,vpii,greater<pii>> q;
    d[s] = 0;
    q.push(pii(0,s));
    while (!q.empty()) {
      pii p = q.top(); q.pop();
      int v = p.S;
      if (d[v] < p.F) continue;
      for (auto e : edges[v]) {
        if (d[e.S] > d[v] + e.F) {
          d[e.S] = d[v] + e.F;
          q.push(mp(d[e.S],e.S));
        }
      }
    }
    return d;
  }
};

signed main() {
  in(n,m);
  WeightedGraph g(n);
  rep(i,m) {
    in(a,b,c);a--;b--;
    g.add(a,b,c);
    g.add(b,a,c);
  }
  vi d = g.dijkstra(0);
  pp(d);
  // cout << ans << endl;
}