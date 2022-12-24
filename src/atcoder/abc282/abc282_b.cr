n = gets.to_s.to_i
s = gets.to_s.chars

sw = true

ans = [] of Char
n.times do |i|
  case s[i]
  when '"'
    sw = !sw
    ans << '"'
  when ','
    if sw
      ans << '.'
    else
      ans << ','
    end
  else
    ans << s[i]
  end
end

puts ans.join