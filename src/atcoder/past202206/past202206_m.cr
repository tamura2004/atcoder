require "crystal/modint9"

n = gets.to_s.to_i
nn = n * 2 + 1

f = [1.to_m]
(1..nn).each { |i| f << f.last * i }

finv = [f[nn].inv]
(1..nn).each { |i| finv << finv.last * (nn + 1 - i)}
finv.reverse!

inv = [1.to_m]
(1..nn).each { |i| inv << finv[i] * f[i - 1]}

pw2 = [1.to_m]
(1..nn).each { pw2 << pw2.last * 2 }

ans = 0.to_m
(1...n).each do |i|
  ans += f[i*2] * finv[i] * 2 // pw2[i*2 + 1]
end

pp ans
