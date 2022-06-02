require "crystal/balanced_tree/treap/value"
require "crystal/balanced_tree/treap/list"

module BalancedTree
  module Treap
    class TreeList(V)
      include List

      getter root : Value(V)?

      def initialize
        @root = nil
      end

      def initialize(v : V)
        @root = Value(V).new(v)
      end

      def initialize(@root : Value(V)?)
      end

      def push(v : V)
        self + self.class.new(v)
      end

      def <<(v : V)
        push v
      end

      def fetch(i : Int)
        root.try(&.fetch(i))
      end

      def [](i : Int)
        fetch(i)
      end

      def put(i : Int, v : V)
        t1 = self ^ i
        t2 = t1 ^ 1
        t1.root.try &.val = v
        self + t1 + t2
      end

      def []=(i : Int, v : V)
        put(i, v)
      end
    end
  end
end
