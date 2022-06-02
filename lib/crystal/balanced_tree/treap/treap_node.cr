module BalancedTree
  module Treap
    abstract class TreapNode(T)
      abstract def key
      abstract def pri
      abstract def size
      abstract def left
      abstract def right
      abstract def left=(node : TreapNode(T)?)
      abstract def right=(node : TreapNode(T)?)

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
      def split(k : T)
        if key < k
          fst, snd = right.try &.split(k) || nil_node_pair
          self.right = fst
          {update, snd}
        else
          fst, snd = left.try &.split(k) || nil_node_pair
          self.left = snd
          {fst, update}
        end
      end

      # 添え字i未満と、以上で分割（0-origin）
      def split_at(i : Int)
        ord = left_size
        if ord < i
          fst, snd = right.try &.split_at(i - ord - 1) || nil_node_pair
          self.right = fst
          {update, snd}
        else
          fst, snd = left.try &.split_at(i) || nil_node_pair
          self.left = snd
          {fst, update}
        end
      end

      def merge(b : self?)
        return self if b.nil?

        if pri > b.pri
          self.right = right.try &.merge(b) || b
          update
        else
          b.left = merge(b.left)
          b.update
        end
      end
    end
  end
end
