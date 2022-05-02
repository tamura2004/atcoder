import sys
import io, os
input = sys.stdin.readline

from decimal import Decimal, ROUND_HALF_UP

def main():
    n = int(input())
    W = set()
    LSM = []
    for i in range(n):
        l, m, s = map(str, input().split())
        m = int(m)
        W.add(l)
        W.add(s)
        LSM.append((l, s, m))

    W = list(W)
    toid = {}
    for i, w in enumerate(W):
        toid[w] = i

    N = len(W)
    g = [[] for i in range(N)]
    for l, s, m in LSM:
        l = toid[l]
        s = toid[s]
        g[l].append((Decimal(1/m), s))
        g[s].append((Decimal(m), l))
    M = Decimal(1)
    a,b = -1, -1
    for i in range(N):
        stack = []
        stack.append(i)
        dist = [-1]*N
        dist[i] = Decimal(1)
        while stack:
            v = stack.pop()
            for w, u in g[v]:
                if dist[u] != -1:
                    continue
                dist[u] = w*dist[v]
                stack.append(u)
                if dist[u] > M:
                    M = dist[u]
                    a, b = u, i
    print('1'+W[a]+'='+str(M.quantize(Decimal('0'), rounding=ROUND_HALF_UP))+W[b])

if __name__ == '__main__':
    main()
