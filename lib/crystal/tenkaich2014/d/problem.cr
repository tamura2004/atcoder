module Tenkaich2014
  module D
    struct Problem
      MOD = 10_i64 ** 9 + 7

      getter n : Int32
      getter fact : Array(Int64)
      getter fact_inv : Array(Int64)

      def initialize(@n)
        @fact = [] of Int64
        @fact_inv = [] of Int64
      end

      def mpow(a, n)
        p = 1_i64
        while n > 0
          p = (p * a) % MOD if n.odd?
          a = (a ** 2) % MOD
          n >>= 1
        end
        p
      end

      def fact_table
        fact << 1_i64
        1.upto(n-1) do |i|
          fact << (fact.last * i) % MOD
        end

        fact_inv << mpow(fact[n-1], MOD - 2)
        1.upto(n-1) do |i|
          j = n - i
          fact_inv << (fact_inv.last * j) % MOD
        end

        fact_inv.reverse!
      end

      # s[n][k] = Σ 0<=i<k c[N,i]を前計算する
      def precompute
      end

      def solve
        fact_table
        pp (fact[9] * fact_inv[7]) % MOD
        pp self
      end
    end
  end
end
