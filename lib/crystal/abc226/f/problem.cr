require "crystal/modint9"
require "crystal/indexable"

module Abc226
  module F
    alias Fn = Proc(Array(Int64),Nil)
    class Problem
      getter n : Int64
      getter k : Int64

      def initialize(n, k)
        @n = n.to_i64
        @k = k.to_i64
      end

      def pf(n, k, a, &block : Fn)
        case
        when n == 0 then yield a
        when n == 1 then yield a
        when k == 1 then yield a
        else
          if k <= n
            a << k
            pf(n - k, k, a, &block)
            a.pop
          end

          pf(n, k - 1, a, &block)
        end
      end

      def each_div(&block : Fn)
        pf(n, n, [] of Int64, &block)
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
        each_div do |a|
          ans += calc(a)
        end
        ans
      end
    end
  end
end
