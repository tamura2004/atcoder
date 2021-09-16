class Treap(T)
  getter root : RealNode(T) | NilNode(T)

  def initialize(@root : RealNode(T) | NilNode(T) = NilNode(T))
  end

  class RealNode(T)
    getter size : Int32
    getter val : T
    getter pri : Int32
    property left : RealNode(T) | NilNode(T)
    property right : RealNode(T) | NilNode(T)

    def initialize(@val, @pri)
      @size = 1
      @left = NilNode(T)
      @right = NilNode(T)
    end

    def update
      @size = left.size + right.size + 1
      self
    end

    def nil_node?
      false
    end

    def merge(other)
      return self if other.nil_node?
      other
      # pp other.class

      # if pri < other.pri
        # other.ch[0] = merge(other.ch[0])
        # other.update
      # else
      #   ch[1] = ch[1].merge(other)
      #   update
      # end
    end
  end

  module NilNode(T)
    extend self

    def size
      0
    end

    def val
      nil
    end

    def pri
      Int32::MIN
    end

    def left
      NilNode
    end

    def right
      NilNode
    end

    def left=(v)
    end

    def right=(v)
    end

    def update
      self
    end

    def nil_node?
      true
    end

    def merge(other) : RealNode(T) | NilNode(T)
      other
    end
  end
end