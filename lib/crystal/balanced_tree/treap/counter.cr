require "crystal/balanced_tree/treap/mergeable"
require "crystal/balanced_tree/treap/key_splitable"
require "crystal/balanced_tree/treap/index_splitable"

module BalancedTree
  module Treap
    class Counter(K, V)
      include Mergeable
      include KeySplitable(K)
      include IndexSplitable

      getter key : K
      getter pri : Int64
      getter size : Int32
      property val : V
      property left : Counter(K, V)?
      property right : Counter(K, V)?

      def initialize(@key, @val)
        @pri = Xorshift.get
        @size = 1
      end

      # キーが`k`のノードを含むなら真
      def includes?(k : K) : Bool
        if key == k
          true
        elsif key < k
          right.try &.includes?(k) || false
        else
          left.try &.includes?(k) || false
        end
      end

      # キーが`k`のノードの値を返す。ノードが無ければ0_i64
      def fetch(k : K)
        if key == k
          val
        elsif key < k
          right.try &.fetch(k) || 0_i64
        else
          left.try &.fetch(k) || 0_i64
        end
      end

      # `fetch`の別名
      def [](k : K)
        fetch(k)
      end

      def left_size
        left.try &.size || 0
      end

      def right_size
        right.try &.size || 0
      end

      def left_to_a
        left.try &.to_a || [] of T
      end

      def right_to_a
        right.try &.to_a || [] of T
      end

      def update
        @size = left_size + right_size + 1
        self
      end

      def inspect
        "(#{left.inspect} #{key} => #{val} #{right.inspect})".gsub(/nil/, "")
      end

      def to_a
        left_to_a + [key] + right_to_a
      end

      def each(&block : K -> Nil)
        left.try &.each(&block)
        block.call(key)
        right.try &.each(&block)
      end
    end
  end
end
