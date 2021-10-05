# c_i = a_i - b_i
# c_i += 2
# c_j -= 1
# 1回の操作でΣc_iは1増加

n = gets.to_s.to_i
a = gets.to_s.split.map(&.to_i64)
b = gets.to_s.split.map(&.to_i64)

c = a.zip(b).map { |i, j| i - j }
s = c.sum

if s.zero?
  puts c.all?(&.zero?) ? "Yes" : "No"
elsif s > 0
  puts "No"
else
  d = c.map { |v| v < 0 ? -v : 0_i64 }
  cnt = d.map(&.+(1).//(2)).sum
  if cnt <= s.abs
    puts "Yes"
  else
    puts "No"
  end
end
