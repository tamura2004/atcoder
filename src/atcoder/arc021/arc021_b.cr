# 辞書順最小
# 先頭がゼロ：一通りしかない

n = gets.to_s.to_i
b = Array.new(n) { gets.to_s.to_i }

quit -1 if b.reduce{|acc,b|acc^b} != 0

a = [0]
(n-1).times do |i|
  a << (a[-1] ^ b[i])
end

puts a.join("\n")