require "crystal/balanced_tree/treap/tree_counter/counter"
require "crystal/balanced_tree/treap/common/tree"

# 平衡二分探索木
module BalancedTree
  # `Treap`による実装
  module Treap
    # カウンターに特化したHash likeなデータ構造
    #
    # キーに対応した数字を持つ。デフォルト値は`V.zero`
    # 0以下の数字が割り当てられた場合、キーを削除する
    #
    # Example:
    # ```
    # t = TreeCounter{1 => 11_i64, 2 => 22_i64, 4 => 44_i64}
    # t[1].should eq 11
    # t[2].should eq 22
    # t[3].should eq 0
    #
    # t.has_key?(1).should eq true
    # t[1] -= 20
    # t.has_key?(1).should eq false
    #
    # t.min.should eq 2
    # t.max.should eq 4
    #
    # t[2] += 100
    # t[2].should eq 122
    # (t.max - t.min).should eq 2
    #
    # t.size.should eq 2
    # ```
    class TreeCounter(K, V)
      include Tree

      getter root : Counter(K, V)?
      delegate inspect, to_s, to: root

      # 空要素で初期化
      def initialize
        @root = nil
      end

      # キー*k*に対応した数字*v*で初期化
      def initialize(k, v)
        @root = Counter(K, V).new(k, v)
      end

      # 作成済のノードで初期化
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
