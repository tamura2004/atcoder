require "crystal/string/suffix_array"
require "crystal/indexable"

n = gets.to_s.to_i
s = gets.to_s
t = gets.to_s

HEAD = 'a'.ord.pred.chr
TAIL = 'z'.ord.succ.chr

u = s + s + HEAD + t + t + TAIL
sa,rank,lcp = SuffixArray.new(u).solve

si = rank[0,n]
ti = rank[n*2+1,n].sort

ans = 0_i64
si.each do |i|
  ans += ti.count_more_or_equal(i)
end

pp ans
