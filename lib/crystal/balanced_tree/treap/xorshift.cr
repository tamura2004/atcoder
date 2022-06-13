# 平衡二分探索木
module BalancedTree
  # `Treap`による実装
  module Treap
    # XOR演算による乱数
    class Xorshift
      @@x : Int64 = 88172645463325252_i64

      def self.get
        @@x = @@x ^ (@@x << 7)
        @@x = @@x ^ (@@x >> 9)
      end
    end
  end
end
