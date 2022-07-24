require "crystal/string/z_algorithm"

n = gets.to_s.to_i64
s = gets.to_s

ans = n.times.max_of do |i|
  cnt = ZAlgorithm.new(s[i..]).solve
  cnt.zip(0..).map{|a,b|Math.min a,b}.max
end

pp ans