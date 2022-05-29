n = gets.to_s.to_i
s = gets.to_s.chars

nums = [] of Int64
chars = [] of Char

s.each do |c|
  if chars.empty? || chars[-1] != c
    chars << c
    nums << 1_i64
  else
    nums[-1] += 1
  end
end

cnt = [] of Int64

chars.zip(nums).each_cons(3) do |seq|
  if seq.map(&.first) == ['A','R','C'] && seq[1][1] == 1
    cnt << Math.min seq[0][1], seq[2][1]
  end
end

pp Math.min cnt.size * 2, cnt.sum

