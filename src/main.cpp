#include <bits/stdc++.h>

using namespace std;
const int N = 2e5 + 10;

void seg_merge(vector<array<int, 2>> &seg) {
    if (seg.empty())return;
    sort(seg.begin(), seg.end());
    vector<array<int, 2>> tmp;
    int st = seg[0][0], ed = seg[0][1];
    for (int j = 1; j < seg.size(); j++) {
        if (seg[j][0] <= ed) ed = max(seg[j][1], ed);
        else {
            tmp.push_back({st, ed});
            st = seg[j][0];
            ed = seg[j][1];
        }
    }
    tmp.push_back({st, ed});
    seg.swap(tmp);
    sort(seg.begin(), seg.end());
}

inline int get(int x, vector<array<int, 2>> &a, bool f) {
    if (a.empty())return -1;
    if (f) {
        if (x > a.back()[1])return -1;
        int l = 0, r = int(a.size()) - 1;
        while (l < r) {
            int mid = (l + r) >> 1;
            if (a[mid][1] < x)l = mid + 1;
            else r = mid;
        }
        return a[l][0] <= x ? l : -1;
    } else {
        if (x < a[0][0])return -1;
        int l = 0, r = int(a.size()) - 1;
        while (l < r) {
            int mid = (l + r + 1) >> 1;
            if (a[mid][0] > x)r = mid - 1;
            else l = mid;
        }
        return a[l][1] >= x ? l : -1;
    }
}

vector<array<int, 2>> seg[N];
int n, m, q;
int f[N][20];

int main() {
    vector<array<int, 2>> b;
    b.push_back({1,2});
    b.push_back({3,4});
    b.push_back({3,4});
    b.push_back({3,4});
    b.push_back({3,4});
    b.push_back({3,4});
    b.push_back({3,4});
    b.push_back({3,4});
    b.push_back({3,4});
    b.push_back({3,4});
    b.push_back({3,4});
    b.push_back({3,4});
    b.push_back({3,4});
    b.push_back({3,4});
    b.push_back({3,4});
    cout << b.size() << " " << __lg(b.size()) << endl;
    b.push_back({3,4});
    cout << b.size() << " " << __lg(b.size()) << endl;
    b.push_back({3,4});
    cout << b.size() << " " << __lg(b.size()) << endl;
}