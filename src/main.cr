require "crystal/graph/scc"

n = gets.to_s.to_i
g = Graph.new(n*6)

n.times do |x|
  s = gets.to_s
  n.times do |y|
    if s[y] == '1'
      g.add x, y + n
    else
      g.add x, y + n * 4
    end
  end
end

n.times do |x|
  s = gets.to_s
  n.times do |z|
    if s[z] == '1'
      g.add x, z + n * 2
    else
      g.add x, z + n * 5
    end
  end
end

ans = true
SCC.new(g).solve[1].each do |s|
  pp s
  if 1 < s.to_a.map { |v| v % (n*3) }.tally.values.max
    puts -1
    exit
  end
end
