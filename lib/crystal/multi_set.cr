class MultiSet
  class_getter nil_node : Node = NilNode.new
  2.times { |i| @@nil_node.ch[i] = @@nil_node }

  getter root : Node

  def initialize
    @root = MultiSet.nil_node
  end

  def initialize(@root)
  end

  def find(v)
    root.find(v)
  end

  def <<(v)
    v = v.to_i64
    pri = rand(Int32::MAX)
    @root = root.insert(v, pri)
  end
  
  def insert(v, pri)
    v = v.to_i64
    @root = root.insert(v , pri)
  end

  def delete(v)
    @root = root.delete(v)
  end

  # [min, v)と[v, MAX)に分割
  def split(v)
    insert(v, Int32::MAX)
    left, right = root.ch
    { MultiSet.new(left), MultiSet.new(right) }
  end

  def merge(right)
    node = Node.new(Int64::MIN, Int32::MAX)
    node.ch[0] = @root
    node.ch[1] = right.root
    @root = node.delete(Int64::MIN)
  end

  def debug
    puts "==== DEBUG ===="
    root.debug
    puts "==== END ======"
  end

  class Node
    LEFT = 0
    RIGHT = 1

    getter val : Int64
    getter pri : Int32
    getter ch : StaticArray(self, 2)
    
    def initialize(@val, @pri)
      @ch = StaticArray[MultiSet.nil_node, MultiSet.nil_node]
    end

    def nil_node?
      false
    end

    def find(v)
      return true if v == val
      b = v < val ? LEFT : RIGHT
      ch[b].find(v)
    end

    def insert(v, pri)
      b = v <= val ? LEFT : RIGHT
      ch[b] = ch[b].insert(v, pri)
      ch[b].pri > @pri ? rotate(b) : self
    end

    def delete(v)
      if v == val
        _delete
      else
        b = v < val ? LEFT : RIGHT
        ch[b] = ch[b].delete(v)
      end
    end
    
    def _delete
      b = ch[0].pri < ch[1].pri ? RIGHT : LEFT
      rotate(b).tap do |node|
        next if node.nil_node?
        node.ch[1-b] = node.ch[1-b]._delete
      end
    end

    def rotate(b)
      ch[b].tap do |node|
        next if node.nil_node?
        ch[b], node.ch[1 - b] = node.ch[1 - b], self
      end
    end

    def debug(indent = 0)
      ch[1].debug(indent + 2)
      printf("%sv:%d p:%d\n", " " * indent, val, pri)
      ch[0].debug(indent + 2)
    end
  end

  class NilNode < Node
    def initialize
      @val = 0_i64
      @pri = 0
      nil_node = uninitialized Node
      @ch = StaticArray[nil_node, nil_node]
    end

    def nil_node?
      true
    end

    def find(v)
      false
    end

    def insert(v, pri)
      Node.new(v, pri)
    end

    def debug(indent = 0)
      puts " " * indent + "nil"
    end
  end
end
