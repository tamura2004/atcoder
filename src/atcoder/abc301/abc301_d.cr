s = gets.to_s
n = gets.to_s.to_i64

# ?を0に変えたもの
t = 0_i64
s.chars.reverse.each_with_index do |c, i|
  t |= (1_i64 << i) if c == '1'
end
quit -1 if n < t

s.chars.each_with_index do |c, i|
  next if c != '?'
  j = s.size - 1 - i
  wk = t | (1_i64 << j)
  t = wk if wk <= n
end

pp t
