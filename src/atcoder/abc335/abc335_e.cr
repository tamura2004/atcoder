require "crystal/priority_queue"
require "crystal/graph"

INF = Int64::MAX//4

n, m = gets.to_s.split.map(&.to_i64)
g = n.to_g
a = gets.to_s.split.map(&.to_i64)
m.times do
  g.read
end

q = [{a[0], -1_i64, 0}].to_pq_lesser
seen = Array.new(n, false)
depth = Array.new(n, 0_i64)

while q.size > 0
  tail, score, v = q.pop
  next if seen[v]
  seen[v] = true
  depth[v] = -score

  g.each(v) do |nv|
    next if seen[nv]
    next if a[nv] < a[v]
    if a[nv] == a[v]
      q << {a[nv], score, nv}
    else
      q << {a[nv], score - 1, nv}
    end
  end
end

puts depth[-1]
