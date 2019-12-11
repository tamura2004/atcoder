#include <bits/stdc++.h>
#define rep(i, n) for (int i = 0; i < (n); i++)
#define repi(i, n) for (int i = (n)-1; i >= 0; i--)
using namespace std;

int N;
int A[15];
int X[15][15],Y[15][15];

void init() {
  cin >> N;
  rep(i,N) {
    cin >> A[i];
    rep(j,A[i]) {
      cin >> X[i][j] >> Y[i][j];
      X[i][j]--;
    }
  }
}

void disp() {
  cout << "N = " << N << endl;
  rep(i,N) {
    // cout << "A[" << i << "]=" << A[i] << endl;
    rep(j,A[i]) cout << "X=" << X[i][j] << ", Y=" << Y[i][j] << endl;
  }
}

bool valid(int bit, int i, int j) {
  bool ans = !((bit & 1<<X[i][j]) ^ (Y[i][j] << X[i][j]));
  cout << "bit=" << bit << ",X=" << X[i][j] << ",Y=" << Y[i][j] << ",Y<<X=" << (Y[i][j] << X[i][j]) << ",ans=" << ans << endl;
  return ans;
}

bool all_of(int bit) {
  bool ans = true;
  rep(i,N) if(bit&1<<i) rep(j,A[i]) ans &= valid(bit,i,j);
  return ans;
}

int count(int bit) {
  int ans = 0;
  rep(i,15) if(bit&1<<i) ans += 1;
  return ans;
}

int main() {
  init();
  // disp();
  repi(bit,1<<N) {
    if(all_of(bit)) {
      cout << count(bit) << endl;
      exit(0);
    }
  }
}
