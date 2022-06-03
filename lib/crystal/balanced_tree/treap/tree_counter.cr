require "crystal/balanced_tree/treap/counter"
require "crystal/balanced_tree/treap/tree"

module BalancedTree
  module Treap
    class TreeCounter(K, V)
      include Tree

      getter root : Counter(K, V)?
      delegate inspect, to_s, to: root

      def initialize
        @root = nil
      end

      def initialize(k, v)
        @root = Counter(K, V).new(k, v)
      end

      def initialize(@root : Counter(K, V)?)
      end

      # キーが`k`のノードを持つなら真
      def has_key?(k)
        root.try(&.includes?(k)) || false
      end

      # キーが`k`のノードを削除
      def delete(k : K)
        t1 = self | k
        t2 = t1 ^ 1
        self + t2
      end

      # キーが`k`であるノードの値を返す
      def fetch(k : K)
        root.try &.fetch(k) || V.zero
      end

      # `fetch`の別名
      def [](k : K)
        fetch(k)
      end

      # キーと値のペアを挿入
      def insert(k : K, v : V)
        tail = self | k
        self + self.class.new(k, v) + tail
      end

      # 値の更新
      def update(k : K, v : V)
        t1 = self | k
        t2 = t1 ^ 1
        t1.root.try &.val = v
        self + t1 + t2
      end

      # キーを持ち、値が正の整数なら更新、ゼロか負なら削除
      # キーが無く、値が正の整数なら挿入、ゼロか負ならなにもしない
      def put(k : K, v : V)
        case {has_key?(k), v > 0}
        when {true, true}  then update(k, v)
        when {true, false} then delete(k)
        when {false, true} then insert(k, v)
        end
      end

      # `put`の別名
      def []=(k : K, v : V)
        put(k, v)
      end

      # 最小のキー、木が空なら`NilAssertion`例外
      def min
        tail = self ^ 1
        root.try(&.key).tap { self + tail }.not_nil!
      end

      # 最大のキー、木が空なら`NilAssertion`例外
      def max
        tail = self ^ -1
        tail.root.try(&.key).tap { self + tail }.not_nil!
      end
    end
  end
end

alias TreeCounter = BalancedTree::Treap::TreeCounter
alias TreeCount = BalancedTree::Treap::TreeCounter
alias HashCount = BalancedTree::Treap::TreeCounter