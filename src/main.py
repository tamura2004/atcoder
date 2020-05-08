n = int(input())
ans = 0


def mask(i): return 1 << ((i-3) >> 1)


def dfs(a, use):
    global ans
    if a > n:
        return
    if use == 0b111:
        ans += 1
    for i in [3, 5, 7]:
        dfs(a*10+i, use | mask(i))


dfs(0, 0)
print(ans)
