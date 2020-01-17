#include <bits/stdc++.h>
using namespace std;

/* REPmacro */
#define FOR(i, s, n) for (int i = (s); i < (n); i++)
#define RFOR(i, s, n) for (int i = (s); i >= (n); i--)
#define rep(i, n) FOR(i, 0, n)

/* alias */
using vi = vector<int>;

// https://snuke.hatenablog.com/entry/2014/12/03/214243
vi string_mp(string &s) {
  int n = s.size();
  vi a(n+1);
  a[0] = -1;
  int j = -1;
  rep(i,n) {
    while (j >= 0 && s[i] != s[j]) j = a[j];
    j++;
    a[i+1] = j;
  }
  return a;
}

vi string_manachar(string &s) {
  int n = s.size();
  vi a(n);
  int i = 0, j = 0;
  while (i < n) {
    while (0 <= i-j && i+j < n && s[i-j] == s[i+j]) j++;
    a[i] = j;
    int k = 1;
    while (0 <= i-k && i+k < n && k + a[i-k] < j) a[i+k] = a[i-k], k++;
    i += k; j -= k;
  }
  return a;
}

vi string_z_algorithm(string &s) {
  int n = s.size();
  vi a(n);
  a[0] = n;
  int i = 1, j = 0;
  while (i < n) {
    while (i+j < n && s[j] == s[i+j]) j++;
    a[i] = j;
    if (j == 0) { i++; continue; }
    int k = 1;
    while (i+k < n && k + a[k] < j) a[i+k] = a[k], k++;
    i += k; j -= k;
  }
  return a;
}