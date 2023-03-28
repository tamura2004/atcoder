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
    lch.try do |piv|
      @lch = piv.rch
      piv.rch = self
      piv
    end || self
  end

  # Xを軸(pivot)として左回転
  #
  #   Y            X
  #  / \          / \
  # A   X   ->   Y   C
  #    / \      / \
  #   B   C    A   B
  def rot_l
    rch.try do |piv|
      @rch = piv.lch
      piv.lch = self
      piv
    end || self
  end

  def splay(v)
    case v <=> val
    when EQ then self
    when LT
      lch.try do |ch|
        case v <=> ch.val
        when EQ then rot_r
        when LT
          ch.lch.try do |gch|
            ch.lch = gch.splay(v)
            rot_r.rot_r
          end || rot_r
        else
          ch.rch.try do |gch|
            ch.rch = gch.splay(v)
            @lch = ch.rot_l
            rot_r
          end || rot_r
        end
      end || self
    else
      rch.try do |ch|
        case v <=> ch.val
        when EQ then rot_l
        when GT
          ch.rch.try do |gch|
            ch.rch = gch.splay(v)
            rot_l.rot_l
          end || rot_l
        else
          ch.lch.try do |gch|
            ch.lch = gch.splay(v)
            @rch = ch.rot_r
            rot_l
          end || rot_l
        end
      end || self
    end
  end

  def to_s(io)
    io << "(#{val} #{lch} #{rch})"
  end
end
