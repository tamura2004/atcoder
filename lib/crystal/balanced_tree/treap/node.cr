require "crystal/balanced_tree/treap/xorshift"

# 平衡二分探索木
module BalancedTree
  # `Treap`による実装
  module Treap
    # ノード
    class Node(K, V)
      # class_property acc = false

      getter key : K
      property val : V
      getter acc : V?
      getter pri : Int64
      getter size : Int32
      property left : Node(K, V)?
      property right : Node(K, V)?
      getter fxx : Proc(V?, V?, V?)

      def initialize(
        @key,
        @val,
        @fxx : Proc(V?, V?, V?) = ->(x : V?, y : V?) { y }
      )
        @pri = Xorshift.get
        @size = 1
        @acc = @val
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

      # キーが*k*の値を返す
      #
      # 存在しない場合`nil`を返す
      def fetch(k : K) : V?
        if key == k
          val
        elsif key < k
          right.try &.fetch(k)
        else
          left.try &.fetch(k)
        end
      end

      # `i`番目の値を返す
      def at(i : Int) : V?
        ord = left_size
        if ord == i
          val
        elsif ord < i
          right.try &.at(i - ord - 1)
        else
          left.try &.at(i)
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

      # キーが`k`のノードがあれば値を更新
      # なければ新しいノードを追加
      def upsert(k : K, v : V) : self
        if k == key
          @val = v
        elsif k < key
          @left = left.try &.upsert(k, v) || self.class.new(k, v, @fxx)
        else
          @right = right.try &.upsert(k, v) || self.class.new(k, v, @fxx)
        end
        update
      end

      # k未満と、k以上で分割
      def split(k : K) : {Node(K, V)?, Node(K, V)?}
        if key < k
          @right, snd = right.try &.split(k) || nil_node_pair
          {update, snd}
        else
          fst, @left = left.try &.split(k) || nil_node_pair
          {fst, update}
        end
      end

      # `i`番目未満と以上で分割
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
        left.try &.to_a || [] of K
      end

      def right_to_a
        right.try &.to_a || [] of K
      end

      def left_keys
        left.try &.keys || [] of K
      end

      def right_keys
        right.try &.keys || [] of K
      end

      def left_values
        left.try &.values || [] of V
      end

      def right_values
        right.try &.values || [] of V
      end

      def left_acc
        left.try &.acc || nil.as(V?)
      end

      def right_acc
        right.try &.acc || nil.as(V?)
      end

      def update
        @size = left_size + right_size + 1
        @acc = fxx.call(fxx.call(left_acc, val), right_acc)
        self
      end

      def nil_node
        nil.as(Node(K, V)?)
      end

      def nil_node_pair
        {nil_node, nil_node}
      end

      def inspect
        "(#{left.inspect} #{key} #{right.inspect})".gsub(/nil/, "")
      end

      def to_a
        left_to_a + [key] + right_to_a
      end

      def keys
        left_keys + [key] + right_keys
      end

      def values
        left_values + [val] + right_values
      end

      def each(&block : V -> Nil)
        left.try(&.each(&block))
        block.call(val)
        right.try(&.each(&block))
      end
    end
  end
end
