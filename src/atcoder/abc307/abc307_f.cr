require "crystal/graph"
require "crystal/priority_queue"

n, m = gets.to_s.split.map(&.to_i)
g = n.to_g

m.times do
  v, nv, cost = gets.to_s.split.map(&.to_i64)
  g.add v, nv, cost
end

k = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i.pred)

d = gets.to_s.to_i64
x = gets.to_s.split.map(&.to_i64)

ans = Array.new(n, Int32::MAX)
cnt = 0
q = PQ(Tuple(Int32, Int64, Int32)).lesser # 何日目、使った距離、次の点

a.each do |v|
  ans[v] = 0_i64
  q << {0, 0_i64, v}
  q << {1, 0_i64, v}
end

while q.size > 0
  i, cost, v = q.pop
  cnt += 1 if ans[v] == Int32::MAX
  chmin ans[v], i + 1
  break if cnt == n

  g.each_with_cost(v) do |nv, ncost|
    next if x[i] < cost + ncost
    next if ans[nv] != Int32::MAX
    q << {i, cost + ncost, nv}
    q << {i + 1, 0_i64, nv} if i + 1 < d
  end
end

puts ans.map { |v| v == Int32::MAX ? -1 : v }.join("\n")

# pp g