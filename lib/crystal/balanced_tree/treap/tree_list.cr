require "crystal/balanced_tree/treap/node"

# 平衡二分探索木
module BalancedTree
  # `Treap`による実装
  module Treap
    # リスト型の実装
    #
    # 区間ローテートがO(log N)で可能
    # swapがO(log N)で可能
    class TreeList(V)
      # include List

      getter root : Node(V,V)?

      # 空の木で初期化
      def initialize
        @root = nil
      end

      # 値`v`を一つ持つ木を初期化
      def initialize(v : V)
        @root = Node(V,V).new(v,v)
      end

      # `root`を指定して初期化
      def initialize(@root : Node(V,V)?)
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

      # 末尾に値を追加
      def push(v : V)
        self + self.class.new(v)
      end

      # `push`の別名
      def <<(v : V)
        push v
      end

      # `i`番目の値を取得
      def at(i : Int) : V?
        i += size if i < 0
        root.try(&.at(i))
      end

      # `i`番目の値がnilなら例外
      def [](i : Int) : V
        if v = at(i)
          v
        else
          raise IndexError.new
        end
      end

      # `at`の別名
      def []?(i : Int) : V?
        at(i)
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

      def values
        root.try &.values || [] of V
      end
    end
  end
end

alias TreeList = BalancedTree::Treap::TreeList
