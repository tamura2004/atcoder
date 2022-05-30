# `Indexable`モジュール拡張
module Indexable(T)
  # ソート済の配列に対し*u*未満の要素数を返す
  def count_less(u : T) : Int64
    Int64.new(bsearch_index { |v| u <= v } || size)
  end

  # ソート済の配列に対し*u*以下の要素数を返す
  def count_less_or_equal(u : T) : Int64
    Int64.new(bsearch_index { |v| u < v } || size)
  end

  # ソート済の配列に対し*u*を越える要素数を返す
  def count_more(u : T) : Int64
    Int64.new(size) - count_less_or_equal(u)
  end

  # ソート済の配列に対し*u*以上の要素数を返す
  def count_more_or_equal(u : T) : Int64
    Int64.new(size) - count_less(u)
  end

  # ソート済の配列に対し、*u*以下の上限のindexを返す
  def upper_bound(u : T, eq = true) : Int32
    (bsearch_index { |v| eq ? u < v : u <= v } || size) - 1
  end

  # ソート済の配列に対し、*u*以上の下限のindexを返す
  def lower_bound(u : T, eq = true) : Int32
    bsearch_index { |v| eq ? u <= v : u < v } || size
  end

  def count_range(r : Range(T?, T?))
    lo = r.try &.begin || T::MIN
    hi = (r.try &.end || T::MAX) + (r.excludes_end? ? -1 : 0)
    count_more_or_equal(lo) - count_more(hi)
  end

  # 累積和を返す
  def cs : self
    each_with_object([T.zero]) do |v, h|
      h << h[-1] + v
    end
  end

  # 累積xor
  def csxor(head = true)
    ans = each_with_object([T.zero]) do |v, h|
      h << (h[-1] ^ v)
    end
    head ? ans : ans[1..]
  end

  # 累積最大値
  def csmax(head = true)
    ans = each_with_object([T::MIN]) do |v, h|
      h << Math.max h[-1], v
    end
    head ? ans : ans[1..]
  end

  # 累積最小値
  def csmin(head = true)
    ans = each_with_object([T::MAX]) do |v, h|
      h << Math.min h[-1], v
    end
    head ? ans : ans[1..]
  end

  # 自身が累積和の時[l, r)の区間和を求める
  def range_sum(r : Range(Int?, Int?))
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
      lt[i] + rt[i + 1]
    end.to_a
  end

  # 累積最大値を返す
  def cmax : self
    each_with_object([T.zero]) do |v, h|
      h << Math.max h[-1], v
    end
  end

  # orによる畳み込み
  # ```
  # [0b011, 0b110].or # #=> 0b111
  # ```
  def or : T
    reduce(T.zero) do |acc, b|
      acc | b
    end
  end

  # xorによる畳み込み
  # ```
  # [0b011, 0b110].xor # #=> 0b101
  # ```
  def xor : T
    reduce(T.zero) do |acc, b|
      acc ^ b
    end
  end

  # 要素が順列の時、置換の逆元。値から添え字の逆引き。
  #
  # ```
  # a = [2, 0, 1]
  # a.idx # => [1,2,0]
  # ```
  def idx
    ans = Array.new(size, -1)
    each_with_index do |v, i|
      ans[v] = i
    end
    ans
  end

  # tallyの競プロパッチ、個数の型をInt64に、省略値を0に
  #
  # ```
  # a = [1, 1, 1, 2]
  # a.tally # => { 1 => 3_i64, 2 => 1_i64 }
  # ```
  def tally
    Hash(T, Int64).new(0_i64).tap do |ans|
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
  # a = [1, 1, 200, 1]
  # a.compress # => [0,0,1,0]
  # ```
  def compress(origin = 0)
    ref = sort.uniq
    map do |v|
      ref.bsearch_index do |u|
        v <= u
      end.not_nil!
    end.map(&.+ origin)
  end

  # 接尾辞配列マクロ
  macro get_rank(i)
    rank[{{i}}]? || -1
  end

  # 接尾辞配列マクロ
  macro cost(i, k)
    { get_rank({{i}}), get_rank({{i}}+{{k}}) }
  end

  # 接尾辞配列と順位を返す
  def suffix_array
    rank = (0..size).map { |i| i == size ? -1 : self[i] }
    tmp = [-1] * (size + 1)
    sa = (0..size).map(&.itself)

    k = 1
    while k <= size
      sa.sort_by! do |i|
        cost(i, k)
      end

      tmp[sa[0]] = 0

      1.upto(size) do |i|
        tmp[sa[i]] = tmp[sa[i - 1]] + (cost(sa[i - 1], k) < cost(sa[i], k)).to_unsafe
      end

      (size + 1).times { |i| rank[i] = tmp[i] }
      k *= 2
    end

    return {sa, rank}
  end

  # 接尾辞配列を用いた検索
  def sa_contain
    sa, rank = suffix_array
    ->(t : self) do
      lo = 0
      hi = size

      while hi - lo > 1
        mid = (lo + hi) // 2
        if self[sa[mid], t.size] < t
          lo = mid
        else
          hi = mid
        end
      end

      self[sa[hi], t.size] == t
    end
  end

  # 高さ配列*lcp*と接尾辞配列*sa*,*sa*内順位*rank*を求める
  def lcp
    sa, rank = suffix_array

    h = 0
    lcp = [0] * (size + 1)

    size.times do |i|
      j = sa[rank[i] - 1]
      h -= 1 if h > 0

      while j + h < size && i + h < size
        break if self[j + h] != self[i + h]
        h += 1
      end

      lcp[rank[i] - 1] = h
    end

    return {lcp, sa, rank}
  end

  # KMP法のテーブルを作成
  def kmp
    n = size.to_i64
    dp = Array.new(n+1, -1_i64)
    j = -1_i64

    n.times do |i|
      while j >= 0 && self[i] != self[j]
        j = dp[j]
      end

      j += 1
      dp[i+1] = j
    end
    dp
  end

  # kmp最小反復
  #
  # ```
  # 3文字繰り返しなど検出
  # "abcabc".chars.kmp_report # => [1, 1, 2, 3, 3, 3, 3]
  # ```
  def kmp_repeat
    kmp.zip(0..).map{|i,j|j-i}
  end

  # 範囲外エラー時にインデックスを出力
  @[AlwaysInline]
  def [](index : Int)
    fetch(index) { raise IndexError.new("#{index} not in 0...#{size}") }
  end
end

# インデックスから値へ
struct Int
  def of(a)
    a[self]
  end
end
