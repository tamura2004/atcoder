# ２進数で桁DPをする
require "crystal/modint9"
require "crystal/digit_dp"
n, m = gets.to_s.split.map(&.to_i64)

a = n.to_s(2).chars.map(&.to_i)
b = ([0] * a.size + m.to_s(2).chars.map(&.to_i)).last(a.size)

dd = DigitDP.new(a, 2)
cnt = make_array(0.to_m, dd.n + 1, 2)
sum = make_array(0.to_m, dd.n + 1, 2)
cnt[0][0] = 1.to_m

dd.each do |i,k,d,kk|
  cnt[i+1][kk] += cnt[i][k]
  sum[i+1][kk] += sum[i][k] + cnt[i][k] * d * b[i]
end

pp sum[-1].sum