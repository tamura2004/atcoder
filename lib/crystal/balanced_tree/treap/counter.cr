require "crystal/balanced_tree/treap/node"

module BalancedTree
  module Treap
    class Counter(T) < Node(T)
      class_getter r = Xorshift.new
      getter cnt : Int64

      def initialize(key,cnt)
        super(key)
        @cnt = cnt.to_i64
      end
    end
  end
end
