n, m = gets.to_s.split.map(&.to_i)
s = gets.to_s
ans = Array.new(n, 0_i64)
field = 0_i64

m.times do |i|
  j = i % n
  ans[j] += 1
  case s[i]
  when '0'
  when '-'
    field += ans[j]
    ans[j] = 0
  when '+'
    ans[j] += field
    field = 0
  end
end

puts ans.join("\n")