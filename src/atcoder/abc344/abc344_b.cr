ans = [] of Int32
flag = true
while flag
  a = gets.to_s.to_i
  if a.zero?
    flag = false
  end
  ans << a
end

puts ans.reverse.join("\n")