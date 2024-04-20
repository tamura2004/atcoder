# a + b < c.popcount なら存在しない
# a + b - 2n == c.popcountの場合
# a + b - c.popcount == 2n
# nは重複度
# a - n -> aが単独で1
# b - n -> bが単独で1
# n -> ab両方が1

a, b, c = gets.to_s.split.map(&.to_i64)
nn = a + b - c.popcount
quit -1 if nn < 0 || nn.odd?
n = nn // 2
quit -1 if a < n || b < n

cnt_a = a - n
cnt_b = b - n

ans_a = 0_i64
ans_b = 0_i64

60.times do |i|
  if c.bit(i) == 1
    if cnt_a > 0
      cnt_a -= 1
      ans_a |= 1_i64 << i
    elsif cnt_b > 0
      cnt_b -= 1
      ans_b |= 1_i64 << i
    end
  else
    if n > 0
      ans_a |= 1_i64 << i
      ans_b |= 1_i64 << i
      n -= 1
    end
  end
end

quit -1 if cnt_a > 0 || cnt_b > 0 || n > 0

puts "#{ans_a} #{ans_b}"

