# 抽象化Segment Tree Beats
# Segment Tree Beatsの抽象化ライブラリ。

# 使い方
# 次の関数を備えた構造体Nodeを載せて使用する。

# Node():　デフォルトコンストラクタ。
# Node(T): コンストラクタ。
# void update(Node& l, Node& r): 子の情報を元に更新する関数。
# void push(Node& l, Node& r):　子に親の情報を遅延して伝える関数。
# bool apply(U x):　作用素を作用させて、更新に成功したらtrue、失敗したらfalseを返す関数。
# Beats構造体の持つ関数は以下の通り。
# Beats(vector<T> &v):　Node構造体を初期化できる型Tの列を初期値として初期化する。
# apply(int l, int r, U x): Uを区間 [ l , r ) # に作用させる。
# query(int l, int r, const F& f): 各区間に対してf(Node &n)を行う関数。
# クエリの取得に利用する。

class SegmentTreeBeats(Node)
  getter n : Int32
  getter log : Int32
  getter v : Array(Node)

  def initialize(vc : Array(Node))
    @n = Math.pw2ceil(vc.size)
    @log = Math.ilogb(n)
    @v = Array.new(n*2) { Node.new(0) }
    vc.each_with_index do |val, i|
      v[i + n] = val
    end
    (1...n).reverse_each do |i|
      update(i)
    end
  end

  def apply(l, r, x)
    return if l == r
    l += n
    r += n
    (1..log).reverse_each do |i|
      push(l >> i) if (((l >> i) << i) != l)
      push((r - 1) >> i) if (((r >> i) << i) != l)
    end
    l2 = l
    r2 = r
    while l < r
      (apply_node(l, x); l += 1) if l.odd?
      (r -= 1; apply_node(r, x)) if r.odd?
      l >>= 1
      r >>= 1
    end
    l = l2
    r = r2
    (1..log).each do |i|
      update(l >> i) if (((l >> i) << i) != l)
      update((r - 1) >> i) if (((r >> i) << i) != r)
    end
  end

  # block付き
  def query(l, r)
    return if l == r
    l += n
    r += n

    (1..log).reverse_each do |i|
      update(l >> i) if (((l >> i) << i) != l)
      update((r - 1) >> i) if (((r >> i) << i) != r)
    end

    while l < r
      if l.odd?
        yield v[l]
        l += 1
      end
      if r.odd?
        r -= 1
        yield v[r]
      end
      l >>= 1
      r >>= 1
    end
  end

  def push(i)
    v[i].push(v[i*2 + 1], v[i*2])
  end

  def update(i)
    v[i].update(v[i*2 + 1], v[i*2])
  end

  def apply_node(i, x)
    res = v[i].apply(x)
    if i < n && res == false
      push(i)
      apply_node(i*2 + 1, x)
      apply_node(i*2, x)
      update(i)
    end
  end
end

class Node
  getter fst : Int32
  getter cnt : Int32
  getter snd : Int32
  getter lazy : Int32?
  getter sum : Int32

  def initialize(@fst)
    @sum = fst
    @cnt = 1
    @snd = -100
    @lazy = nil.as(Int32?)
  end

  def update(l, r)
    if l.fst == r.fst
      @fst = l.fst
      @cnt = l.cnt + r.cnt
      @snd = Math.max(l.snd, r.snd)
    elsif l.fst < r.fst
      @fst = r.fst
      @cnt = r.cnt
      @snd = l.fst
    else
      @fst = l.fst
      @cnt = l.cnt
      @snd = r.fst
    end
    @sum = l.sum + r.sum
  end

  def push(l, r)
    if x = lazy
      l.add(x)
      r.add(x)
      @lazy = nil.as(Int32?)
    end
  end

  def add(b)
    if a = lazy
      @lazy = Math.min(a, b)
    else
      @lazy = b
    end
  end

  def apply(a)
    if fst <= a
      true
    elsif snd < a
      @sum -= (fst - a) * cnt
      @fst = a
      true
    else
      false
    end
  end
end

a = [3, 1, 4, 1, 5, 9, 2, 6]
values = a.map { |i| Node.new(i) }
stb = SegmentTreeBeats(Node).new(values)
stb.apply(2, 6, 4)
# a = [3, 1, 4, 1, 4, 4, 2, 6]
pp! stb

ans = 0
stb.query(0, 8) do |node|
  ans += node.sum
end

pp ans
