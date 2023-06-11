require "crystal/string/z_algorithm"

h, w = gets.to_s.split.map(&.to_i64)
s = Array.new(h) { gets.to_s.chars }.transpose.map(&.hash)
t = Array.new(h) { gets.to_s.chars }.transpose.map(&.hash)

za = (s + [0_u64] + t + t).z_algorithm

ans = za.count(w) > 0
puts ans ? :Yes : :No