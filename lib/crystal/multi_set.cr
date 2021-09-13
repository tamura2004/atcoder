
class MultiSet
  class_getter nil_node : Node = NilNode.new
  2.times { |i| @@nil_node.ch[i] = @@nil_node }

  getter root : Node

  def initialize
    @root = MultiSet.nil_node
  end

  def initialize(@root)
  end

  def size
    root.size
  end

  def find(v)
    root.find(v)
  end

  def includes?(v)
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

  def split(r : Range(Int,Int))
    lo = r.begin.to_i64
    hi = r.end.to_i64 + (r.excludes_end? ? 0 : 1)
    left, mid = split(lo)
    mid, right = mid.split(hi)
    { mid, left.merge(right)}
  end

  def merge(right)
    node = Node.new(Int64::MIN, Int32::MAX)
    node.ch[0] = @root
    node.ch[1] = right.root
    @root = node.delete(Int64::MIN)
    self
  end

  def min
    root.min
  end

  def max
    root.max
  end

  def pop
    v = max
    @root = root.delete(v)
    v
  end

  def shift
    v = min
    @root = root.delete(v)
    v
  end

  def each(&block : Int64 -> _)
    root.each(&block)
  end

  def debug
    puts "==== DEBUG ===="
    root.debug
    puts "==== END ======"
  end

  def to_a
    root.to_a
  end

  class Node
    LEFT = 0
    RIGHT = 1

    getter val : Int64
    getter pri : Int32
    getter size : Int32
    getter ch : StaticArray(self, 2)

    def initialize(@val, @pri)
      @size = 1
      @ch = StaticArray[MultiSet.nil_node, MultiSet.nil_node]
    end

    def nil_node?
      false
    end

    def update
      @size = ch.sum(&.size) + 1
      self
    end

    def find(v)
      return true if v == val
      b = v < val ? LEFT : RIGHT
      ch[b].find(v)
    end

    def insert(v, pri)
      b = v <= val ? LEFT : RIGHT
      ch[b] = ch[b].insert(v, pri)
      update
      ch[b].pri > @pri ? rotate(b) : self
    end

    def delete(v)
      if v == val
        _delete
      else
        b = v < val ? LEFT : RIGHT
        ch[b] = ch[b].delete(v)
        update
      end
    end

    def _delete
      b = ch[0].pri < ch[1].pri ? RIGHT : LEFT
      rotate(b).tap do |node|
        next if node.nil_node?
        node.ch[1-b] = node.ch[1-b]._delete
        node.update
      end
    end

    def rotate(b)
      ch[b].tap do |node|
        next if node.nil_node?
        ch[b], node.ch[1 - b] = node.ch[1 - b], self
        update
        node.update
      end
    end

    def min
      ch[0].nil_node? ? val : ch[0].min
    end

    def max
      ch[1].nil_node? ? val : ch[1].max
    end

    def each(&block : Int64 -> _)
      ch[0].each(&block)
      block.call(val)
      ch[1].each(&block)
    end

    def debug(indent = 0)
      ch[1].debug(indent + 2)
      printf("%sv:%d s:%d p:%d\n", " " * indent, val, size, pri)
      ch[0].debug(indent + 2)
    end

    def to_a
      ch[0].to_a + [val] + ch[1].to_a
    end
  end

  class NilNode < Node
    def initialize
      @val = Int64::MIN
      @pri = Int32::MIN
      @size = 0
      nil_node = uninitialized Node
      @ch = StaticArray[nil_node, nil_node]
    end

    def nil_node?
      true
    end

    def update
      self
    end

    def find(v)
      false
    end

    def insert(v, pri)
      Node.new(v, pri)
    end

    def delete(v)
      self
    end

    def each(&block : Int64 -> _)
    end

    def debug(indent = 0)
      puts " " * indent + "nil"
    end

    def to_a
      return [] of Int32
    end
  end
end
