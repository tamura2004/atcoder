module BalancedTree
  module Treap
    class Xorshift
      getter x : Int64

      def initialize
        @x = 88172645463325252_i64
      end
  
      def get
        @x = x ^ (x << 7)
        @x = x ^ (x >> 9)
      end  
    end
  end
end
