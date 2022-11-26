require "crystal/graph"

n, m = gets.to_s.split.map(&.to_i64)
g = Graph.new(n)

m.times do
  v, nv = gets.to_s.split.map(&.to_i)
  g.add v, nv
end

ans = Array.new(n) do |v|
  g.edges(v).map(&.first.succ).sort
end

ans.each do |a|
  puts "#{a.size} #{a.join(' ')}"
end



