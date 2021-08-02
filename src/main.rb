require "./lib/ruby/priority_queue"

pq = PriorityQueue.greater
10.times do
  pq << rand(1000)
end

while pq.size > 0
  pp pq.pop
end
