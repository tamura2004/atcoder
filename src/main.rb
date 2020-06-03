require "numo/narray"

# 4方向探索用
DX = [ 0, 1, 0,-1, 1,-1, 1,-1]
DY = [ 1, 0,-1, 0, 1,-1,-1, 1]
def inside(y, x, h, w); 0 <= y && y < h && 0 <= x && x < w; end
def each_dir(v,n)
  y = v / n
  x = v % n
  4.times do |i|
    ny = y + DY[i]
    nx = x + DX[i]
    next unless inside(ny,nx,n,n)
    yield ny * n + nx
  end
end

# 入力
n = gets.to_i
a = Numo::Int64.parse(gets).reshape(n,n) - 1

# 退席コスト
dp = Numo::Int64.zeros(n, n)
m = (n + 1) / 2 - 1
m.times do |i|
  r = (1 + i)...(-1 - i)
  dp[r, r] = i + 1
end

# 順次退席
ans = 0
a.each do |i|
  ans += dp[i]

  seen = Numo::Int64.zeros(n, n)
  seen[i] = 1
  que = [i]
  while que.size > 0
    v = que.shift
    each_dir(v, n) do |nv|
      next if seen[nv] != 0
      next unless dp[v] < dp[nv]
      seen[nv] = 1
      que << nv
    end
    dp[v] -= 1 if dp[v] > 0 && i != v
  end
  if i == 8
    p "-"*20
    p i
    p seen
    p dp
  end
end

puts ans