import sys
import numpy as np
from functools import lru_cache
from collections import deque

read = sys.stdin.buffer.read
readline = sys.stdin.buffer.readline
readlines = sys.stdin.buffer.readlines

def from_prufer(A):
    """N頂点のラベル付き根付き木を prufer コードから生成。
    [0,N) ^ {N-2} を入力として、親の列を返す。根は N - 1
    """
    N = len(A)
    deg = np.ones(N + 2, np.int64)
    par = np.zeros(N + 1, np.int64)
    for i in A:
        deg[i] += 1
    for i in A:
        for j in range(N + 2):
            if deg[j] == 1:
                par[j] = i
                deg[i] -= 1
                deg[j] -= 1
                break
    u, v = np.where(deg == 1)[0]
    par[u] = v
    return par


@lru_cache(None)
def all_spanning_tree(N):
    K = N**(N - 2)
    trees = np.zeros((K, N - 1), np.int64)
    for k in range(K):
        A = np.empty(N - 2, np.int64)
        x = k
        for i in range(N - 2):
            x, A[i] = divmod(x, N)
        trees[k] = from_prufer(A)
    return trees

def spanning_tree_costs(G, tree):
    N = len(G)
    T = len(tree)
    res = np.zeros(T, np.int64)
    for t in range(T):
        cost = 0
        for v in range(N - 1):
            w = tree[t, v]
            if G[v, w] == 0:
                cost = 0
                break
            cost += G[v, w]
        res[t] = cost
    res = res[res > 0]
    full = G.sum() // 2
    return full - res

if sys.argv[-1] == 'ONLINE_JUDGE':
    import numba
    from numba import njit, b1, i4, i8, f8
    from numba.pycc import CC
    cc = CC('my_module')

    def cc_export(f, signature):
        cc.export(f.__name__, signature)(f)
        return numba.njit(f)

    from_prufer = cc_export(from_prufer, (i8[:], ))
    spanning_tree_costs = cc_export(spanning_tree_costs, (i8[:, :], i8[:, :]))
    cc.compile()

def main(A, T, K, nums):
    city = []
    for _ in range(A):
        N = nums[0]
        city.append(nums[1:1 + N] - 1)
        nums = nums[1 + N:]
    G_li = nums[1:].reshape(-1, 3)
    G = np.zeros((T, T), np.int64)
    for a, b, c in G_li:
        a, b = a - 1, b - 1
        G[a, b] = G[b, a] = c
    cost_full = 0
    polys = deque()
    for C in city:
        size = len(C)
        GC = G[C, :][:, C]
        tree = all_spanning_tree(size)
        costs = spanning_tree_costs(GC, tree)
        polys.append(np.bincount(costs))

    def mul(P, Q):
        R = np.convolve(P, Q)
        R[R > K] = K
        return R

    while len(polys) > 1:
        P = polys.popleft()
        Q = polys.popleft()
        polys.append(mul(P, Q))
    P = polys[0]
    cnt = P.cumsum()
    if cnt[-1] < K:
        return -1
    else:
        return np.searchsorted(cnt, K)

from my_module import from_prufer, spanning_tree_costs

A, T, K = map(int, readline().split())
nums = np.array(read().split(), np.int64)

print(main(A, T, K, nums))