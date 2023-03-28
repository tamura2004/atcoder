class Node(T)
  getter ch : StaticArray(Node(T)?, 2)
  getter val : T

  def initialize(@val : T)
    @ch = StaticArray(Node(T)?, 2).new { nil }
  end

  def rot(b)
    ch[b].try do |piv|
      ch[b] = piv.ch[b^1]
      piv.ch[b^1] = self
      piv
    end || self
  end

  def dir(v)
    v <= val ? 0 : 1
  end

  def splay(v)
    return self if v == val
    i = dir(v)
    ch[i].try do |x|
      j = x.dir(v)
      x.ch[j].try do |y|
        x.ch[j] = y.splay(v)
        if i == j
          rot(i).rot(i)
        else
          ch[i] = x.rot(i^1)
          rot(i)
        end
      end || rot(i)
    end || self
  end
end
