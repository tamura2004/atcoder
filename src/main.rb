class Node
  EQ = 0
  GT = 1
  LT = -1

  attr_accessor :lch, :rch, :val

  def initialize(val)
    @val = val
    @lch = nil
    @rch = nil
  end

  def rot_r
    return self if lch.nil?
    piv = lch
    @lch = piv.rch
    piv.rch = self
    piv
  end

  def rot_l
    return self if rch.nil?
    piv = rch
    @rch = piv.lch
    piv.lch = self
    piv
  end

  def splay(v)
    case v <=> val
    when EQ
      self
    when LT
      return self if lch.nil?
      case v <=> lch.val
      when EQ then rot_r
      when LT
        lch.lch = lch.lch.splay(v)
        rot_r.rot_r
      when GT
        lch.rch = lch.rch.splay(v)
        @lch = lch.rot_l
        rot_r
      end
    when GT
      return self if rch.nil?
      case v <=> rch.val
      when EQ then rot_l
      when GT
        rch.rch = rch.rch.splay(v)
        rot_l.rot_l
      when LT
        rch.lch = rch.lch.splay(v)
        @rch = rch.rot_r
        rot_l
      end
    end
  end

  def to_s
    "(#{val} #{lch} #{rch})"
  end
end

y = Node.new(10)
x = Node.new(20)
z = Node.new(15)
y.rch = x
x.lch = z
puts z
y.splay(11)

puts z
