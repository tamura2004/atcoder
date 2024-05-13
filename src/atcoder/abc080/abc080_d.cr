# 1--7--8--12
# |--| 2
#    |--x 1
#       x--| 1
#
# 0  1  1  1
# 1  1  0  0

n, m = gets.to_s.split.map(&.to_i64)
wk = Array.new(m) { [] of Tuple(Int64,Int64) }
n.times do
  s, t, i = gets.to_s.split.map(&.to_i64.pred)
  wk[i] << {s, t}
end

m.times do |i|
  wk[i].sort!
end

cnt = Array.new(m) { [] of Tuple(Int64,Int64) }
m.times do |i|
  wk[i].each do |(s, t)|
    if cnt[i].size > 0 && cnt[i][-1][1] == s
      ps, pt = cnt[i].pop
      cnt[i] << { ps, t }
    else
      cnt[i] << { s, t }
    end
  end
end

imos = Array.new(100_001, 0_i64)
cnt.flatten.each do |s, t|
  imos[s] += 1
  imos[t+1] -= 1
end

(1..100000).each do |i|
  imos[i] += imos[i-1]
end

pp imos.max
