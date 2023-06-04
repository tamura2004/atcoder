# 抽象化Segment Tree Beats
# Segment Tree Beatsの抽象化ライブラリ。

# 使い方
# 次の関数を備えた構造体Nodeを載せて使用する。

# Node():　デフォルトコンストラクタ。
# Node(T): コンストラクタ。
# initialize(v : T) Node構造体を型Tの値で初期化
# update(l : Node, r : Node) : Nil 子の情報を元に更新する関数。
# push(l : Node, r : Node) : Nil　子に親の情報を遅延して伝える関数。
# apply(x : U) : Bool　作用素を作用させて、更新に成功したらtrue、失敗したらfalseを返す関数。
# Beats構造体の持つ関数は以下の通り。
# initialize(v : Array(T)):　Node構造体を初期化できる型Tの列を初期値として初期化する。
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
    @v = Array.new(n*2) { Node.zero }
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
