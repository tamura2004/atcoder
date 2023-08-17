n, m = [int(s) for s in input().split()]
s = [c for c in input()]
c = [int(s) - 1 for s in input().split()]

ix = [[] for _ in range(m)]
for i in range(n):
  ix[c[i]].append(i)

ans = [-1 for _ in range(n)]
for i in range(m):
  row = ix[i]
  k = len(row)
  for j in range(k):
    jj = (j + 1) % k
    ans[row[jj]] = row[j]

print("".join([s[i] for i in ans]))