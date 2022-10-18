n = gets.to_s.to_i
s = gets.to_s.chars.map(&.to_i)
t = gets.to_s.chars.map(&.to_i)

s_bit = s.count(1)
t_bit = t.count(1)
s, t = t, s unless s_bit <= t_bit

a = s.zip(t).map{|i,j|i^j}
num = a.count(1)
quit -1 if num.odd?


ans = Array.new(n, 0)
cnt = (s.count(1) - t.count(1)).abs // 2
(0...n).reverse_each do |i|
  next if a[i].zero?

  if cnt > 0 && s[i].zero?
    cnt -= 1
    ans[i] = 1
  end
end

puts ans.join
