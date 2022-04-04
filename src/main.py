import sys
import numpy as np

read = sys.stdin.buffer.read
readline = sys.stdin.buffer.readline
readlines = sys.stdin.buffer.readlines

def main(A):
    print(A)
    A = A - 1
    print(A)
    N = len(A) // 3
    A = np.append(A, (N, N))
    print(A)
    INF = 1 << 30
    dp = np.full((N + 1, N + 1), -INF, np.int64)
    a, b = A[:2]
    print(a)
    print(b)
    dp[a, b] = dp[b, a] = 0
    dp_max = np.full(N + 1, -INF, np.int64)
    dp_max[a] = dp_max[b] = 0
    add = 0
    update = np.empty((100 * N, 3), np.int64)
    for n in range(N):
        a, b, c = A[3 * n + 2:3 * n + 5]
        if a == b == c:
            add += 1
            continue
        p = 0
        # 色を持ちかえるだけの遷移
        for _ in range(3):
            a, b, c = b, c, a
            update[p], p = (a, b, dp_max.max()), p + 1
            for k in range(N):
                update[p], p = (k, a, dp_max[k]), p + 1

        for _ in range(3):
            a, b, c = b, c, a
            # 色 a をそろえる遷移
            if a == b:
                for k in range(N):
                    # もともと a, k をもっている
                    update[p], p = (c, k, dp[a, k] + 1), p + 1
            # もともと a, a, をもっている
            update[p], p = (b, c, dp[a, a] + 1), p + 1
        for i in range(p):
            a, b, x = update[i]
            dp[a, b] = dp[b, a] = max(dp[a, b], x)
            dp_max[a] = max(dp_max[a], x)
            dp_max[b] = max(dp_max[b], x)
    return dp_max.max() + add

A = np.array(read().split(), np.int64)[1:]

print(main(A))