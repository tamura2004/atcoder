require "crystal/modint9"

MEMO = Hash(Int64,ModInt).new
MEMO[1i64] = 1.to_m

n = gets.to_s.to_i64

solve = uninitialized (Int64) -> ModInt
solve = -> (i : Int64) do
  if MEMO.has_key?(i)
    return MEMO[i]
  end

  ans = 0.to_m
  (2..6).each do |j|
    next unless i % j == 0
    ans += solve.call(i // j) // 5
  end
  MEMO[i] = ans
  ans
end

ans = solve.call(n)
pp ans