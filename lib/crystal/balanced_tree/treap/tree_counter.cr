require "crystal/balanced_tree/treap/node"

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
      # include Tree

      getter root : Node(K, V)?
      delegate inspect, to_s, to: root

      # 空要素で初期化
      def initialize
        @root = nil
      end

      # キー*k*に対応した数字*v*で初期化
      def initialize(k, v)
        @root = Node(K, V).new(k, v)
      end

      # 作成済のノードで初期化
      def initialize(@root : Node(K, V)?)
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
        @root, node = root.try &.split(k) || {nil, nil}
        self.class.new(node)
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
        @root, node = root.try &.split_at(i) || {nil, nil}
        self.class.new(node)
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
        root.try &.to_a
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
