require "crystal/balanced_tree/treap/common/value"
require "crystal/balanced_tree/treap/common/list"

# 平衡二分探索木
module BalancedTree
  # `Treap`による実装
  module Treap
    # リスト型の実装
    #
    # 区間ローテートがO(log N)で可能
    # swapがO(log N)で可能
    class TreeList(V)
      include List

      getter root : Value(V)?

      # 空の木で初期化
      def initialize
        @root = nil
      end

      # 値`v`を一つ持つ木を初期化
      def initialize(v : V)
        @root = Value(V).new(v)
      end

      # `root`を指定して初期化
      def initialize(@root : Value(V)?)
      end

      # 末尾に値を追加
      def push(v : V)
        self + self.class.new(v)
      end

      # `push`の別名
      def <<(v : V)
        push v
      end

      # `i`番目の値を取得
      def fetch(i : Int) : V?
        i += size if i < 0
        root.try(&.fetch(i))
      end

      # `i`番目の値がnilなら例外
      def [](i : Int) : V
        if v = fetch(i)
          v
        else
          raise IndexError.new
        end
      end

      # `fetch`の別名
      def []?(i : Int) : V?
        fetch(i)
      end

      # `i`番目の値を更新
      def put(i : Int, v : V)
        i += size if i < 0
        root.try &.put(i, v)
      end

      # `put`の別名
      def []=(i : Int, v : V)
        put(i, v)
      end

      # 区間[lo,hi)を`mid`が先頭になるようにローテート
      def rotate(lo, mid, hi)
        t3 = self ^ hi
        t2 = self ^ mid
        t1 = self ^ lo
        self + t2 + t1 + t3
      end

      # 区間`r`をその中のi番目が先頭になるようにローテート
      def rotate(r : Range(Int::Primitive?, Int::Primitive?), i : Int)
        lo = r.begin || 0
        hi = r.end.try(&.+(1 - r.excludes_end?.to_unsafe)) || size
        i += (lo...hi).size if i < 0
        mid = lo + i
        rotate(lo, mid, hi)
      end

      # `i`番目と`j`番目の値を交換する
      def swap(i : Int, j : Int)
        self[i], self[j] = self[j], self[i]
      end

      def to_a
        root.try &.to_a || [] of V
      end
    end
  end
end

alias TreeList = BalancedTree::Treap::TreeList
