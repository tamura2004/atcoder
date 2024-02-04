require "crystal/indexable"

n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)
cs = a.cs
ans = cs.last - cs.min
pp ans