class Node
  attr_accessor :rch, :lch, :val

  def initialize(v)
    @val = v
    @rch = nil
    @lch = nil
  end

  def right_rotate
    y = x.lch
    x.lch = y.rch
    y.rch = x
    y
  end

  def left_rotate
    y = x.rch
    x.rch = y.lch
    y.lch = x
    y
  end

  def splay(v)
    return self if val == v
    if v < val
      if lch.nil?
        return self
      elsif v < lch.val
        x.lch.lch = splay(x.lch.lch, v)
        x = right_rotate(x)
      elsif x.lch.val < v
        x.lch.rch = splay(x.lch.rch, v)
        if !x.lch.rch.nil?
          x.lch = left_rotate(x.lch)
        end
      end
      return x.lch.nil? ? x : right_rotate(x)
    else
      if x.rch.nil?
        return x
      elsif v < x.rch.val
        x.rch.lch = splay(x.rch.lch, v)
        if !x.rch.lch.nil?
          x.rch = right_rotate(x.rch)
        end
      else
        x.rch.rch = splay(x.rch.rch, v)
        x = left_rotate(x)
      end
      return x.rch.nil? ? x : left_rotate(x)
    end
  end
end

up = Node.new(1)
me = Node.new(2)
hi = Node.new(3)

up.lch = me
me.rch = hi
up.splay(3)
