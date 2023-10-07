n = gets.to_s.to_i64
s = gets.to_s

cnt_a = 0_i64
cnt_b = 0_i64

if s[0] == 'A'
  cnt_a += 1
else
  cnt_b += 1
end

n.times do |i|
  if s[i + 1] == 'A'
    cnt_a += 1
  else
    cnt_b += 1
  end

  if cnt_a >= cnt_b
    puts "Alice"
  else
    puts "Bob"
  end
end
