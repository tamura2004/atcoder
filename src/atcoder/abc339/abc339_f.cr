require "big"

n = gets.to_s.to_i64
a = Array.new(n) do
  gets.to_s.to_big_i
end

ans = 10.times.min_of do
  Problem.new(n, a, rand(1000000000..2000000000).to_big_i).solve
end

pp ans

class Problem
  getter n : Int64
  getter a : Array(BigInt)
  getter b : Array(BigInt)
  getter c : Hash(BigInt, Int64)
  getter mod : BigInt

  def initialize(@n, @a, @mod)
    @b = a.map(&.% mod)
    @c = @b.tally.transform_values(&.to_i64)
  end

  def solve
    n.times.sum do |i|
      n.times.sum do |j|
        c[(b[i] * b[j]) % mod]? || 0_i64
      end
    end
  end
end


