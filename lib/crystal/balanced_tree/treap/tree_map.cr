require "crystal/range_to_tuple"
require "crystal/balanced_tree/treap/node"

# 平衡二分探索木による辞書型
module BalancedTree
  # `Treap`による実装
  module Treap
    # 辞書型の実装
    #
    # キーを昇順で持つ
    class TreeMap(K, V)
      getter root : Node(K, V)?
      getter fxx : Proc(V?, V?, V?)

      # 空の辞書を初期化
      def initialize(fxx : Proc(V,V,V) = ->(x : V, y : V) { y })
        @fxx = ->(x : V?, y : V?) { x && y ? fxx.call(x, y) : x ? x : y }
        @root = nil.as(Node(K, V)?)
      end

      def initialize(@root : Node(K, V)?, @fxx)
      end

      def split(k) : self
        @root, tail = root.try &.split(k) || { nil.as(self?), nil.as(self?) }
        self.class.new(node, @fxx)
      end

      def |(k) : self
        split(k)
      end

      def merge(b : self) : self
        @root = root.try &merge(b.root) || b.root
        self
      end

      def includes?(k : K) : Bool
        root.try &includes?(k) || false
      end

      def has_key?(k : K) : Bool
        includes?(k)
      end

      def insert(k, v) : self
        tail = self | k
      end

      def +(b : self) : self
        merge(b)
      end

      def size : Int32
        root.try &.size || 0
      end

      def empty? : Bool
        root.nil?
      end
    end
  end
end