#include <bits/stdc++.h>
using namespace std;
#define rep(i, n) for (int i = 0; i < (n); i++)
typedef long long ll;

int main() {
  int N, L[100];
  cin >> N;
  rep(i,N) cin >> L[i];
  sort(L,L+N);
  
  int MAX = L[N-1];
  int SUM = 0;
  rep(i,N-1) SUM += L[i];
  cout << (MAX < SUM ? "Yes" : "No") << endl;
}
