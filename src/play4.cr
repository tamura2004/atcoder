class Node
  property ch : StaticArray(Node, 2)
  property nil_node : Bool
  property val : Int32?

  def initialize(@val : Int32?)
    @ch = uninitialized StaticArray(Node, 2)
    @nil_node = false
  end

  def inspect(io)
    if nil_node
      io << "()"
    else
      io << "(#{ch[0].inspect} #{val} #{ch[1].inspect})"
    end
  end
end

class P
  def self.nil_node
    n = Node.new(nil)
    n.ch = StaticArray(Node, 2).new { n }
    n.nil_node = true
    n
  end

  def self.new_node(v)
    n = Node.new(v)
    n.ch = StaticArray(Node, 2).new { P.nil_node }
    n
  end
end

n = P.new_node(10)

pp n