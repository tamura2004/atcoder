class SegTree
  attr_reader :size, :e, :f
  attr_accessor :seg

  def self.create(a=[],e,f)
    n = 1
    n *= 2 while n < a.size
    this = new(n,e,f)
    a.size.times do |i|
      this.seg[i+n] = a[i]
    end
    (n-1).downto(1) do |i|
      this.seg[i] = f[ this.seg[i*2],this.seg[i*2+1] ]
    end
    this
  end

  def initialize(n=2**32,e,f)
    @size = n
    @e = e
    @f = f
    @seg = Array.new(size*2, e)
  end

  def [](i)
    i += size
    seg[i]
  end

  def update(i,x)
    i += size
    seg[i] = x
    while i > 1
      i /= 2
      seg[i] = f[ seg[i*2], seg[i*2+1] ]
    end
  end

  def query(a,b)
    ans = e
    a += size; b += size
    while a < b
      (ans = f[ ans, seg[a] ]; a += 1) if a.odd?
      (b -= 1; ans = f[ ans, seg[b] ]) if b.odd?
      a /= 2; b /= 2
    end
    ans
  end

  def inspect
    { size: size, seg: seg }.to_s
  end
end

# SegTree.new(N,E,F) := 要素数N、単位元E、演算Fで初期化、ただしNは2の冪
# SegTree.create(A,E,F) := モノイドA、単位元E、演算Fで初期化で初期化
# update(i,x) := A[i]をxに更新
# query(a,b) := 半開区間[a,b)でのA[i]の演算結果
#
# 単位元を追加してモノイドにする例（gcd）
# E = -1
# F = -> x,y { x == E ? y : y == E ? x : x.gcd(y) }
# T = SegTree.create(a,E,F)

class Syakutori
  attr_reader :a, :n, :lo, :hi, :ans, :xs, :cx
  F = -> x,y { x > y ? x : y }
  
  def initialize(n, a)
    @cnt = SegTree.new(2**18, 0, F)
    @a = a
    @n = n
    @lo = 0
    @hi = 0
    @ans = 0
    yield self
  end

  def move_hi
    i = @a[hi]
    @cnt.update(i, @cnt[i] + 1)
    @hi += 1
  end
  
  def move_lo
    i = a[lo]
    @cnt.update(i, @cnt[i] - 1)
    @lo += 1
  end

  def update
    # pp [lo,hi,hi-lo]
    @ans = hi - lo if @ans < hi - lo
  end

  def valid?
    @cnt.query(1,100_000) < 2

  end

  def solve_hi
    while hi < n
      move_hi
      move_lo until valid?
      update
    end
    return @ans
  end

  def solve_lo
    while lo < n
      move_hi while valid?
      update
      move_lo
    end
    return @ans
  end
end

n = gets.to_s.to_i
a = gets.to_s.split.map { |v| v.to_i }

Syakutori.new(n, a) do |s|
  puts s.solve_hi
end
