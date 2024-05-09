s = gets.to_s.chars
t = gets.to_s.chars

i = 0
ans = [] of Int32

s.each do |c|
  j = t.index(c, i).not_nil!

  ans << j
  i = j + 1
end

puts ans.map(&.succ).join(" ")

