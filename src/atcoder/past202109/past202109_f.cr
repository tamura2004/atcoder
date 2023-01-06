n = gets.to_s.to_i64
s = gets.to_s
quit -1 if s.count('0') == 1

ans = (1..n).to_a
zeros = [] of Int32
(0...n).each do |i|
  zeros << i if s[i] == '0'
end

zeros.each_with_index do |v,i|
  ans[v] = zeros[i-1].succ
end

puts ans.join(" ")