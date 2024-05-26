require "crystal/string/suffix_array"

s = gets.to_s
sa, rank, lcp = SuffixArray.new(s).solve
puts sa[1..].join(" ")