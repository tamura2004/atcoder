require "crystal/priority_queue"
n, c, d = gets.to_s.split.map(&.to_i64)

event = [] of Tuple(Int64,Int64)
n.times do
  x, y = gets.to_s.split.map(&.to_i64)
  event << {d - x, y}
end
event.reverse!

event << {d - 1, 0_i64}
pq = PriorityQueue(Int64).greater
ans = 0_i64

event.each do |x, y|
  while c < x
    quit -1 if pq.empty?
    c += pq.pop
    ans += 1
  end
  pq << y
end
pp ans