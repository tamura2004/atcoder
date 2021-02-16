class Treap(T)
  class Node(T)
    getter v : T
    getter pri : Int32
    getter cnt : Int32
    property left : self?
    property right : self?

    def initialize(@v : T)
      @pri = rand(Int32::MAX)
      @left = @right = nil
      @cnt = 0
    end

    def [](x)
      case
      when v.first == x
        return v.last
      when x < v.first
        case left = @left
        when Nil
          return v.last
        when Node
          left[x]
        end
      when x > v.first
        case right = @right
        when Nil
          return v.last
        when Node
          right[x]
        end
      end
    end

    def insert(x : T)
      @cnt += 1
      case
      when x.first == v.first
        @v = x
        self
      when  x < v
        case left = @left
        when Nil
          @left = Node.new(x)
        when Node
          @left = left.insert(x)
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
      when x > v
        case right = @right
        when Nil
          @right = Node.new(x)
        when Node
          @right = right.insert(x)
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
      @cnt = (left.nil? ? 0 : left.as(Node(T)).cnt) + 1 + (right.nil? ? 0 : right.as(Node(T)).cnt)
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
      puts_with_indent(indent, v)

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

    def sum
      ans = v
      if left = @left
        ans += left.sum
      end
      if right = @right
        ans += right.sum
      end
      return ans
    end
  end

  getter root : Node(T)?

  def initialize
    @root = nil
  end

  def insert(x : T)
    case root = @root
    when Nil
      @root = Node.new(x)
    when Node
      @root = root.insert(x)
    end
  end

  def [](x)
    case root = @root
    when Nil
      return nil
    when Node
      return root[x]
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

  def sum
    case root = @root
    when Nil  then 0
    when Node then root.sum
    end
  end

  def cnt
    case root = @root
    when Nil then 0
    when Node then root.cnt
    end
  end
end

alias Pair = Tuple(Int32,Int32)
tr = Treap(Pair).new

tr.insert({10,200})
tr.insert({30,300})
pp tr[29]
tr.insert({20,100})
pp tr[29]
tr.insert({30,500})
pp tr[29]

tr.debug