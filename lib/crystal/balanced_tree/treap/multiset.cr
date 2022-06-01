require "crystal/balanced_tree/treap/tree"

# TreapによるMultiset実装
module BalancedTree
  module Treap
    class Multiset(N) < Tree(N)
      def self.build(a : Array(T)) forall T
        Multiset(N).new.tap do |tree|
          a.each do |key|
            tree << key
          end
        end
      end

      # キーが`k`のノードを持つなら真
      def includes?(k) : Bool
        root.try &.includes?(k) || false
      end

      # 順序を保って`k`をキーに持つノードを追加する
      def insert(k) : self
        tail = self | k
        node = self.class.new(k)
        self + node + tail
      end

      # 別名
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
      def shift
        tail = self ^ 1
        key.tap { @root = tail.try &.root }.not_nil!
      end

      # 末尾の要素を削除して返す
      #
      # 空の木の場合、`NilAssertion`例外
      def pop
        tail = self ^ -1
        tail.key.not_nil!
      end

      # 先頭要素を返す
      #
      # 空の木の場合、nilを返す
      def first
        tail = self ^ 1
        root.try(&.key).tap { self + tail }
      end

      # 別名
      def min
        first
      end

      # 末尾の要素を返す
      #
      # 空の木の場合、nilを返す
      def last
        tail = self ^ -1
        tail.root.try(&.key).tap { self + tail }
      end

      # 別名
      def max
        last
      end

      # キーがk以上または越える最小のノードのキーを返す
      def upper(k, eq = true)
        tail = self | k + (1 - eq.to_unsafe)
        tail.try(&.first).tap { self + tail }
      end

      # キーがk以下または未満の最大ノードのキーを返す
      def lower(k, eq = false)
        tail = self | k + eq.to_unsafe
        last.tap { self + tail }
      end

      # キーがk以上または越えるノード数を返す
      def count_upper(k, eq = true)
        tail = self | k + (1 - eq.to_unsafe)
        tail.size.tap { self + tail }
      end

      # キーがk以下または未満のノード数を返す
      def count_lower(k, eq = false)
        tail = self | k + eq.to_unsafe
        size.tap { self + tail }
      end

      # キーの両側の値を返す
      def lower_upper(k, eq = true)
        {lower(k, eq), upper(k, eq)}
      end

      def key
        root.try &.key
      end

      def unsafe_fetch(i : Int)
        t2 = self ^ i + 1
        t1 = self ^ i
        t1.root.try(&.key).tap { self + t1 + t2 }
      end
    end
  end
end

include BalancedTree::Treap