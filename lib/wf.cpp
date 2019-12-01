#include <bits/stdc++.h>
using namespace std;
#define rep(i, n) for (int i = 0; i < (n); i++)
typedef long long ll;
const int INF = 1e9+5;
int n,m,l,a,b,c,d[305][305];
void wf(){rep(k,n) rep(i,n) rep(j,n) d[i][j] = min(d[i][j], d[i][k] + d[k][j]);}

int main() {
  cin >> n >> m >> l; n++;
  fill(d[0],d[n],INF);
  rep(i,m) {
    cin >> a >> b >> c;
    d[a][b] = d[b][a] = c;
  }
  wf();
  rep(i,n) rep(j,n) d[i][j] = d[i][j] <= l ? 1 : INF;
  wf();
  cin >> c;
  rep(i,c) {
    cin >> a >> b;
    cout << (d[a][b] == INF ? -1 : d[a][b] - 1) << endl;
  }
}
