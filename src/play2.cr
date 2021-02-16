class Node
  getter v : Int32
  getter left : Pointer(Node)
  getter right : Pointer(Node)

  def initialize(@v)
    @left = Pointer(Node).null
    @right = Pointer(Node).null
  end

  def add(x)
    if x < v
      case left = @left
      when Pointer(Node).null
        n = Node.new(x)
        @left = pointerof(n)
      end
    else
      case right = @right
      when Pointer(Node).null
        n = Node.new(x)
        @right = pointerof(n)
      end
    end
  end
end

tr = Node.new(1)
tr.add(2)
tr.add(3)
tr.add(-1000)

pp tr.left.value
