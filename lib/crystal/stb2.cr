class Stb2
  getter n : Int32
  getter node : Array(Int32)
  getter lazy : Array(Int32)

  def initialize(values)
    @n = Math.pw2ceil(values.size)
    @node = Array.new(n * 2, 0)
    values.each_with_index do |v, i|
      @node[n + i] = v
    end
    (1...n).reverse_each do |i|
      @node[i] = @node[i * 2] + @node[i * 2 + 1]
    end
    @lazy = Array.new(n * 2, 0)
  end

  # k番目のノードについて遅延評価を行う
  def eval(k, l, r)
    if @lazy[k] != 0
      @node[k] += @lazy[k]
      if r - l > 1
        @lazy[k * 2] += @lazy[k] // 2
        @lazy[k * 2 + 1] += @lazy[k] // 2
      end
      @lazy[k] = 0
    end
  end

  # [a, b)にxを加算
  def add(a, b, x, k = 1, l = 0, r = n)
    eval(k, l, r)
    return if b <= l || r <= a
    if a <= l && r <= b
      @lazy[k] += (r - l) * x
      eval(k, l, r)
    else
      add(a, b, x, k * 2, l, (l + r) // 2)
      add(a, b, x, k * 2 + 1, (l + r) // 2, r)
      @node[k] = @node[k * 2] + @node[k * 2 + 1]
    end
  end

  # [a, b)の合計を求める
  def sum(a, b, k = 1, l = 0, r = n)
    eval(k, l, r)
    return 0 if b <= l || r <= a
    return @node[k] if a <= l && r <= b
    vl = sum(a, b, k * 2, l, (l + r) // 2)
    vr = sum(a, b, k * 2 + 1, (l + r) // 2, r)
    return vl + vr
  end

  def debug
    puts "== node =="
    (0..2).each do |h|
      lo = 1 << h
      hi = 1 << (h + 1)
      puts node[lo...hi].join(" ")
    end
    puts "== lazy =="
    (0..2).each do |h|
      lo = 1 << h
      hi = 1 << (h + 1)
      puts lazy[lo...hi].join(" ")
    end
  end
end
