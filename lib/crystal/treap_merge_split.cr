class Treap
  class Node
    property val : Int32
    property pri : Int32
    property cnt : Int32
    property sum : Int32
    property left : Node?
    property right : Node?

    def initialize(@val)
      @pri = rand(Int32::MAX)
      @cnt = 1
      @sum = val
      @left = nil
      @right = nil
    end

    def update
      tap do
        @cnt = (left.try(&.cnt) || 0) + (right.try(&.cnt) || 0) + 1
        @sum = (left.try(&.sum) || 0) + (right.try(&.sum) || 0) + val
      end
    end
  end

  def self.merge(left : Node?, right : Node?) : Node?
    case {left, right}
    when {Nil, Nil}  then nil
    when {Node, Nil} then left
    when {Nil, Node} then right
    when {Node, Node}
      if left.pri < right.pri
        left.right = merge(left.right, right)
        left.update
      else
        right.left = merge(left, right.left)
        right.update
      end
    end
  end

  # [0,k) [k,n)
  def self.split(node : Node?, k)
    if node
      if k <= count(node.left)
        s = split(node.left, k)
        node.left = s[1]
        {s[0], node.update}
      else
        s = split(node.right, k - count(node.left) - 1)
        node.right = s[0]
        {node.update, s[1]}
      end
    else
      {nil,nil}
    end

  end

  def self.count(node : Node?) : Int32
    node ? node.cnt : 0
  end
end

t = Treap::Node.new(1)
s = Treap::Node.new(2)
if u = Treap.merge(s, t)
  x,y = Treap.split(u,1)
  pp! x
  pp! y
end
