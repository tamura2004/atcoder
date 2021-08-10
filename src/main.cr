class BTree
  class_getter null = NilNode.new

  class Node
    property! left : self
    property! right : self

    getter! val : Int32
    getter! pri : Int32
    getter! cnt : Int32
    getter! sum : Int32

    def initialize(@val, @pri)
      @left = BTree.null
      @right = BTree.null
      @cnt = 1
      @sum = val
    end

    def null?
      false
    end

    def update
      @cnt = ch.sum(&.cnt) + 1
      @sum = ch.sum(&.sum) + 1
      self
    end

    def rotate(b)
      s = ch[1-b]
      setch 1-b, s.ch[b]
      s.setch b, self
      update
      s.update
      s
    end

    def ch
      { left, right }
    end

    def setch(b,v)
      case b
      when 0 then @left = v
      when 1 then @right = v
      end
    end
  end

  class NilNode < Node
    def initialize
      @left = self
      @right = self
      @val = @pri = @cnt = @sum = 0
    end

    def null?
      true
    end
  end
end

v1 = BTree::Node.new(2, 1)
v2 = BTree::Node.new(3, 2)
v3 = BTree::Node.new(4, 3)

