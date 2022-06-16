require "crystal/xor_base"

n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)
all = a.reduce { |acc, b| acc ^ b }
b = a.map(&.& ~all)

xb = XorBase.new(b).sweep!
ans = 0_i64

xb.each do |x|
  chmax ans, ans ^ x
end

other = all ^ ans
pp ans + other
