class SegTree
  attr_reader :size
  attr_accessor :seg

  def self.create(a=[])
    n = 1
    n *= 2 while n < a.size
    this = new(n)
    a.size.times do |i|
      this.seg[i + n] = a[i]
    end
    (n-1).downto(1) do |i|
      this.seg[i] = this.seg[i*2] & this.seg[i*2+1]
    end
    this
  end

  def initialize(n=2**100_000)
    @size = n
    @seg = Array.new(size*2, 0)
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
      seg[i] = seg[i*2] & seg[i*2+1]
    end
  end

  def query(a,b)
    ans = 0xffff_ffff
    a += size; b += size
    while a < b
      (ans &= seg[a]; a += 1) if a.odd?
      (b -= 1; ans &= seg[b]) if b.odd?
      a /= 2; b /= 2
    end
    ans
  end

  def inspect
    { size: size, seg: seg }.to_s
  end
end

# SegTree.new(N)
# := 要素数Nで初期化、ただしNは2の冪
# SegTree.create(A)
# := 配列Aで初期化
# update(i,x) := Aiをxに更新
# query(a,b) := 半開区間[a,b)での演算結果

S = gets.chomp.chars.map{|c| 1 << c.ord - ?a.ord}
N = S.size
T = SegTree.create(S)

N.times do |i|
  if T.query(0,N-i) != 0
    puts i
    exit
  end

  (N-i-1).times do |j|
    T.update(j, T[j] | S[j+i+1])
  end
end
