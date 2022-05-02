#include <bits/stdc++.h>
#include <atcoder/fenwicktree>

using namespace std;
using namespace atcoder;

int main()
{
	int n, q;
	cin >> n >> q;

	fenwick_tree<long long> fw(n);
	for (int i = 0; i < n; i++) {
		int a;
		cin >> a;
		fw.add(i, a);
	}

	for (int i = 0; i < q; i++) {
		int a,b,c;
		cin >> a >> b >> c;

		if (a == 0) fw.add(b, c);
		if (a == 1) cout << fw.sum(b,c) << endl;
	}
}