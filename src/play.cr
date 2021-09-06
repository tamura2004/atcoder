class Treap(T)

  property root : RealNode(T) | NilNode

  def initialize
    @root = NilNode
  end

  class RealNode(T)
    getter size : Int32
    getter ch : StaticArray(RealNode(T) | NilNode, 2)

    def initialize
      @size = 1
      @ch = StaticArray[
        NilNode.as(RealNode(T) | NilNode),
        NilNode.as(RealNode(T) | NilNode)
      ]
    end
  end

  module NilNode
    extend self

    def size
      0
    end
  end
end

t = Treap(Int64).new
t.root = Treap::RealNode(Int64).new
pp t