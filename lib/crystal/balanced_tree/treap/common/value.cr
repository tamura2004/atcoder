require "crystal/balanced_tree/common/xorshift"
require "crystal/balanced_tree/treap/common/index_splitable"
require "crystal/balanced_tree/treap/common/mergeable"

module BalancedTree
  module Treap
    class Value(V)
      include Mergeable
      include IndexSplitable

      getter pri : Int64
      getter size : Int32
      property val : V
      property left : Value(V)?
      property right : Value(V)?

      # 値`val`で初期化
      def initialize(@val)
        @pri = Xorshift.get
        @size = 1
      end

      # `i`番目の値を返す
      def fetch(i : Int)
        ord = left_size
        if ord == i
          val
        elsif ord < i
          right.try &.fetch(i - ord - 1)
        else
          left.try &.fetch(i)
        end
      end

      # `i`番目の値を`v`に更新
      def put(i : Int, v : V)
        ord = left_size
        if ord == i
          @val = v
        elsif ord < i
          right.try &.put(i - ord - 1, v)
        else
          left.try &.put(i, v)
        end
      end

      # 左部分木のサイズ = 自身のindex
      def left_size
        left.try &.size || 0
      end

      def right_size
        right.try &.size || 0
      end

      def left_to_a
        left.try &.to_a || [] of V
      end

      def right_to_a
        right.try &.to_a || [] of V
      end

      def update
        @size = left_size + right_size + 1
        self
      end

      def inspect
        "(#{left.inspect} #{val} #{right.inspect})".gsub(/nil/, "")
      end

      def to_a
        left_to_a + [val] + right_to_a
      end

      def each(&block : V -> Nil)
        left.try &.each(&block)
        block.call(val)
        right.try &.each(&block)
      end
    end
  end
end
