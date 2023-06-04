require "crystal/modint9"
require "crystal/prime"

n = gets.to_s.to_i64
s = gets.to_s
quit 1 if s.chars.all? { |c| c == '.' }

if Prime.is_prime?(n)
  puts s.chars.all? { |c| c == '#' } ? 2 : 1
  exit
end

dp = Hash(Int64, Array(ModInt)).new do |h, k|
  h[k] = Array.new(k + 1, 0.to_m)
  h[k][0] = 1.to_m
  h[k]
end

ft = Prime.prime_division(n)
cnt = Set(Tuple(Int64, Int64)).new

ft.keys.each do |m|
  i = n // m
  i.times do |j|
    wk = 1_i64.step(by: i, to: n).all? do |k|
      s[(k + j).pred] == '#'
    end
    cnt << {i, j} if wk
  end
end

ft.keys.each do |m|
  i = n // m
  i.times do |j|
    if cnt.includes?({i, j})
      dp[i][j + 1] = dp[i][j] * 2
    else
      dp[i][j + 1] = dp[i][j]
    end
  end
end

if ft.keys.size == 1
  ans = dp.values.map { |v| v[-1] }.sum
  pp ans
else
  if s.chars.all? { |c| c == '#' }
    ans = (dp.values.map { |v| v[-1] }.sum - 2).to_m
    pp ans
  else
    ans = (dp.values.map { |v| v[-1] }.sum - 1).to_m
    pp ans
  end
end
