class AVLTree(T)
  getter root : Node(T)?

  def initialize(@root : Node(T)? = nil)
  end

  def insert(v : T)
    @root = root.try &.insert(v) || Node(T).new(v)
  end

  def delete(v : T)
    @root = root.try &.delete(v)
  end

  def min_node
    @root.try &.min_node
  end

  def max_node
    @root.try &.max_node
  end

  def pop
    @root, node = root.try &.pop || {nil, nil}
    node
  end

  def inspect
    @root.inspect
  end

  def debug
    @root.try &.debug(0)
  end

  class Node(T)
    getter val : T
    getter balance : Int32
    getter height : Int32
    property left : Node(T)?
    property right : Node(T)?

    def initialize(@val)
      @balance = 0
      @height = 1
      @left = nil
      @right = nil
    end

    def insert(v)
      return self if v == val
      if v < val
        @left = left.try &.insert(v) || Node(T).new(v)
      else
        @right = right.try &.insert(v) || Node(T).new(v)
      end
      update
    end

    def delete(v)
      if v == val
        if left.nil? && right.nil?
          nil
        elsif right.nil?
          left
        elsif left.nil?
          right
        else
          @right, node = pop
          node.left = left
          node.right = right
          node
        end
      elsif v < val
        @left = left.try &.delete(v)
        update
      else
        @right = right.try &.delete(v)
        update
      end
    end

    def pop
      right.try do |r|
        @right, node = r.pop
        {update, node}
      end || {left, self}
    end

    def update
      @height = Math.max(left_height, right_height) + 1
      @balance = left_height - right_height
      re_balance
    end

    def re_balance
      case balance
      when 2..
        if left_balance < 0
          @left = left.try &.rotate_left
        end
        rotate_right
      when ..-2
        if right_balance > 0
          @right = right.try &.rotate_right
        end
        rotate_left
      else
        self
      end
    end

    def rotate_left
      right.try do |root|
        root.tap do
          @right, root.left = root.left, self
        end
      end || self
    end

    def rotate_right
      left.try do |root|
        root.tap do
          @left, root.right = root.right, self
        end
      end || self
    end

    def min_node
      left.try &.min_node || self
    end

    def max_node
      right.try &.max_node || self
    end

    @[AlwaysInline]
    def left_height
      left.try &.height || 0
    end

    @[AlwaysInline]
    def right_height
      right.try &.height || 0
    end

    @[AlwaysInline]
    def left_balance
      left.try &.balance || 0
    end

    @[AlwaysInline]
    def right_balance
      right.try &.balance || 0
    end

    def inspect
      # "\n([#{val},#{height},#{balance}] #{left.inspect} #{right.inspect})"
      "(#{val} #{left.inspect} #{right.inspect})"
    end

    def debug(indent = 0)
      left.try &.debug(indent + 2)
      puts " " * indent + "#{val}"
      right.try &.debug(indent + 2)
    end
  end
end

# tr = AVLTree(Int32).new
# 40.times do |i|
#   tr.insert rand(1000)
# end
# tr.debug
