require "crystal/balanced_tree/treap/node"

module BalancedTree
  module Treap
    class Counter(T) < Node(T)
      property val : Int64

      def initialize(key,val)
        super(key)
        @val = val.to_i64
      end
    end
  end
end
