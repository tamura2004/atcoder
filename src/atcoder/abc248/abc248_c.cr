require "crystal/modint9"
require "crystal/fact_table"

n, m, k = gets.to_s.split.map(&.to_i)
memo = Hash(Tuple(Int32, Int32), ModInt).new

f = uninitialized Proc(Int32, Int32, ModInt)
f = ->(n : Int32, k : Int32) do
  return memo[{n, k}] if memo.has_key?({n, k})
  if n == 1
    return 0.to_m if k < 0
    return Math.min(m, k).to_m
  else
    (1..Math.min(m, k)).sum do |i|
      f.call(n - 1, k - i).to_m
    end.tap { |ans| memo[{n, k}] = ans }
  end
end

ans = f.call(n, k)
pp ans
