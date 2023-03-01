require "crystal/graph"
require "crystal/graph/tsort"

n, m = gets.to_s.split.map(&.to_i64)
g = n.to_g

m.times do
  v, nv = gets.to_s.split.map(&.to_i64)
  g.add v, nv, both: false
end

if path = Tsort.new(g).solve?

  cnt = (n-1).times.all? do |i|
    path[i+1].in?(g.g[path[i]].map(&.[0]))
  end

  if cnt
    puts "Yes"
    ans = Array.new(n, -1)
    path.each_with_index do |v, i|
      ans[v] = i + 1
    end

    puts ans.join(" ")
  else
    puts "No"
  end
else
  puts "No"
end
