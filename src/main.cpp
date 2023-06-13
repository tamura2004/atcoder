#include <bits/stdc++.h>
using namespace std;

int main() {
    int n, c, d;
    cin >> n >> c >> d;
    vector<pair<int, int>> event(n);
    for (auto& [x, y] : event) {
        cin >> x >> y;
        x = d - x;
    }
    reverse(begin(event), end(event));
    event.emplace_back(d - 1, 0);
    priority_queue<int> heap;
    int answer = 0;

    for (const auto& [x, y] : event) {
        while (c < x) {
            if (heap.empty()) {
                cout << -1 << '\n';
                return 0;
            }
            answer += 1;
            c += heap.top();
            heap.pop();
        }
        heap.push(y);
    }
    cout << answer << '\n';
    return 0;
}
