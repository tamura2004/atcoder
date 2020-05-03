n,m = gets.split.map &:to_i
a = Array.new(n){ gets.split.map &:to_i }.transpose.map(&:join).map{|v|v.to_i(2)}

ans = 0
0.upto(2**n-1) do |bit|
  b = a.map{|v| (v ^ bit).to_s(2).count("1") }.map{|v| v > n-v ? v : n-v }.inject(:+)
  ans = b if ans < b
end
puts ans