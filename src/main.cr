require "crystal/matrix"
require "crystal/modint9"

# 状態
# 一致 0
# 縦が一致 1
# 横が一致 2
# 不一致 3

# 0 -> 1, 2
# 1 -> 0, 1, 3
# 2 -> 0, 2, 3
# 3 -> 1, 2

# | 0   1   1   0       |
# | h-1 h-2 0   1       |
# | w-1 0   w-2 1       |
# | 0   w-1 h-1 (h+w-4) |

def state(sy, sx, gy, gx)
  return 0 if sy == gy && sx == gx
  return 1 if sx == gx
  return 2 if sy == gy
  3
end

h, w, k = gets.to_s.split.map(&.to_i64)
sy, sx, gy, gx = gets.to_s.split.map(&.to_i)

m = Matrix(ModInt).new([
  [0, 1, 1, 0],
  [h - 1, h - 2, 0, 1],
  [w - 1, 0, w - 2, 1],
  [0, w - 1, h - 1, h + w - 4],
])
ans = m ** k

i = state(sy, sx, gy, gx)
pp ans[0][i]
