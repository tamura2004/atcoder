n, q = gets.to_s.split.map(&.to_i)
c = gets.to_s.split.map{|e| Set{e} }

q.times do
  a, b = gets.to_s.split.map(&.to_i.pred)
  c.swap(a, b) unless c[a].size <= c[b].size
  c[b].concat c[a]
  c[a].clear
  puts c[b].size
end
