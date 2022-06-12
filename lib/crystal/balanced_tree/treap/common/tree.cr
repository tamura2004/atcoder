module BalancedTree
  module Treap
    module Tree
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
    end
  end
end
