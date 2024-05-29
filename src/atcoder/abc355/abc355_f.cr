require "crystal/union_find"

n, q = gets.to_s.split.map(&.to_i64)
ufs = Array.new(11) { n.to_uf }

(n-1).times do
  v, nv, cost = gets.to_s.split.map(&.to_i64)
  v -= 1
  nv -= 1
  (cost..10).each do |i|
    ufs[i].unite v, nv
  end
end

q.times do
  v, nv, cost = gets.to_s.split.map(&.to_i64)
  v -= 1
  nv -= 1
  (cost..10).each do |i|
    ufs[i].unite v, nv
  end
  puts ufs.sum(&.size.pred)
end
