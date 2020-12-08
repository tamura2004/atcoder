struct Nil
  def dep
    0
  end

  def ch
    {nil, nil}
  end

  def print(i)
  end

  def insert(k, v)
  end
end

class AVLTree
  class Node
    getter key : Int32
    getter val : Int32
    getter dep : Int32
    property ch : Array(Node?)

    def initialize(@key, @val)
      @ch = Array(Node?).new(2, nil)
      @dep = 0
    end

    def print(i = 0)
      ch.each(&.print(i + 2))
      puts " " * i + key.to_s
    end

    def insert(k, v)
      b = k < key ? 0 : 1
      ch[b] = ch[b].insert(k, v) || Node.new(k, v)
      self
    end

    def []=(k, v)
      insert(k, v)
    end

    def left
      ch[0]
    end

    def right
      ch[1]
    end

    def rotate
      case left.dep - right.dep
      when 2
        if left.dep < left.right.dep
          left = left.rotate(0)
        end
        root = rotate_right
      when -2
        if ch[1].ch[0].dep > ch[1].ch[1].dep
      else
      end
    end
  end

  getter root : Node?

  def initialize
    @root = nil
  end

  def print
    @root.try &.print
  end

  def []=(k, v)
    @root = @root.insert(k, v) || Node.new(k, v)
  end
end

t = AVLTree.new
10.times do |i|
  t[rand(100)] = rand(100)
end

t.print
