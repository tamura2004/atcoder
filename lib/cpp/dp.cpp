#include <bits/stdc++.h>
using namespace std;
#define rep(i, n) for (int i = 0; i < (int)(n); i++)
typedef long long ll;

ll N,W,iw,iv;
ll DP[101][100001];
ll max(ll a, ll b) {
  if (a>b) return a; return b;
}

int main() {
  cin >> N >> W;
  rep(i,N) {
    cin >> iw >> iv;
    rep(w,W+1) {
      if (w < iw) {
        DP[i+1][w] = DP[i][w];
      } else {
        DP[i+1][w] = max(DP[i][w], DP[i][w - iw] + iv);
      }
    }
  }
  cout << DP[N][W] << endl;
}
