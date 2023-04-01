require "crystal/math"

n, m = gets.to_s.split.map(&.to_i64)
ans = Int64::MAX
mm = Math.min(n, Math.isqrt(m).succ)
# pp! mm
(1_i64..mm).each do |a|
  b = divceil(m, a)
  if 1 <= b <= n
    chmin ans, a * b
  end
end

pp ans == Int64::MAX ? -1 : ans