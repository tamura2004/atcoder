require "crystal/balanced_tree/treap/xorshift"
require "crystal/balanced_tree/treap/index_splitable"

module BalancedTree
  module Treap
    class Node(T)
      include IndexSplitable

      getter key : T
      getter pri : Int64
      getter size : Int32
      property left : Node(T)?
      property right : Node(T)?

      getter acc : T

      def initialize(@key)
        @pri = Xorshift.get
        @size = 1
        @acc = @key
      end

      # キーが`k`のノードを含むなら真
      def includes?(k : T) : Bool
        if key == k
          true
        elsif key < k
          right.try &.includes?(k) || false
        else
          left.try &.includes?(k) || false
        end
      end

      # k未満と、k以上で分割
      def split(k : T) : {Node(T)?, Node(T)?}
        if key < k
          @right, snd = right.try &.split(k) || nil_node_pair
          {update, snd}
        else
          fst, @left = left.try &.split(k) || nil_node_pair
          {fst, update}
        end
      end

      # 添え字i未満と、以上で分割（0-origin）
      # def split_at(i : Int) : {Node(T)?, Node(T)?}
      #   ord = left_size
      #   if ord < i
      #     @right, snd = right.try &.split_at(i - ord - 1) || nil_node_pair
      #     {update, snd}
      #   else
      #     fst, @left = left.try &.split_at(i) || nil_node_pair
      #     {fst, update}
      #   end
      # end

      # 木の結合
      def merge(b : self?)
        return self if b.nil?

        if pri > b.pri
          @right = right.try &.merge(b) || b
          update
        else
          b.left = merge(b.left)
          b.update
        end
      end

      def left_size
        left.try &.size || 0
      end

      def right_size
        right.try &.size || 0
      end

      def left_acc
        left.try &.acc || T.zero
      end

      def right_acc
        right.try &.acc || T.zero
      end

      def left_to_a
        left.try &.to_a || [] of T
      end

      def right_to_a
        right.try &.to_a || [] of T
      end

      def nil_node
        nil.as(self?)
      end

      def nil_node_pair
        {nil_node, nil_node}
      end

      def update
        @size = left_size + right_size + 1
        @acc = left_acc + right_acc + key
        self
      end

      def inspect
        "(#{left.inspect} #{key} #{right.inspect})".gsub(/nil/, "")
      end

      def to_a
        left_to_a + [key] + right_to_a
      end

      def each(&block : T -> Nil)
        left.try &.each(&block)
        block.call(key)
        right.try &.each(&block)
      end
    end
  end
end
