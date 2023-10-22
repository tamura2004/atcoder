# 左から順に０を探し、あったら残りは全て１
x = gets.to_s.chars
n = x.size

flag = false
n.times do |i|
  if x[i] == '0'
    flag = true
  end

  if flag
    x[i] = '1'
  end
end

puts x.join

