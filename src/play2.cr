class Node(T)
  EQ =  0
  GT =  1
  LT = -1

  property lch : Node(T)?
  property rch : Node(T)?
  getter val : T

  def initialize(@val : T)
    @lch = @rch = nil.as(Node(T)?)
  end

  # Xを軸(pivot)として右回転
  #
  #     y          X
  #    / \        / \
  #   X   C  ->  A   Y
  #  / \            / \
  # A   B          B   C
  def rot_r
    if piv = lch
      @lch = piv.rch
      piv.rch = self
      piv
    else
      self
    end
  end

  # Xを軸(pivot)として左回転
  #
  #   Y            X
  #  / \          / \
  # A   X   ->   Y   C
  #    / \      / \
  #   B   C    A   B
  def rot_l
    if piv = rch
      @rch = piv.lch
      piv.lch = self
      piv
    else
      self
    end
  end

  def splay(v)
    case v <=> val
    when EQ then self
    when LT
      if ch = lch
        case v <=> ch.val
        when EQ then rot_r
        when LT
          if gch = ch.lch
            ch.lch = gch.splay(v)
            rot_r.rot_r
          else
            rot_r
          end
        else
          if gch = ch.rch
            ch.rch = gch.splay(v)
            @lch = ch.rot_l
            rot_r
          else
            rot_r
          end
        end
      else
        self
      end
    else
      if ch = rch
        case v <=> ch.val
        when EQ then rot_l
        when GT
          if gch = ch.rch
            ch.rch = gch.splay(v)
            rot_l.rot_l
          else
            rot_l
          end
        else
          if gch = ch.lch
            ch.lch = gch.splay(v)
            @rch = ch.rot_r
            rot_l
          else
            rot_l
          end
        end
      else
        self
      end
    end
  end

  def to_s(io)
    io << "(#{val} #{lch} #{rch})"
  end
end

z = Node.new(30)
y = Node.new(20)
x = Node.new(10)
z.lch = y
y.lch = x

puts z
puts x
z.splay(10)
puts z
puts x
