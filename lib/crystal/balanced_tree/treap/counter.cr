require "crystal/balanced_tree/treap/node"

module BalancedTree
  module Treap
    class Counter(K, V)
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

      # k未満と、k以上で分割
      def split(k : K)
        if key < k
          @right, snd = right.try &.split(k) || nil_node_pair
          {update, snd}
        else
          fst, @left = left.try &.split(k) || nil_node_pair
          {fst, update}
        end
      end

      # 添え字i未満と、以上で分割（0-origin）
      def split_at(i : Int)
        ord = left_size
        if ord < i
          @right, snd = right.try &.split_at(i - ord - 1) || nil_node_pair
          {update, snd}
        else
          fst, @left = left.try &.split_at(i) || nil_node_pair
          {fst, update}
        end
      end

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
