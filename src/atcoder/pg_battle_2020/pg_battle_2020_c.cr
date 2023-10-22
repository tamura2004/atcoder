require "crystal/indexable"
require "crystal/st"

n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64.pred)

st = (n*2).to_st_sum

ord = Array.new(n, nil.as(Int32?))
a.each_with_index do |pair, i|
  if j = ord[pair]
    dist = i - j - 1
    st[dist] += 1
  else
    ord[pair] = i
  end
end

(n*2-1).times do |i|
  puts st[..i]
end
