#include <bits/stdc++.h>

alias T = Int64

def seg_merge(segs)
  segs.sort!
  ans = [] of Tuple(T,T)
  segs.each do |seg|
    if ans.empty? || ans[-1][1] < seg[0]
      ans << seg
    else
      ans[-1] = { ans[-1][0], Math.max ans[-1][1], seg[1] }
    end
  end
  ans
end


# inline int get(int x, vector<array<int, 2>> &a, bool f)
# {
#   if (a.empty())
#     return -1;
#   if (f)
#   {
#     if (x > a.back()[1])
#       return -1;
#     int l = 0, r = int(a.size()) - 1;
#     while (l < r)
#     {
#       int mid = (l + r) >> 1;
#       if (a[mid][1] < x)
#         l = mid + 1;
#       else
#         r = mid;
#     }
#     return a[l][0] <= x ? l : -1;
#   }
#   else
#   {
#     if (x < a[0][0])
#       return -1;
#     int l = 0, r = int(a.size()) - 1;
#     while (l < r)
#     {
#       int mid = (l + r + 1) >> 1;
#       if (a[mid][0] > x)
#         r = mid - 1;
#       else
#         l = mid;
#     }
#     return a[l][1] >= x ? l : -1;
#   }
# }

# vector<array<int, 2>> seg[N];
# int n, m, q;
# int f[N][20];

# int main()
# {
#   ios::sync_with_stdio(false);
#   cin.tie(nullptr);
#   cin >> n >> m >> q;
#   for (int i = 1; i <= m; i++)
#   {
#     int a, b, c;
#     cin >> a >> b >> c;
#     seg[a].push_back({b, c});
#   }
#   for (int i = 1; i <= n; i++)
#     seg_merge(seg[i]);
#   vector<array<int, 2>> a;
#   for (int i = 1; i <= n; i++)
#     for (int j = 0; j < seg[i].size(); j++)
#       a.push_back(seg[i][j]);
#   sort(a.begin(), a.end(), [&](array<int, 2> i, array<int, 2> j)
#        {
#          if (i[0] != j[0])
#            return i[0] < j[0];
#          return i[1] > j[1];
#        });
#   vector<array<int, 2>> b;
#   for (int i = 0; i < a.size(); i++)
#     if (b.empty() || a[i][1] > b.back()[1])
#       b.push_back(a[i]);
#   for (int i = 0; i < b.size(); i++)
#     memset(f[i], -1, sizeof(f[i]));
#   for (int i = 0, j = 0; i < b.size(); i++)
#   {
#     while (j + 1 < b.size() && b[j + 1][0] <= b[i][1])
#       j++;
#     if (j > i)
#       f[i][0] = j;
#   }
#   for (int j = 1; j <= __lg(b.size()); j++)
#     for (int i = 0; i < b.size(); i++)
#       if (f[i][j - 1] != -1)
#         f[i][j] = f[f[i][j - 1]][j - 1];
#   while (q--)
#   {
#     int x, y, z, w;
#     cin >> x >> y >> z >> w;
#     if (y > w)
#       swap(x, z), swap(y, w);
#     int dh = w - y;
#     int pl = get(y, seg[x], false);
#     if (pl != -1)
#       y = seg[x][pl][1];
#     int pr = get(w, seg[z], true);
#     if (pr != -1)
#       w = seg[z][pr][0];
#     if (y >= w)
#     {
#       cout << dh + (x != z) << "\n";
#       continue;
#     }
#     pl = get(y, b, false);
#     pr = get(w, b, true);
#     if (min(pl, pr) == -1)
#     {
#       cout << -1 << "\n";
#       continue;
#     }
#     if (pl >= pr)
#     {
#       cout << dh + 2 << "\n";
#       continue;
#     }
#     int ans = dh + 2;
#     for (int j = __lg(b.size()); pl <= pr && j >= 0; j--)
#     {
#       if (f[pl][j] != -1 && f[pl][j] <= pr)
#         pl = f[pl][j], ans += 1 << j;
#     }
#     if (pl < pr)
#       ans = f[pl][0] == -1 ? -1 : ans + 1;
#     cout << ans << "\n";
#   }
#   return 0;
# }