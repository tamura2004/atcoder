#include <bits/stdc++.h>
#define rep(i, n) for (int i = 0; i < n; i++)
using namespace std;

int N,K;
int A[100];

bool valid(int bit) {
  int sum = 0;
  rep(j,N) if(bit&1<<j) sum += A[j];
  return sum == K;
}

bool any_of() {
  bool ans = false;
  rep(i,1<<N) if (valid(i)) ans = true;
  return ans;
}

int main() {
  cin >> N >> K;
  rep(i,N) cin >> A[i];
  cout << (any_of() ? "Yes" : "No") << endl;
}
