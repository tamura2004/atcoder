require "crystal/indexable"

s = gets.to_s
sa, rank = s.chars.map(&.ord.to_i64).suffix_array

puts sa[1..].join(" ")