require "crystal/modint9"
require "crystal/prime"

n = gets.to_s.to_i64
s = gets.to_s.chars.map(&.==('#').to_unsafe)

ft = n.prime_factors

solve = -> (e : Int64) do
  m = n // e
  cnt = Array.new(m, 1)
  n.times do |i|
    cnt[i % m] &= s[i]
  end
  2.to_m ** cnt.sum
end

ans = 0.to_m
(1<<(ft.size)).times do |mask|
  next if mask.zero?

  acc = 1_i64
  ft.each_with_index do |v, i|
    next if mask.bit(i).zero?
    acc = acc.lcm(v)
  end

  if mask.popcount.odd?
    ans += solve.call(acc)
  else
    ans -= solve.call(acc)
  end
end

pp ans
