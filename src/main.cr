require "crystal/digit_dp"

a, k = gets.to_s.split
a = DigitDP.new(a)
k = k.to_i64
n = a.n

dp = Array.new(n+1) do
  Array.new(2) do
    Array.new(2) do |z|
      if z == ZERO
        { 1_i64 => 1_i64 }
      else
        Hash(Int64,Int64).new(0_i64)
      end
    end
  end
end

a.each_with_zero do |i, from, to, d, z|
  dp[i][from][z].keys.each do |j|
    jj = j * d
    zz = PLUS

    next if jj > k
    next if z == ZERO && d == 0

    dp[i+1][to][zz][jj] += dp[i][from][z][j]
  end
end

pp dp