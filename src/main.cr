class SegmentTree(T)
  getter n : Int32
  getter f : T?, T? -> T?
  getter node : Array(T?)

  def initialize(v)
    initialize(v) { |a, b| a < b ? a : b }
  end

  def initialize(v, &block : T, T -> T)
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

  def update(i, x)
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

  def get(a : Int32, b : Int32, k = 0, lo = 0, hi = -1) : T?
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

  def [](r : Range(Int32, Int32))
    a = r.begin
    b = r.end + (r.exclusive? ? 0 : 1)
    get(a, b)
  end

  private def ceil_pow2(n)
    1 << Math.log2(n).ceil.to_i
  end

  delegate call, to: f
end

class Problem
  getter n : Int32
  getter a : Array(Int32)
  getter g : SegmentTree(Int32)
  
  def initialize
    @n = gets.to_s.to_i
    @a = gets.to_s.chars.map { |c| char2bit(c) }
    @g = SegmentTree(Int32).new(@a) do |a,b|
      a | b
    end
  end

  def solve
    q = gets.to_s.to_i
    q.times do
      ope, i, j = gets.to_s.chomp.split
      case ope
      when "1"
        i = i.to_i - 1
        g[i] = char2bit(j[0])
      when "2"
        i = i.to_i - 1
        j = j.to_i - 1
        puts g[i..j].not_nil!.popcount
      end
    end
  end

  def show(ans)
  end

  def instance_eval
    with self yield
  end

  private def char2bit(c)
    1 << (c.ord - 'a'.ord)
  end
end

Problem.new.instance_eval do
  show(solve)
end