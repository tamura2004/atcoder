require "crystal/modint9"
require "crystal/indexable"
require "crystal/number_theory/partition_number"
include NumberTheory

module Abc226
  module F
    class Problem
      getter n : Int64
      getter k : Int64

      def initialize(n, k)
        @n = n.to_i64
        @k = k.to_i64
      end

      def calc(a)
        return 1_i64 if a.empty?

        x1 = a.reduce { |s, t| s.lcm(t) }
        x1.to_m ** k * count(a)
      end

      def count(a)
        ac = a.tally

        x2 = a.map(&.pred.f).product
        x3 = a.map(&.f).product
        x4 = (n - a.sum).f
        x5 = ac.values.map(&.f).product
        n.f * x2 // (x3 * x4 * x5)
      end

      def solve
        ans = 0.to_m
        PartitionNumber.each(n) do |a|
          ans += calc(a)
        end
        ans
      end
    end
  end
end
