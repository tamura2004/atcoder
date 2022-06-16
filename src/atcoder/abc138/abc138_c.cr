require "crystal/priority_queue"

n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_f64)
pq = PQ(Float64).lesser
a.each{|v| pq << v}

while pq.size > 1
  s = pq.pop
  t = pq.pop
  pq << (s + t) / 2
end

pp pq.pop
