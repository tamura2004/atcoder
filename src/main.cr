require "crystal/digit_dp"

macro chmax(target, other)
  {{target}} = ({{other}}) if ({{target}}) < ({{other}})
end

MAX = 40
n, k = gets.to_s.split.map(&.to_i64)

# ２進数桁毎の1の数
tmp = gets.to_s.split.map(&.to_i64)
cnt = (0...MAX).map do |i|
  tmp.sum { |v| v.bit(i) }
end
cnt.reverse!

a = sprintf("%0#{MAX}b", k).chars.map(&.to_i)

dd = DigitDP.new(a, 2)
dp = make_array(0_i64, dd.n + 1, 2)

dd.each do |i,k,d,kk,lz,ai|
  diff = d == 0 ? cnt[i] : n - cnt[i]
  chmax dp[i+1][kk], dp[i][k] * 2 + diff
end

pp dp[-1].max