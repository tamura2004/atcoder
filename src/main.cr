require "crystal/tree"

n = gets.to_s.to_i
g = Tree.new(n) do |g|
  (n - 1).times do
    a, b = gets.to_s.split.map(&.to_i)
    g.add a, b
  end
end

sb = g.subtree
ch = g.children

v = 0
while true
  nv = ch[v].sort_by { |nv| sb[nv] }.pop
  break if sb[nv] <= n // 2
  v = nv
end

pp v
g.debug
