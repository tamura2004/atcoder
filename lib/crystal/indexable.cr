# `Indexable`モジュール拡張
module Indexable(T)

  # ソート済の配列に対し*u*未満の要素数を返す
  def count_less(u : T) : Int32
    bsearch_index do |v|
      u <= v
    end || size
  end

  # ソート済の配列に対し*u*以下の要素数を返す
  def count_less_or_equal(u : T) : Int32
    bsearch_index do |v|
      u < v
    end || size
  end

  # ソート済の配列に対し*u*を越える要素数を返す
  def count_more(u : T) : Int32
    size - count_less_or_equal(u)
  end

  # ソート済の配列に対し*u*以上の要素数を返す
  def count_more_or_equal(u : T) : Int32
    size - count_less(u)
  end

  # 累積和を返す
  def cs : self
    each_with_object([T.zero]) do |v, h|
      h << h[-1] + v
    end
  end

  # 自身が累積和の時[l, r)の区間和を求める
  def range_sum(r : Range(Int?,Int?))
    lo = r.begin || 0
    lo = Math.max lo, 0
    hi = (r.end || size - 1) + (r.excludes_end? ? 0 : 1)
    hi = Math.min hi, size - 1
    self[hi] - self[lo]
  end

  # 右からの累積和を返す
  def csr : self
    reverse.cs.reverse
  end

  # インデックス位置を除く両側の累積和を返す
  def csb : self
    lt = cs
    rt = csr
    size.times.map do |i|
      lt[i] + rt[i+1]
    end.to_a
  end

  # 累積最大値を返す
  def cmax : self
    each_with_object([T.zero]) do |v,h|
      h << Math.max h[-1], v
    end
  end

  # orによる畳み込み
  # ```
  # [0b011,0b110].or # #=> 0b111
  # ```
  def or : T
    reduce(T.zero) do |acc,b|
      acc | b
    end
  end

  # 要素が順列の時、置換の逆元。値から添え字の逆引き。
  #
  # ```
  # a = [2,0,1]
  # a.idx # => [1,2,0]
  # ```
  def idx
    ans = Array.new(size,-1)
    each_with_index do |v,i|
      ans[v] = i
    end
    ans
  end

  # tallyの競プロパッチ、個数の型をInt64に、省略値を0に
  #
  # ```
  # a = [1,1,1,2]
  # a.tally # => { 1 => 3_i64, 2 => 1_i64 }
  # ```
  def tally
    Hash(T,Int64).new(0_i64).tap do |ans|
      each do |v|
        ans[v] += 1
      end
    end
  end

  # 座標圧縮,0-origin
  #
  # NOTE:
  #
  # ```
  # a = [1,1,200,1]
  # a.compress # => [0,0,1,0]
  # ```
  def compress
    ref = sort.uniq
    map do |v|
      ref.bsearch_index do |u|
        v <= u
      end.not_nil!
    end
  end
end

# インデックスから値へ
struct Int
  def of(a)
    a[self]
  end
end