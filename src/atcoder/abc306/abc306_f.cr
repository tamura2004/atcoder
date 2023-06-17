# 数え上げの問題
# 主客転倒
require "crystal/cc"
require "crystal/segment_tree"

n, m = gets.to_s.split.map(&.to_i64)
a = Array.new(n) { gets.to_s.split.map(&.to_i64).sort }

keys = a.flatten
cc = CC.new(keys)
st = cc.size.to_st_sum

ans = (1_i64..m).sum * n * (n - 1) // 2

n.times do |i|
  m.times do |j|
    lo = cc[a[i][j]]
    if j < m - 1
      hi = cc[a[i][j+1]]
      ans += st[lo..hi] * (j + 1)
    else
      ans += st[lo..] * (j + 1)
    end
  end

  m.times do |j|
    v = cc[a[i][j]]
    st[v] += 1
  end
end

pp ans
