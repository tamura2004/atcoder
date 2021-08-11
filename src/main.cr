class Treap
  class_getter nil_node : Node = NilNode.new

  class Node
    getter key : Int32
    getter pri : Int32
    getter cnt : Int32
    property! left : self
    property! right : self

    def initialize(@key)
      @pri = rand(Int32::MAX)
      @cnt = 1
      @left = @right = Treap.nil_node
    end

    def nil_node?
      false
    end

    def find(x)
      return true if x == key

      if x < key
        left.find(x)
      else
        right.find(x)
      end
    end

    def insert(x)
      @cnt += 1

      if x < key
        @left = left.insert(x)
      else
        @right = right.insert(x)
      end
    end
  end

  class NilNode < Node
    def initialize
      @key = @pri = @cnt = 0
      @left = @right = self
    end

    def nil_node?
      true
    end

    def find(x)
      false
    end

    def insert(x)
      Node.new(x)
    end
  end
end

n1 = Treap::Node.new(10)
n2 = Treap::Node.new(3)
n3 = Treap::Node.new(50)

n1.left = n2
n1.right = n3

pp n1.find(3)
pp n1.find(5)
pp n1.find(10)
pp n1.find(15)
pp n1.find(50)
pp n1.find(60)
