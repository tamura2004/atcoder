require "crystal/graph"

n, m = gets.to_s.split.map(&.to_i64)
g = n.to_g
m.times do
  g.read
end

ans = n.times.sum do |v|
  g.each(v).count do |nv|
    nv < v
  end == 1 ? 1 : 0
end

pp ans
