class BTrie
  class Node
    property i : Int32
    property size : Int32
    property ch : Array(Int32)

    def initialize(@i : Int32)
      @size = 0
      @ch = [0, 0]
    end
  end

  getter nodes : Array(Node)
  getter digit : Int32
  getter multi : Bool
  property mask : Int64

  def initialize(@digit = 64, @multi = false)
    @nodes = [Node.new(digit+1), Node.new(digit)]
    @mask = 0_i64
  end

  def add(v)
    i = 1
    nodes[i].size += 1

    (0...digit).reverse_each do |h|
      b = v.bit(h)
      ch = nodes[i].ch
      if ch[b].zero?
        i = ch[b] = nodes.size
        nodes << Node.new(h)
      else
        i = ch[b]
      end

      nodes[i].size += 1
    end
  end

  def to_a
    acc = [] of Int64
    to_a(acc, 1, 0_i64)
    acc
  end

  def to_a(acc, i, v)
    if nodes[i].i.zero?
      if multi
        nodes[i].size.times do
          acc << v
        end
      else
        acc << v
      end
    else
      2.times do |b|
        if nodes[i].ch[b] != 0
          to_a(acc, nodes[i].ch[b], v | (b << nodes[i].i.pred))
        end
      end
    end
  end

end
