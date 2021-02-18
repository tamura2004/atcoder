class Treap(T)
  class Node(T)
    getter key : T
    getter val : T
    getter sum : T
    getter pri : Int32
    property left : self?
    property right : self?

    def initialize(@key : T, @val : T)
      @pri = rand(Int32::MAX)
      @left = @right = nil
      @sum = val
    end

    def insert(x : T, val : T)
      if x == key
        @val = val
        update
      elsif x < key
        case left = @left
        when Nil
          @left = Node.new(x, val)
        when Node
          @left = left.insert(x, val)
        end

        case left = @left
        when Nil
          self
        when Node
          if left.pri < pri
            rotate_right
          else
            self
          end
        end
      else
        case right = @right
        when Nil
          @right = Node.new(x, val)
        when Node
          @right = right.insert(x, val)
        end

        case right = @right
        when Nil
          self
        when Node
          if right.pri < pri
            rotate_left
          else
            self
          end
        end
      end
    end

    def update
      @sum = (left.nil? ? 0 : left.as(Node(T)).sum) + val + (right.nil? ? 0 : right.as(Node(T)).sum)
      self
    end

    def rotate_right : Node(T)
      if left = @left
        @left = left.right
        left.right = self
        update
        left.update
      else
        self
      end
    end

    def rotate_left
      if right = @right
        @right = right.left
        right.left = self
        update
        right.update
      else
        self
      end
    end

    def merge(left : self?, right : self?)
      case {left, right}
      when {Nil, Nil}
        nil
      when {Node, Nil}
        left
      when {Nil, Node}
        right
      when {Node, Node}
        if left.pri < right.pri
          left.right = merge(left.right, right)
          left
        else
          right.left = merge(left, right.left)
          right
        end
      end
    end

    def delete(x : T)
      @cnt -= 1
      case x
      when .== v
        merge(@left, @right)
      when .< v
        case left = @left
        when Nil
          self
        when Node
          @left = left.delete(x)
          self
        end
      when .> v
        case right = @right
        when Nil
          self
        when Node
          @right = right.delete(x)
          self
        end
      end
    end

    def min_node
      case left = @left
      when Nil  then self
      when Node then left.min_node
      end
    end

    def max_node
      case right = @right
      when Nil  then self
      when Node then right.max_node
      end
    end

    def min
      min_node.v
    end

    def max
      max_node.v
    end

    def debug(indent)
      puts_with_indent(indent, "#{key} => #{val}(#{sum})")

      case left = @left
      when Nil
        puts_with_indent(indent + 2, "left = nil")
      when Node
        left.debug(indent + 2)
      end

      case right = @right
      when Nil
        puts_with_indent(indent + 2, "right = nil")
      when Node
        right.debug(indent + 2)
      end
    end

    private def puts_with_indent(indent, msg)
      puts " " * indent + msg.to_s
    end

    def each(&block : self ->)
      if left = @left
        left.each(&block)
      end
      block.call(self)
      if right = @right
        right.each(&block)
      end
    end
  end

  getter root : Node(T)?

  def initialize
    @root = nil
  end

  def insert(x : T, val : T)
    case root = @root
    when Nil
      @root = Node.new(x, val)
    when Node
      @root = root.insert(x, val)
    end
  end

  def delete(x : T)
    case root = @root
    when Nil
    when Node
      @root = root.delete(x)
    end
  end

  def min_node
    case root = @root
    when Nil  then nil
    when Node then root.min_node
    end
  end

  def min
    case node = min_node
    when Nil  then nil
    when Node then node.v
    end
  end

  def max_node
    case root = @root
    when Nil  then nil
    when Node then root.max_node
    end
  end

  def max
    case node = max_node
    when Nil  then nil
    when Node then node.v
    end
  end

  def debug(indent = 0)
    puts
    case root = @root
    when Nil  then puts "root = nil"
    when Node then root.debug(indent)
    end
  end

  def each(&block : Node(T) ->)
    if root = @root
      root.each(&block)
    end
  end
end

tr = Treap(Int32).new
tr.insert(100, 200)
tr.insert(100, 300)
tr.insert(10, 20)
tr.insert(200, 12)
tr.debug