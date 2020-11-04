class Treap
  getter root : Node

  def initialize
    @root = NilNode.instance
  end

  def insert(x)
    @root = @root.insert(x)
  end

  def delete(x)
    @root = @root.delete(x)
  end

  def find(x)
    @root.find(x)
  end

  def debug(d)
    puts "="*20
    @root.debug(d)
  end

  class Node
    property! left : self
    property! right : self
    getter v : Int32
    getter pri : Int32

    def initialize(@v, @pri)
      @left = @right = NilNode.instance
    end

    def self.build(v)
      new(v, rand(Int32::MAX))
    end

    def insert(x) : self
      return Node.build(x) if nil_node?
      if x < v
        if left.nil_node?
          @left = Node.build(x)
        else
          @left = left.insert(x)
        end
        if left.pri < pri
          rotate_right
        else
          self
        end
      else
        if right.nil_node?
          @right = Node.build(x)
        else
          @right = right.insert(x)
        end
        if right.pri < pri
          rotate_left
        else
          self
        end
      end
    end

    def delete(x)
      pp! [x,v]
      return self if nil_node?
      case x
      when .== v
        case
        when left.nil_node? && right.nil_node?
          NilNode.instance
        when left.nil_node?
          node = rotate_left
          left.delete(x)
          return node
        when right.nil_node?
          node = rotate_right
          right.delete(x)
          return node
        when left.pri < right.pri
          node = rotate_right
          right.delete(x)
          return node
        else
          node = rotate_left
          left.delete(x)
          return node
        end
      when .< v
        @left = left.delete(x)
        self
      else
        @right = right.delete(x)
        self
      end
    end

    def rotate_right : Node
      if node = @left
        @left = node.right
        node.right = self
        node
      else
        self
      end
    end

    def rotate_left : Node
      if node = @right
        @right = node.left
        node.left = self
        node
      else
        self
      end
    end

    def find(x)
      return self if nil_node?
      return self if v == x
      if x < v
        left.find(x)
      else
        right.find(x)
      end
    end

    def nil_node?
      false
    end

    def debug(d)
      return "" if nil_node?
      spc = Array.new(d){ ' ' }.join
      [
        "#{spc} #{v}, #{pri}",
        "left:" + left.debug(d + 1),
        "right:" + right.debug(d + 1),
      ].join("\n").gsub(/\n+/,"\n")
    end
  end

  class NilNode < Node
    def self.instance
      @@nil_node ||= new(Int32::MAX, Int32::MAX)
    end

    def initialize(@v, @pri)
      @left = @right = self
    end

    def nil_node?
      true
    end
  end
end

t = Treap.new
10.times do |i|
 t.insert i
 puts t.debug(0)
end
10.times do |i|
 t.delete i
 puts t.debug(0)
end