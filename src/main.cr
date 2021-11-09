require "crystal/abc226/f/problem"
include Abc226::F

n,k = gets.to_s.split.map(&.to_i64)
ans = Problem.new(n,k).solve
pp ans