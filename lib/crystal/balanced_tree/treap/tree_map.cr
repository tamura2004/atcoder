require "crystal/range_to_tuple"
require "crystal/balanced_tree/treap/node"

# 平衡二分探索木
module BalancedTree
  # `Treap`による実装
  module Treap
    # 辞書型の実装
    #
    # キーを昇順で持つ
    class TreeMap(K, V)
      getter root : Node(K, V)?
      getter fxx : Proc(V?, V?, V?)
      getter default : V?

      # 空の辞書を初期化
      def initialize(fxx : Proc(V, V, V) = ->(x : V, y : V) { y }, @default = nil.as(V?))
        @fxx = ->(x : V?, y : V?) { x && y ? fxx.call(x, y) : x ? x : y }
        @root = nil.as(Node(K, V)?)
      end

      # doブロックで初期化
      def initialize(@default = nil.as(V?), &block : Proc(V, V, V))
        @fxx = -> (x : V?, y : V?) {
          x && y ? block.call(x, y) : x ? x : y
        }
        @root = nil.as(Node(K, V)?)
      end

      # 根を指定して初期化
      def initialize(@root : Node(K, V)?, @fxx, @default)
      end

      # キーが`k`のノードがあれば値を更新
      # なければノードを追加
      def upsert(k, v)
        @root = root.try &.upsert(k, v) || Node(K ,V).new(k, v, @fxx)
      end

      # `upsert`の別名
      def []=(k : K, v : V)
        upsert(k, v)
      end

      def fetch(k : K) : V?
        root.try &.fetch(k)
      end

      def []?(k : K) : V?
        fetch(k)
      end

      def [](k : K) : V
        fetch(k) || @default.not_nil!
      end

      # キーが`k`以上のノードを別の木として分割する
      def split(k) : self
        @root, tail = root.try &.split(k) || nil_node_pair
        self.class.new(tail, @fxx, @default)
      end

      # `split`の別名
      def |(k) : self
        split(k)
      end

      # 木を結合する
      #
      # 自身を破壊的に変更し、`b`を後ろに追加する
      # 自身のすべてのキー < bのすべてのキーを仮定する
      def merge(b : self) : self
        @root = root.try &.merge(b.root) || b.root
        self
      end

      # `mergeの別名`
      def +(b : self) : self
        merge(b)
      end

      # キーが`k`のノードを持つなら真
      def includes?(k : K) : Bool
        root.try &includes?(k) || false
      end

      # `includes?`の別名
      def has_key?(k : K) : Bool
        includes?(k)
      end

      # 木のノード数
      def size : Int32
        root.try &.size || 0
      end

      # 木は空か
      def empty? : Bool
        root.nil?
      end

      # 木の集約値
      def acc : V?
        root.try &.acc
      end

      # `Range`に含まれる範囲のキーについて値を集約
      def acc(r : Range(Int::Primitive?, Int::Primitive?)) : V?
        lo, hi = RangeToTuple(K).from(r)
        mid = self | lo
        tail = mid | hi
        mid.acc.tap { self + mid + tail }
      end

      def [](r : Range(Int::Primitive?, Int::Primitive?)) : V
        acc(r) || @default.not_nil!
      end

      def []?(r : Range(Int::Primitive?, Int::Primitive?)) : V?
        acc(r)
      end

      def nil_node
        nil.as(Node(K, V)?)
      end

      def nil_node_pair
        { nil_node, nil_node }
      end
    end
  end
end

struct Int
  def to_tree_map_sum
    TreeMap(self, Int64).new(
      -> (x : Int64, y : Int64) { x + y },
      0_i64
    )
  end
end