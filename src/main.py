import sys
import numpy as np
# import numba
# from numba import njit, b1, i4, i8, f8
 
read = sys.stdin.buffer.read
readline = sys.stdin.buffer.readline
readlines = sys.stdin.buffer.readlines
 
@njit((b1[:], ), cache=True)
def main(S):
    I = np.where(S)[0]
    N = len(I)
    if N == 0:
        return 0
    dp = np.zeros((N, N), np.int64)
    for n in range(1, N):
        for l in range(N - n):
            r = l + n
            if n == 1:
                dp[l, r] = (I[r] == I[l] + 2)
                continue
            # とりあえず、(l, r) ではとらない場合の計算
            for m in range(l, r):
                dp[l, r] = max(dp[l, r], dp[l, m] + dp[m + 1, r])
            # l, r をペアにできるかどうか判定
            l1, r1 = l + 1, r - 1
            k = (I[l1] - I[l] - 1) + (I[r] - I[r1] - 1)
            if k != 1:
                continue
            if dp[l1, r1] * 3 == I[r1] - I[l1] + 1:
                dp[l, r] = (I[r] - I[l] + 1) // 3
    return dp[0, -1]
 
S = np.array(list(read().rstrip()), np.int64)
S = S == ord('i')
 
print(main(S))