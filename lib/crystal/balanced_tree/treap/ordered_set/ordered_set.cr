require "crystal/balanced_tree/treap/common/tree"
require "crystal/balanced_tree/treap/common/node"

# TreapによるOrderedSet実装
module BalancedTree
  module Treap
    class OrderedSet(T)
      include Tree

      getter root : Node(T)?
      delegate inspect, to_s, to: root

      def initialize
        @root = nil
      end

      def initialize(k)
        @root = Node(T).new(k)
      end

      def initialize(@root : Node(T)?)
      end

      # キーが`k`のノードを持つなら真
      def includes?(k) : Bool
        root.try &.includes?(k) || false
      end

      # 順序を保って`k`をキーに持つノードを追加する
      def insert(k) : self
        return self if includes?(k)

        tail = self | k
        node = self.class.new(k)
        self + node + tail
      end

      # `insert`の別名
      def <<(k) : self
        insert(k)
      end

      # `k`をキーに持つノードを削除する
      def delete(k)
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

      # 根のキーを返す
      def key : T?
        root.try &.key
      end

      # i番目のノードのキーを返す
      def unsafe_fetch(i : Int) : T?
        t2 = self ^ i + 1
        t1 = self ^ i
        t1.root.try(&.key).tap { self + t1 + t2 }
      end
    end
  end
end
