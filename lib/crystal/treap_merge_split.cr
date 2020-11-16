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

    def merge(right : self?)
      case right
      when Nil then self
      when Node
        if pri < right.pri
          @right = @right.try{|node|node.merge(right)}
          update
        else
          right.left = merge(right.left)
          right.update
        end
      end
    end

    # def merge(left : self?, right : self?)
    #   case {left, right}
    #   when {Nil, Nil}  then nil
    #   when {Node, Nil} then left
    #   when {Nil, Node} then right
    #   when {Node, Node}
    #     if left.pri < right.pri
    #       left.right = merge(left.right, right)
    #       left.update
    #     else
    #       right.left = merge(left, right.left)
    #       right.update
    #     end
    #   end
    # end

  end
end

t = Treap::Node.new(1)
s = Treap::Node.new(2)
if u = t.as(Treap::Node).merge(s)
  pp u
end
