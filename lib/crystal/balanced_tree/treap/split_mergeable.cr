module BalancedTree
  module Treap
    module SplitMergeable(T)
      include Indexable(T)

      abstract def split(k : T)
      abstract def split_at(i : Int)
      abstract def merge(b : self)

      def +(b : self)
        merge(b)
      end

      def |(k : T)
        split(k)
      end

      def ^(i : Int)
        split_at(i)
      end

      def insert(k : T) : self
        tail = self | k
        node = self.class.new(k) # <- k : T で初期化できる制約
        self + node + tail
      end

      def <<(k : T) : self
        insert(k)
      end

      def delete(k : T)
        return unless includes?(k)
        t1 = self | k
        t2 = t1 ^ 1
        self + t2
      end

      def delete_all(k : T)
        t1 = self | k
        t2 = t1 | k + 1
        self + t2
      end

      def shift : T
        tail = self ^ 1
        key.tap { @root = tail.try &.root }.not_nil!
      end

      def pop : T
        tail = self ^ -1
        tail.key.not_nil!
      end

      def first : T?
        size.zero? ? nil : self[0]
      end

      def last : T?
        size.zero? ? nil : self[-1]
      end

      def upper(k : T, eq = true) : T?
        tail = self | k + (1 - eq.to_unsafe)
        tail.try(&.first).tap { self + tail }
      end

      def lower(k : T, eq = false) : T?
        tail = self | k + eq.to_unsafe
        last.tap { self + tail }
      end

      def lower_upper(k : T, eq = true) : Tuple(T?, T?)
        {lower(k, eq), upper(k, eq)}
      end

      def unsafe_fetch(i : Int)
        t2 = self ^ i + 1
        t1 = self ^ i
        t1.root.try(&.key).tap { self + t1 + t2 }
      end
    end
  end
end
