require "big"
require "crystal/prime"

n = gets.to_s.to_i64
a = Array.new(n){ (gets.to_s.to_big_d * 10 ** 9).to_i64 }

dp = Hash(Tuple(Int32,Int32),Int64).new(0_i64)
a.each do |v|
  h = v.prime_division
  i = h[2_i64]
  j = h[5_i64]
  dp[{i,j}] += 1
end

ans = 0_i64
dp.each do |(i,j),k|
  dp.each do |(ii,jj),kk|
    next if i + ii < 18
    next if j + jj < 18
    if i == ii && j == jj 
      ans += k * (k - 1)
    else
      ans += k * kk
    end
  end
end

pp ans // 2

