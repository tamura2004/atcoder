def solve
  s = gets.chomp
  n = s.size
  return s.to_i % 8 == 0 if n <= 3

  t = s.chars.map(&.to_i)
  cnt = Array.new(10, 0)
  n.times do |i|
    cnt[t[i]] += 1
  end

  14.upto(124).any? do |i|
    j = (i*8).to_s.chars
    next if j.includes?(0)
    

