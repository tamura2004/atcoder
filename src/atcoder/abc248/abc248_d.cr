n = gets.to_s.to_i
a = gets.to_s.split.map(&.to_i.pred)

ix = Array.new(n) { [] of Int32 }
n.times { |i| ix[a[i]] << i }

q = gets.to_s.to_i64

q.times do
  l, r, x = gets.to_s.split.map(&.to_i.pred)
  lo = ix[x].bsearch_index(&.>= l) || ix[x].size
  hi = ix[x].bsearch_index(&.> r) || ix[x].size
  pp hi - lo
end
