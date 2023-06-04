require "crystal/segment_tree_beats"

# 作用素
# x <- Xに対して、作用（apply）
# chmax x, mini
# chmin x, maxi
# x += incr
# かつ、合成(compose)ができる
class A
  getter lo : Int64
  getter hi : Int64
  getter up : Int64

  def initialize(@lo, @hi, @up)
  end

  # clip, add, clip, add
  def compose(b : self)
    nex_lo = Math.max lo, b.lo - up
    nex_hi = Math.min hi, b.hi - up
    if nex_lo <= nex_hi
      self.class.new(nex_lo, nex_hi, up + b.up)
    elsif nex_lo == b.lo
      self.class.new(nex_lo, nex_lo, up + b.up)
    else
      self.class.new(nex_hi, nex_hi, up + b.up)
    end
  end

  def +(b : self)
    compose(b)
  end

  def apply(x)
    chmax x, lo
    chmin x, hi
    x + up
  end

  def *(x)
    apply(x)
  end
end

class Node
  getter lo : Int64
  getter hi : Int64
  getter cnt : Int64
  getter lazy : A?
  getter sum : Int64

  def self.zero
    new(0_i64, 0_i64)
  end

  def initialize(@lo, @hi, @cnt, @sum)
    @lazy = nil.as(A?)
  end

  def initialize(@lo, @cnt)
    @hi = @sum = lo
    @lazy = nil.as(A?)
  end

  def initialize(@lo)
    @hi = @sum = lo
    @cnt = 1_i64
    @lazy = nil.as(A?)
  end
  
  def update(l, r)
    @lo = Math.min l.lo, r.lo
    @hi = Math.max l.hi, r.hi
    @cnt = l.cnt + r.cnt
    @sum = l.sum + r.sum
  end

  def push(l, r)
    if a = lazy
      l.add(a)
      r.add(a)
      @lazy = nil.as(A?)
    end
  end

  def add(b)
    if a = lazy
      @lazy = a + b
    else
      @lazy = b
    end
  end

  def apply(a)
    if (lo < a.hi < hi) || (lo < a.lo < hi)
      false
    elsif hi <= a.lo
      @lo = @hi = a.lo + a.up
      @sum = lo * cnt
      true
    elsif a.hi <= lo
      @lo = @hi = a.hi + a.up
      @sum = hi * cnt
      true
    else
      @lo += a.up
      @hi += a.up
      @sum += cnt * a.up
      true
    end
  end
end

n, q = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)
values = a.map { |v| Node.new(v) }
st = SegmentTreeBeats(Node).new(values)

INF = Int64::MAX//4

# node = Node.new(1_i64,5_i64,5_i64,15_i64)
# pp node
# node.apply(A.new(-INF,INF,100i64))
# pp node
# exit

q.times do
  cmd, l, r, b = gets.to_s.split.map(&.to_i64) + [0_i64]
  case cmd
  when 0
    a = A.new(-INF, b, 0_i64)
    st.apply(l, r, a)
  when 1
    a = A.new(b, INF, 0_i64)
    st.apply(l, r, a)
  when 2
    a = A.new(-INF, INF, b)
    st.apply(l, r, a)
  when 3
    pp! st
    ans = 0_i64
    st.query(l, r) do |node|
      ans += node.sum
    end
    pp ans
  end
  # pp! st
end
