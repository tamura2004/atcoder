require "crystal/balanced_tree/treap/node"
require "crystal/balanced_tree/treap/split_mergeable"

module BalancedTree
  module Treap
    class Multiset(T)
      include SplitMergeable(T)
      getter root : Node(T)?

      def initialize
        @root = nil_node
      end

      def initialize(k : T)
        @root = Node(T).new(k)
      end

      def initialize(@root : Node(T)?)
      end

      def includes?(k : T)
        root.try &.includes?(k)
      end

      def split(k : T) : Tuple(self, self)
        fst, snd = root.try &.split(k) || nil_node_pair
        {self.class.new(fst), self.class.new(snd)}
      end

      def split_at(i : Int) : Tuple(self, self)
        fst, snd = root.try &.split_at(i) || nil_node_pair
        {self.class.new(fst), self.class.new(snd)}
      end

      def merge(b : self) : self
        @root = root.try &.merge(b.root) || b.root
        self
      end

      def delete(k : T) : self
        @root = root.try &.delete(k)
        self
      end

      def size : T?
        @root.try &.size || 0
      end

      def sum : T
        @root.try &.sum || T.zero
      end

      def nil_node
        nil.as(Node(T)?)
      end

      def nil_node_pair
        {nil_node, nil_node}
      end

      def empty?
        root.nil?
      end

      def inspect
        @root.inspect
      end

      def to_s
        inspect
      end

      def to_a
        root.try &.to_a || [] of T
      end

      def each(&block : T -> Nil)
        root.try &.each(&block)
      end
    end
  end
end
