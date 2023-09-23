# 各i=1..nについて
# 初項：i
# 公差：i
# 長さ：len = n // i
# の等差数列の和
# sum = len * (len + 1) // 2 * i

require "crystal/iota"

n = gets.to_s.to_i128
ans = n.iota.sum do |i|
  len = n // i
  len * (len + 1) // 2 * i
end

pp ans
