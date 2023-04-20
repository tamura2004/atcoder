struct BTrie
  class Node
    property ch : StaticArray(Node?, 2)
    property size : Int32

    def initialize
      @ch = StaticArray[nil.as(Node?), nil.as(Node?)]
      @size = 0
    end
  end

  getter root : Node
  getter digit : Int32
  getter multi : Bool

  def initialize(@digit = 64, @multi = false)
    @root = Node.new
  end

  def add(v)
    node = root
    node.size += 1

    (0...digit).reverse_each do |h|
      if nv = node.ch[v.bit(h)]
        node = nv
      else
        new_node = Node.new
        node.ch[v.bit(h)] = new_node
        node = new_node
      end
      node.size += 1
    end
  end

  def <<(v)
    add(v)
  end

  def to_a
    acc = [] of Int64
    to_a(acc, root, digit, 0_i64)
    acc
  end

  def to_a(acc, node, height, v)
    if height.zero?
      if multi
        node.size.times do
          acc << v
        end
      else
        acc << v
      end
    else
      2.times do |b|
        node.ch[b].try do |nv|
          to_a(acc, nv, height - 1, v | (b << height.pred))
        end
      end
    end
  end
end
