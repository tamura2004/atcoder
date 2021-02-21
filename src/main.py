import sys
import numpy as np
import numba
from numba import njit, b1, i4, i8, f8
 
read = sys.stdin.buffer.read
readline = sys.stdin.buffer.readline
readlines = sys.stdin.buffer.readlines
 
MOD = 998_244_353
 
@njit((numba.types.optional(i8), ) * 2, cache=True)
def seg_f(x, y):
    if x is None:
        return y
    if y is None:
        return x
    x += y
    x1, x2 = divmod(x, 1 << 32)
    x1, x2 = x1 % MOD, x2 % MOD
    return x1 << 32 | x2
 
 
@njit((i8, i8), cache=True)
def lazy_f(a, b):
    if a == -1:
        return b
    if b == -1:
        return a
    a1, a2 = divmod(a, 1 << 32)
    b1, b2 = divmod(b, 1 << 32)
    # b1(a1x+a2)+b2
    c1, c2 = a1 * b1 % MOD, (b1 * a2 + b2) % MOD
    return c1 << 32 | c2
 
 
@njit((i8, i8), cache=True)
def operate_f(x, a):
    if a == -1:
        return x
    x1, x2 = divmod(x, 1 << 32)  # 個数、和
    a1, a2 = divmod(a, 1 << 32)  # かける、足す
    x2 = (a1 * x2 + a2 * x1) % MOD
    return x1 << 32 | x2
 
 
@njit((i8[:], i8[:], i8), cache=True)
def _eval_at(seg, lazy, i):
    return operate_f(seg[i], lazy[i])
 
 
@njit((i8[:], i8[:], i8), cache=True)
def _propagate_at(seg, lazy, i):
    seg[i] = _eval_at(seg, lazy, i)
    lazy[i << 1] = lazy_f(lazy[i << 1], lazy[i])
    lazy[i << 1 | 1] = lazy_f(lazy[i << 1 | 1], lazy[i])
    lazy[i] = -1
 
 
@njit((i8[:], ), cache=True)
def build(raw_data):
    N = len(raw_data)
    seg = np.empty(N + N, np.int64)
    seg[N:] = raw_data
    for i in range(N - 1, 0, -1):
        seg[i] = seg_f(seg[i << 1], seg[i << 1 | 1])
    return seg
 
 
@njit((i8[:], i8[:], i8), cache=True)
def _propagate_above(seg, lazy, i):
    H = 0
    while 1 << H <= i:
        H += 1
    for h in range(H - 1, 0, -1):
        _propagate_at(seg, lazy, i >> h)
 
 
@njit((i8[:], i8[:], i8), cache=True)
def _recalc_above(seg, lazy, i):
    while i > 1:
        i >>= 1
        seg[i] = seg_f(_eval_at(seg, lazy, i << 1),
                       _eval_at(seg, lazy, i << 1 | 1))
 
 
@njit((i8[:], i8[:], i8, i8), cache=True)
def set_val(seg, lazy, i, x):
    N = len(seg) // 2
    i += N
    _propagate_above(seg, lazy, i)
    seg[i], lazy[i] = x, 0
    _recalc_above(seg, lazy, i)
 
 
@njit((i8[:], i8[:], i8, i8), cache=True)
def fold(seg, lazy, l, r):
    N = len(seg) // 2
    l, r = l + N, r + N
    _propagate_above(seg, lazy, l // (l & -l))
    _propagate_above(seg, lazy, r // (r & -r) - 1)
    vl = vr = None
    while l < r:
        if l & 1:
            vl = seg_f(vl, _eval_at(seg, lazy, l))
            l += 1
        if r & 1:
            r -= 1
            vr = seg_f(_eval_at(seg, lazy, r), vr)
        l, r = l >> 1, r >> 1
    return seg_f(vl, vr)
 
 
@njit((i8[:], i8[:], i8, i8, i8), cache=True)
def operate_range(seg, lazy, l, r, x):
    N = len(seg) // 2
    l, r = l + N, r + N
    l0, r0 = l // (l & -l), r // (r & -r) - 1
    _propagate_above(seg, lazy, l0)
    _propagate_above(seg, lazy, r0)
    while l < r:
        if l & 1:
            lazy[l] = lazy_f(lazy[l], x)
            l += 1
        if r & 1:
            r -= 1
            lazy[r] = lazy_f(lazy[r], x)
        l, r = l >> 1, r >> 1
    _recalc_above(seg, lazy, l0)
    _recalc_above(seg, lazy, r0)
 
@njit((i8, i8, i8[:], i8[:]), cache=True)
def main(N, Q, A, query):
    seg = build(1 << 32 | A)
    lazy = np.full_like(seg, -1)
    for _ in range(Q):
        t = query[0]
        if t == 0:
            l, r, b, c = query[1:5]
            query = query[5:]
            operate_range(seg, lazy, l, r, b << 32 | c)
        elif t == 1:
            l, r = query[1:3]
            query = query[3:]
            x = fold(seg, lazy, l, r)
            print(x ^ x >> 32 << 32)
 
N, Q = map(int, readline().split())
A = np.array(readline().split(), np.int64)
query = np.array(read().split(), np.int64)
 
main(N, Q, A, query)