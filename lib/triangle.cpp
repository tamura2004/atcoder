#include <bits/stdc++.h>
#define rep(i, s, n) for (int i = s; i < n; i++)
using namespace std;

int N;
int A[2000];

bool isOK(int index, int key) {
    if (A[index] < key) return true;
    else return false;
}

int main() {
  cin >> N;
  rep(i,0,N) cin >> A[i];
  sort(A,A+N);

  int cnt = 0;
  rep(i,0,N-2) rep(j,i+1,N-1) {
    // [L,R)
    int L = j, R = N;
    int key = A[i] + A[j];
    while (R - L > 1) {
      int mid = (L + R) / 2;
      (isOK(mid,key) ? L : R) = mid;
    }
    cnt += L - j;
  }
  cout << cnt << endl;
}
