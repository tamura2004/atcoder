class SegmentTree(T)
  getter n : Int32
  getter unit : T
  getter xs : Array(T)
  getter fx : Proc(T, T, T)

  def initialize(n : Int32, unit : T = T.zero, &fx : Proc(T, T, T))
    values = Array.new(n) { unit }
    initialize(values, unit, fx)
  end

  def initialize(values : Array(T), unit : T = T.zero, &fx : Proc(T, T, T))
    initialize(values, unit, fx)
  end

  def initialize(
    values : Array(T),
    @unit : T = T.zero,
    @fx : Proc(T, T, T) = Proc(T, T, T).new { |x, y| x + y }
  )
    @n = Math.pw2ceil(values.size)
    @xs = Array(T).new(n*2, unit)

    values.each_with_index do |v, i|
      xs[i + n] = v
    end

    (n - 1).downto(1) do |i|
      xs[i] = fx.call xs[i << 1], xs[i << 1 | 1]
    end
  end

  def set(i : Int32, v : T)
    raise "Bad index i=#{i}" unless (0...n).includes?(i)

    i += n
    xs[i] = v
    while i > 1
      i >>= 1
      xs[i] = fx.call xs[i << 1], xs[i << 1 | 1]
    end
  end

  def []=(i : Int32, v : T)
    set(i, v)
  end

  def get(i : Int32) : T
    xs[i + n]
  end

  def [](i : Int32) : T
    get(i)
  end

  def sum(i : Int32, j : Int32) : T
    i += n; j += n
    left = right = unit
    while i < j
      if i.odd?
        left = fx.call left, xs[i]
        i += 1
      end

      if j.odd?
        j -= 1
        right = fx.call xs[j], right
      end
      i >>= 1; j >>= 1
    end

    fx.call(left, right)
  end

  def [](r : Range(Int32?, Int32?)) : T
    lo = r.begin || 0
    hi = (r.end || n - 1) + (r.excludes_end? ? 0 : 1)
    sum(lo, hi)
  end

  def pp
    puts "========"
    i = 1
    while i <= n
      sep = " " * ((n * 2) // i - 1)
      puts xs[i...(i << 1)].join(sep)
      i <<= 1
    end
    puts "--------"
  end
end

class Graph
  getter n : Int32
  getter a : Array(Int32)
  getter ans : Array(Int32)
  getter g : Array(Array(Int32))
  getter dp : SegmentTree(Int32)

  def self.read
    n = gets.to_s.to_i
    _a = gets.to_s.split.map { |v| v.to_i }
    a = compress(_a)
    g = Array.new(n){ [] of Int32 }
    (n-1).times do
      i,j = gets.to_s.split.map { |v| v.to_i - 1 }
      g[i] << j
      g[j] << i
    end
    new(n,a,g)
  end

  def initialize(@n, @a, @g)
    @dp = SegmentTree(Int32).new(n) do |x, y|
      Math.max x, y
    end
    @ans = Array.new(n, -1)
  end

  def dfs(v,pv)
    j = a[v]
    old = dp[j]
    dp[j] = dp[...j] + 1
    ans[v] = dp[0..]
    g[v].each do |nv|
      next if nv == pv
      dfs(nv,v)
    end
    dp[j] = old
  end

  def solve
    dfs(0, -1)
    ans
  end

  def self.compress(src)
    ref = src.sort.uniq
    src.map do |v|
      ref.bsearch_index do |u|
        v <= u
      end.not_nil!
    end
  end
end

puts Graph.read.solve.join("\n")
