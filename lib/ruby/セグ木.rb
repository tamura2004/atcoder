class SegTree
  class Seg
    attr_accessor :val
    def self.[](val)
      new(val)
    end
    def initialize(val)
      @val = val
    end
    def +(other)
      val | other.val
    end
    def inspect
      val.to_s
    end
  end

  attr_reader :size
  attr_accessor :tree
  def initialize(a=[], e=0)
    @size = 1
    @size *= 2 while @size < a.size
    @tree = Array.new(size*2, e)
    a.size.times do |i|
      tree[i + size] = Seg[a[i]]
    end
    (size-1).downto(1) do |i|
      tree[i] = tree[i*2] + tree[i*2+1]
    end
  end

  def update(i,x)
    i += size
    tree[i] = Seg[x]
    while i > 1
      i /= 2
      tree[i] = tree[i*2] + tree[i*2+1]
    end
  end

  def query(a,b)
  end

  def inspect
    { size: size, tree: tree }.to_s
  end
end

# SegmentTree.new(A,e,f)
# := 配列A、単位源e、演算fで初期化

t = SegTree.new([1,2,4,8])
t.update(3,16)
p t
