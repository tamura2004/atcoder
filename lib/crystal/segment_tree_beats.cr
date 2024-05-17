# 抽象化Segment Tree Beats
# Segment Tree Beatsの抽象化ライブラリ。
#
# 使い方
# モノイドX, 作用Aを構造体として定義する。
#
# X + Y : XとYをマージしたモノイドを返す関数。
# X.zero : Xの単位元を返す関数。
# X.new(v : Int64) : Int64の値vで初期化されたXを返す関数。
# X.fail : Xが失敗しているかどうかを返す関数。
#
# A + A : 作用の合成
# A.zero : Aの単位元を返す関数。
# A.new(v : Int64) : Int64の値vで初期化されたAを返す関数。
#
# X * A : XにAを作用させた結果を返す関数。
class SegmentTreeBeats(X, A)
  getter n : Int32
  getter node : Array(X)
  getter lazy : Array(A)

  def initialize(values)
    @n = Math.pw2ceil(values.size)
    @node = Array.new(n * 2, X.zero)
    values.each_with_index do |v, i|
      @node[n + i] = X.new v
    end
    (1...n).reverse_each do |i|
      @node[i] = @node[i * 2] + @node[i * 2 + 1]
    end
    @lazy = Array.new(n * 2, A.zero)
  end

  # k番目のノードについて遅延評価を行う
  def eval(k, l, r)
    if @lazy[k] != A.zero
      @node[k] *= @lazy[k] # X * A -> X に A を作用させる
      # 葉ノード(r - l == 1)でなければ子に伝搬
      if r - l > 1
        @lazy[k * 2] += @lazy[k]
        @lazy[k * 2 + 1] += @lazy[k]

        # 更に実は失敗していたら子の遅延評価をしてから親を更新する
        if @node[k].fail
          eval(k * 2, l, (l + r) // 2)
          eval(k * 2 + 1, (l + r) // 2, r)
          @node[k] = @node[k * 2] + @node[k * 2 + 1]
        end
      end
      @lazy[k] = A.zero
    end
  end

  # [a, b)にxを加算
  def upply(a, b, x, k = 1, l = 0, r = n)
    eval(k, l, r)
    return if b <= l || r <= a
    if a <= l && r <= b
      @lazy[k] += x # Aでの加算
      eval(k, l, r)
    else
      mid = (l + r) // 2
      upply(a, b, x, k * 2, l, mid)
      upply(a, b, x, k * 2 + 1, mid, r)
      @node[k] = @node[k * 2] + @node[k * 2 + 1]
    end
  end

  def []=(r : Range(Int::Primitive?, Int::Primitive?), x : Int64)
    lo = r.begin || 0
    hi = r.end.try(&.+(1 - r.excludes_end?.to_unsafe)) || n
    upply(lo, hi, A.new(x))
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

  def [](r : Range(Int::Primitive?, Int::Primitive?)) : Int64
    lo = r.begin || 0
    hi = r.end.try(&.+(1 - r.excludes_end?.to_unsafe)) || n
    sum(lo, hi).sum
  end
end
