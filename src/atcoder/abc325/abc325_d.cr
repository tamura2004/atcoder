require "crystal/priority_queue"

n = gets.to_s.to_i64
a = Array.new(n) do
  t, d = gets.to_s.split.map(&.to_i64)
  {t, t+d}
end.group_by(&.[0])
a[Int64::MAX] = [] of Tuple(Int64,Int64)

ans = 0_i64
cur = 1_i64

pq = PQ(Int64).lesser

a.each do |key, arr|
  # 捨てる
  while pq.size > 0 && cur < key
    hi = pq.pop
    if cur <= hi
      cur += 1
      ans += 1
    end
  end
  arr.each { |lo, hi| pq << hi }
end

pp ans