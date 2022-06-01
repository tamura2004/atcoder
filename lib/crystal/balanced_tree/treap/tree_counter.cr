require "crystal/balanced_tree/treap/counter"
require "crystal/balanced_tree/treap/multiset"

module BalancedTree
  module Treap
    class TreeCounter(N) < Tree(N)
      getter root : N?

      def includes?(k)
        root.try(&.includes?(k)) || false
      end

      def [](k) : Int64
        return 0_i64 unless includes?(k)
        tail = self | k
        return 0_i64 #unless includes?(k)
        # (tail.root.try(&.val) || 0_i64).tap { self + tail }
      end
    end
  end
end
