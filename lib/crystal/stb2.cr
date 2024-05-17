record X, fst : Int64, snd : Int64, cnt : Int64, sum : Int64, fail : Bool do
  # 加法の単位元
  def self.zero
    new Int64::MIN, Int64::MIN, 0_i64, 0_i64, false
  end

  def +(other : self): self
    if fst == other.fst
      X.new fst, Math.max(snd, other.snd), cnt + other.cnt, sum + other.sum, false
    elsif fst > other.fst
      X.new fst, Math.max(snd, other.fst), cnt, sum + other.sum, false
    else
      X.new other.fst, Math.max(fst, other.snd), other.cnt, sum + other.sum, false
    end
  end

  def *(other : A): self
    if fst <= other.val
      self
    elsif snd < other.val
      X.new other.val, snd, cnt, sum - cnt * (fst - other.val), false
    else
      # 失敗。更新値には意味がない。子の遅延評価を行い、再度評価する
      X.new fst, snd, cnt, sum, true
    end
  end
end

record A, val : Int64 do
  # 加法の単位元
  def self.zero
    new 0_i64
  end

  def +(other : self): self
    A.new val + other.val
  end
end

class Stb2
  getter n : Int32
  getter node : Array(X)
  getter lazy : Array(A)

  def initialize(values)
    @n = Math.pw2ceil(values.size)
    @node = Array.new(n * 2, X.zero)
    values.each_with_index do |v, i|
      @node[n + i] = X.new v, Int64::MIN, 1_i64, v, false
    end
    (1...n).reverse_each do |i|
      @node[i] = @node[i * 2] + @node[i * 2 + 1]
    end
    @lazy = Array.new(n * 2, A.zero)
  end

  # k番目のノードについて遅延評価を行う
  def eval(k, l, r)
    if @lazy[k] != A.zero
      @node[k] *= @lazy[k]
      # 葉ノード(r - l == 1)でなければ子に伝搬
      if r - l > 1
        @lazy[k * 2] += @lazy[k]
        @lazy[k * 2 + 1] += @lazy[k]

        # 更に実は失敗していたら子の遅延評価をしてから親を更新する
        eval(k * 2, l, (l + r) // 2)
        eval(k * 2 + 1, (l + r) // 2, r)
        @node[k] = @node[k * 2] + @node[k * 2 + 1]
      end
      @lazy[k] = A.zero
    end
  end

  # [a, b)にxを加算
  def add(a, b, x, k = 1, l = 0, r = n)
    eval(k, l, r)
    return if b <= l || r <= a
    if a <= l && r <= b
      @lazy[k] += x
      eval(k, l, r)
    else
      mid = (l + r) // 2
      add(a, b, x, k * 2, l, mid)
      add(a, b, x, k * 2 + 1, mid, r)
      @node[k] = @node[k * 2] + @node[k * 2 + 1]
    end
  end

  def []=(r : Range(Int::Primitive?, Int::Primitive?), x : Int64)
    lo = r.begin || 0
    hi = r.end.try(&.+(1 - r.excludes_end?.to_unsafe)) || n
    add(lo, hi, A.new(x))
  end

  # [a, b)の合計を求める
  def sum(a, b, k = 1, l = 0, r = n)
    eval(k, l, r)
    return X.zero if b <= l || r <= a
    return @node[k] if a <= l && r <= b
    mid = (l + r) // 2
    vl = sum(a, b, k * 2, l, mid)
    vr = sum(a, b, k * 2 + 1, mid, r)
    return vl + vr
  end

  def [](r : Range(Int::Primitive?, Int::Primitive?)): Int64
    lo = r.begin || 0
    hi = r.end.try(&.+(1 - r.excludes_end?.to_unsafe)) || n
    sum(lo, hi).sum
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
