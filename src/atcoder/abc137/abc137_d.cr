# 後ろから考えて貪欲
# だんだんと選択肢が狭まるのでマトロイドっぽさがある

require "crystal/priority_queue"

jobs = PQ(Tuple(Int64,Int64)).lesser
doit = PQ(Tuple(Int64,Int64)).greater

n, m = gets.to_s.split.map(&.to_i64)
ab = Array.new(n) do
  a, b = gets.to_s.split.map(&.to_i64)
  jobs << ({a,b})
end

ans = 0_i64
(0...m).reverse_each do |i|
  while jobs.size > 0 && jobs[0][0] <= m - i
    job = jobs.pop
    doit << ({job[1],job[0]})
  end

  ans += doit.pop[0] if doit.size > 0
end

pp ans