require "crystal/range_to_tuple"
require "crystal/balanced_tree/treap/node"

# TreapによるMultiset実装
module BalancedTree
  module Treap
    class Multiset(T)
      getter root : Node(T, T)?
      getter fxx : Proc(T?, T?, T?)
      delegate inspect, to_s, to: root

      # range sum
      def self.sum
        new(->(x : T, y : T) { x + y })
      end

      def initialize(fxx : Proc(T, T, T) = ->(x : T, y : T) { y })
        @fxx = ->(x : T?, y : T?) { x && y ? fxx.call(x, y) : x ? x : y }
        @root = nil
      end

      def initialize(@fxx)
        @root = nil
      end

      def initialize(k : T, @fxx)
        @root = Node(T, T).new(k, k, @fxx)
      end

      def initialize(@root : Node(T, T)?, @fxx)
      end

      def empty?
        root.nil?
      end

      # キーが`k`以上のノードを別の木として分割する
      #
      # keyの昇順に並んでいることを前提とする。
      # 自身を破壊的にk未満とし、k以上の木を返す
      #
      # ```
      # t1 # => Tree{1,2,3}
      # t2 = t1.split(2)
      # t1 # => Tree{1}
      # t2 # => Tree{2,3}
      # ```
      def split(k) : self
        @root, node = root.try &.split(k) || nil_node_pair
        self.class.new(node, @fxx)
      end

      # `split`の別名
      def |(k) : self
        split(k)
      end

      # `index`番目以降のノードを別の木として分割する
      #
      # 負の引数は後ろからのindexに読み替える
      # 自身を破壊的にi未満とし、i以上の木を返す
      #
      # ```
      # t1 # => Tree{1,2,3}
      # t2 = t1.split_at(1)
      # t1 # => Tree{1}
      # t2 # => Tree{2,3}
      # ```
      def split_at(i : Int) : self
        i += size if i < 0
        @root, node = root.try &.split_at(i) || nil_node_pair
        self.class.new(node, @fxx)
      end

      # `split_at`の別名
      def ^(i : Int) : self
        split_at(i)
      end

      # 木を結合する
      #
      # 自身を破壊的に変更し、`b`を後ろに追加する
      #
      # ```
      # t1 # => Tree{1}
      # t2 # => Tree{2,3}
      # t1.merge(t2)
      # t1 # => Tree{1,2,3}
      # ```
      def merge(b : self) : self
        @root = root.try &.merge(b.root) || b.root
        self
      end

      # `merge`の別名
      def +(b : self) : self
        merge(b)
      end

      # 木のノード数を返す
      #
      # ノードを持たない木のサイズは0
      def size : Int32
        root.try &.size || 0
      end

      # ノードを持たないなら真を返す
      def empty? : Bool
        size.zero?
      end

      # 順序を保って`Array`を返す
      def to_a
        root.try &.to_a || ([] of T)
      end

      # キーが`k`のノードを持つなら真
      def includes?(k) : Bool
        root.try &.includes?(k) || false
      end

      # 順序を保って`k`をキーに持つノードを追加する
      def insert(k) : self
        tail = self | k
        node = self.class.new(k, @fxx)
        self + node + tail
      end

      # `insert`の別名
      def <<(k) : self
        insert(k)
      end

      # `k`をキーに持つノードを一つ削除する
      def delete(k)
        return unless includes?(k)
        t1 = self | k
        t2 = t1 ^ 1
        self + t2
      end

      # `k`をキーに持つノードをすべて削除する
      def delete_all(k)
        t1 = self | k
        t2 = t1 | k + 1
        self + t2
      end

      # 先頭の要素を削除して返す
      #
      # 空の木の場合、`NilAssertion`例外
      def shift : T
        tail = self ^ 1
        key.tap { @root = tail.try &.root }.not_nil!
      end

      # 末尾の要素を削除して返す
      #
      # 空の木の場合、`NilAssertion`例外
      def pop : T
        tail = self ^ -1
        tail.key.not_nil!
      end

      # 先頭要素を返す
      #
      # 空の木の場合、nilを返す
      def first : T?
        tail = self ^ 1
        root.try(&.key).tap { self + tail }
      end

      # `first`の別名
      def min : T?
        first
      end

      # 末尾の要素を返す
      #
      # 空の木の場合、nilを返す
      def last : T?
        tail = self ^ -1
        tail.root.try(&.key).tap { self + tail }
      end

      # `last`の別名
      def max : T?
        last
      end

      # キーが`k`以上または越える最小のノードのキーを返す
      def upper(k, eq = true) : T?
        tail = self | k + (1 - eq.to_unsafe)
        tail.try(&.first).tap { self + tail }
      end

      # キーが`k`以下または未満の最大ノードのキーを返す
      def lower(k, eq = false) : T?
        tail = self | k + eq.to_unsafe
        last.tap { self + tail }
      end

      # キーが`k`以上または越えるノード数を返す
      def count_upper(k, eq = true) : Int32
        tail = self | k + (1 - eq.to_unsafe)
        tail.size.tap { self + tail }
      end

      # キーが`k`以下または未満のノード数を返す
      def count_lower(k, eq = false) : Int32
        tail = self | k + eq.to_unsafe
        size.tap { self + tail }
      end

      # キーの両側の値を返す
      def lower_upper(k, eq = true) : {T?, T?}
        {lower(k, eq), upper(k, eq)}
      end

      # キーが`lo`以上、`hi`未満のノード数を返す
      def count_range(lo, hi)
        tail = self | hi
        mid = self | lo
        mid.size.tap { self + mid + tail }
      end

      # 根のキーを返す
      def key : T?
        root.try &.key
      end

      # 集約値を返す
      def acc : T?
        root.try &.acc
      end

      # i番目のノードのキーを返す
      def unsafe_fetch(i : Int) : T?
        t2 = self ^ i + 1
        t1 = self ^ i
        t1.root.try(&.key).tap { self + t1 + t2 }
      end

      def [](i)
        unsafe_fetch(i)
      end

      def each(&block : T -> Nil)
        root.try &.each(&block)
      end

      def nil_node
        nil.as(Node(T, T)?)
      end

      def nil_node_pair
        {nil_node, nil_node}
      end

      # 小さい方からk個を処理
      def with_lower(k)
        upper = self ^ k
        yield self
        self + upper
      end

      # 大きい方からk個を処理
      def with_upper(k)
        upper = self ^ (size - k)
        yield upper
        self + upper
      end
    end
  end
end

module Indexable(T)
  def to_multiset
    Multiset(T).new.tap do |ms|
      each do |v|
        ms << v
      end
    end
  end
end

alias Multiset = BalancedTree::Treap::Multiset
