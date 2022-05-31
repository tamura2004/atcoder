require "crystal/balanced_tree/treap/node"
require "crystal/balanced_tree/treap/split_mergeable"

module BalancedTree
  module Treap
    class Multiset(T)
      include SplitMergeable(T)
      
      getter root : Node(T)?
      delegate "==", to: root

      def initialize
        @root = nil_node
      end

      def initialize(k : T)
        @root = Node(T).new(k)
      end

      def initialize(@root : Node(T)?)
      end

      def includes?(k : T) : Bool
        root.try &.includes?(k) || false
      end

      def split(k : T) : self
        @root, node = root.try &.split(k) || nil_node_pair
        self.class.new(node)
      end

      def split_at(i : Int) : self
        i += size if i < 0
        @root, node = root.try &.split_at(i) || nil_node_pair
        self.class.new(node)
      end

      def merge(b : self)
        @root = root.try &.merge(b.root) || b.root
        self
      end

      def size : Int32
        @root.try &.size || 0
      end

      def key : T?
        @root.try &.key
      end

      private def nil_node
        nil.as(Node(T)?)
      end

      private def nil_node_pair
        {nil_node, nil_node}
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

include BalancedTree::Treap