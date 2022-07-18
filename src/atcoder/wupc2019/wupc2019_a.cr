s = gets.to_s.chars.reverse
ans = [] of Char

s.each do |c|
  if !ans.empty? && (ans[-1] == 'A' && c == 'W')
    ans.pop
    ans << 'C'
    ans << 'A'
  else
    ans << c
  end
end

puts ans.reverse.join
