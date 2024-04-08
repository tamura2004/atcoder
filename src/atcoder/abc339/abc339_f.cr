require "big"

class Problem
  getter n : Int64
  getter a : Array(BigInt)
  getter cnt : Hash(BigInt, Int32)
  getter mod : Int64

  def initialize(@n, a, @mod)
    @a = a.map(&.to_big_i.% mod)
    @cnt = @a.tally
  end

  def solve
    n.times.sum do |i|
      n.times.sum do |j|
        (cnt[(a[i] * a[j]) % mod]? || 0).to_i64
      end
    end
  end
end

n = gets.to_s.to_i64
a = Array.new(n) do
  gets.to_s.to_big_i
end

ans = 10.times.min_of do
  mod = rand(1e9.to_i64..2e9.to_i64)
  Problem.new(n, a, mod).solve
end

pp ans
