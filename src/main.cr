class SegmentTree(T)
  getter n : Int32
  getter f : T?, T? -> T?
  getter node : Array(T?)

  def initialize(n : T)
    initialize(n) { |a, b| a < b ? a : b }
  end

  def initialize(v : Array(T?))
    initialize(v) { |a, b| a < b ? a : b }
  end

  def initialize(_n : Int32, &block : T, T -> T)
    @f = ->(a : T?, b : T?) {
      a && b ? block.call(a,b) : a ? a : b ? b : nil
    }

    @n = ceil_pow2(_n)
    @node = Array(T?).new(2 * n - 1, nil)
  end

  def initialize(v : Array(T?), &block : T, T -> T)
    @f = ->(a : T?, b : T?) {
      a && b ? block.call(a,b) : a ? a : b ? b : nil
    }

    @n = ceil_pow2(v.size)
    @node = Array(T?).new(2 * n - 1, nil)

    v.size.times do |i|
      node[i + n - 1] = v[i]
    end

    (n - 2).downto(0) do |i|
      node[i] = f.call(node[2*i + 1], node[2*i + 2])
    end
  end

  def update(i, _x)
    x : T? = _x.is_a?(T) ? _x : _x.nil? ? _x : T.new(_x)
    i += n - 1
    node[i] = x
    while i > 0
      i = (i - 1) // 2
      node[i] = f.call(node[2*i + 1], node[2*i + 2])
    end
  end

  def []=(i, x)
    update(i, x)
  end

  def get(a : Int, b : Int, k = 0, lo = 0, hi = -1) : T?
    hi = n if hi < 0
    case
    when hi <= a || b <= lo then nil
    when a <= lo && hi <= b then node[k]
    else
      vlo = get(a, b, 2*k + 1, lo, (lo + hi)//2)
      vhi = get(a, b, 2*k + 2, (lo + hi)//2, hi)
      f.call(vlo, vhi)
    end
  end

  def [](r : Range(Int, Int))
    a = r.begin
    b = r.end + (r.exclusive? ? 0 : 1)
    get(a, b)
  end

  def [](i : Int)
    node[i + n - 1]
  end

  def to_a
    node[n-1..]
  end

  private def ceil_pow2(n)
    1 << Math.log2(n).ceil.to_i
  end
  
  delegate call, to: f
end

n,q = gets.to_s.split.map { |v| v.to_i }
a = gets.to_s.split.map { |v| v.to_i64 }
st = SegmentTree(Int64).new(a) do |x,y|
  Math.max(x,y)
end

q.times do
  t,x,y = gets.to_s.split.map { |v| v.to_i }
  case t
  when 1
    st[x-1] = y
  when 2
    puts st[(x-1)..(y-1)]
  when 3
    ans = ((x-1)..(n-1)).bsearch do |i|
      y <= (st[(x-1)..i] || Int64::MAX)
    end
    if ans 
      puts ans + 1
    else
      puts n + 1
    end
  end
end

# a = [1,6,2,5,3,4]
# st = SegmentTree(Int32).new(a)
# pp! st[0]
# pp! st[1]
# pp! st[2]
# st[3] = 4
# st[2] = 1
# pp! st[2..3]
# pp! st[2]
# pp! st[3]
