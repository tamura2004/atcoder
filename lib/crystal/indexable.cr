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

  # 右からの累積和を返す
  def csr : self
    reverse.cs.reverse
  end

  # インデックス位置を除く両端の累積和を返す
  def csb : self
    lt = cs
    rt = csr
    size.times.map do |i|
      lt[i] + rt[i+1]
    end.to_a
  end

  # orによる畳み込み
  def or : T
    reduce(T.zero) do |acc,b|
      acc | b
    end
  end

  # 値->indexの配列
  def idx
    ans = Array.new(size,-1)
    each_with_index do |v,i|
      ans[v] = i
    end
    ans
  end
end
