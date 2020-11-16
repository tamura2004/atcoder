DIGIT = 4

class Node
  property cnt : Int32
  property ch : Array(Node?)

  def initialize
    @cnt = 0
    @ch = [nil, nil] of Node?
  end

  def add(x, i = DIGIT - 1) : Node
    @cnt += 1
    tap do
      next if i < 0
      case node = ch[j = x.bit(i)]
      when Nil
        ch[j] = Node.new.add(x, i - 1)
      when Node
        node.add(x, i - 1)
      end
    end
  end

  def sub(x, i = DIGIT - 1) : Node?
    @cnt -= 1
    return nil if @cnt.zero?
    case node = ch[j = x.bit(i)]
    when Nil
      raise "no data"
    when Node
      ch[j] = node.sub(x, i - 1)
      self
    end
  end

  def get_min(x, i = DIGIT - 1)
    return 0 if i < 0
    j = x.bit(i)
    k = ch[j].nil? ? 1 : 0
    j ^= k
    return get_min(x, i - 1) | (j << i)
  end

  def debug(v = -1, indent = 0)
    printf("%s%d\n", " " * indent, v)
    ch.each_with_index do |node, i|
      if node
        node.debug(i, indent + 2)
      end
    end
  end

end

tr = Node.new
tr.add(7)
tr.debug
# tr.sub(1)
# pp tr
