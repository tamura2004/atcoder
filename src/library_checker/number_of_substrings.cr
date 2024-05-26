require "crystal/string/suffix_array"

s = gets.to_s
n = s.size.to_i64
sa, rank, lcp = SuffixArray.new(s).solve
ans = n * (n + 1) // 2 - lcp[1..].map(&.to_i64).sum
pp ans