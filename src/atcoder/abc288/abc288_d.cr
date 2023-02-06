require "crystal/segment_tree"
require "crystal/indexable"

n, k = gets.to_s.split.map(&.to_i)
a = gets.to_s.split.map(&.to_i64)
st = Array.new(k) { n.to_st_sum }

n.times do |i|
  k.times do |j|
    if i % k == j
      st[j][i] = a[i]
    end
  end
end

q = gets.to_s.to_i
q.times do
  l, r = gets.to_s.split.map(&.to_i.pred)
  ck = (0...k).map do |j|
    st[j][l..r]
  end
  ans = (k-1).times.all? do |i|
    ck[i] == ck[i+1]
  end
  puts ans ? :Yes : :No
end
