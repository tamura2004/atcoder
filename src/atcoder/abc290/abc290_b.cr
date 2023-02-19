n,k = gets.to_s.split.map(&.to_i64)
s = gets.to_s

t = [] of Char
cnt = 0
s.chars.each do |c|
  if cnt < k && c == 'o'
    cnt += 1
    t << 'o'
  else
    t << 'x'
  end
end

puts t.join
