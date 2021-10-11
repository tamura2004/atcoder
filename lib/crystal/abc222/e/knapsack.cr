require "crystal/modint9"
module Abc222
  module E
    class Knapsack
      getter n : Int32
      getter a : Array(Int32)
      getter dp : Hash(Int32,ModInt)

      def initialize(@a)
        @n = a.size
        @dp = Hash(Int32,ModInt).new(0.to_m)
        dp[0] = 1.to_m
      end

      def solve
        n.times do |i|
          dp.keys.sort.reverse.each do |key|
            dp[key + a[i]] += dp[key]
          end
        end
        dp
      end
    end
  end
end
