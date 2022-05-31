require "crystal/balanced_tree/treap/node"

module BalancedTree
  module Treap
    class Entry(T) < Node(T)
      class_getter r = Xorshift.new

      getter cnt : Int64

      def initialize(@key)
        super
        @cnt = 1_i64
      end
    end
  end
end
