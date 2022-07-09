require "crystal/modint9"
require "crystal/fact_table"

n = gets.to_s.to_i64
a = Array.new(n) do
  gets.to_s.split.map(&.to_i64)
end

# dp = make_array(0.to_m, n, n)
# dp[0][0] = 1.to_m

cnt = Hash(Int64, Array(Tuple(Int64, Int64))).new do |h,k|
  h[k] = [] of Tuple(Int64, Int64)
end

n.times do |y|
  n.times do |x|
    # dp[y][x] += dp[y - 1][x] if y > 0
    # dp[y][x] += dp[y][x - 1] if x > 0
    cnt[a[y][x]] << {y, x}
  end
end

# pp cnt

ans = 0.to_m
n.times do |y|
  n.times do |x|
    if h = cnt[a[y][x]]
      h.each do |ny, nx|
        next unless ny <= y && nx <= x
        ans += (y - ny + x - nx).c(x - nx)
      end
    end
  end
end

pp ans
