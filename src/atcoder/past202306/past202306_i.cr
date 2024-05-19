# 約数列挙してカウント
# カウント数がkを超える約数の最大が答え

require "crystal/prime"

n, k = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)
cnt = Hash(Int64, Int64).new(0)

a.each do |v|
  Prime.factors(v).each do |m|
    cnt[m] += 1
  end
end

ans = 1
cnt.each do |key, val|
  if k <= val
    chmax ans, key
  end
end

pp ans