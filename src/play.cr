class Treap(T)

  getter root : RealNode(T) | NilNode

  def initialize
    @root = NilNode
  end

  class RealNode(T)
    getter size : Int32
    property left : RealNode(T) | NilNode
    property right : RealNode(T) | NilNode

    def initialize
      @size = 1
      @left = NilNode
      @right = NilNode
    end
  end

  module NilNode
    extend self

    def size
      0
    end

    def left
      NilNode
    end

    def left=(v)
    end
  end
end

t = Treap(Int64).new
t.root.left = Treap::RealNode(Int64).new