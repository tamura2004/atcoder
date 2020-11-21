class Treap
  class Node
    getter v : Int32
    getter ch : Array(Pointer(Node))
    getter pri : Int32
    getter cnt : Int32
    getter sum : Int32

    def initialize(@v, @pri)
      @ch = [Pointer(Node).null] * 2
      @sum = v
      @cnt = 1
    end
  end
end

struct Pointer(T)
  def cnt
    null? ? 0 : value.cnt
  end
end

