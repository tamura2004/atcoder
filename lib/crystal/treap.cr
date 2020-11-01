class Treap
  class Node
    property left : self?
    property right : self?
    getter v : Int32
    getter pri : Int32

    def initialize(@v)
      @pri = ((v+4)*5)%7 #rand(Int32::MAX)
      pp [v,pri]
      @left = nil
      @right = nil
    end

    def insert(x)
      if x < v
        if node = left
          @left = node.insert(x)
        else
          @left = Node.new(x)
        end
        rotate_right?
      else
        if node = right
          @right = node.insert(x)
        else
          @right = Node.new(x)
        end
        rotate_left?
      end
    end
    
    def rotate_right?
      return self unless node = left
      return self if pri <= node.pri
      @left, node.right = node.right, self
      return node
    end
    
    def rotate_left?
      return self unless node = right
      return self if pri <= node.pri
      @right, node.left = node.left, self
      return node
    end

    def min
      left.nil? ? v : left.as(Node).min
    end

    def max
      right.nil? ? v : right.as(Node).max
    end

    def debug(i)
      puts " " * i + v.to_s
      left && left.as(Node).debug(i+2) 
      right && right.as(Node).debug(i+2) 
    end
  end

  getter root : Node
  forward_missing_to root

  def initialize(v)
    @root = Node.new(v)
  end

  def insert(x)
    node = @root.insert(x)
    @root = node
  end
end

