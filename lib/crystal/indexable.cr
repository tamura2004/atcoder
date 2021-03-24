# `Indexable`モジュール拡張
module Indexable

  # ソート済の配列に対し*u*未満の要素数を返す
  def count_less(u)
    bsearch_index do |v|
      u <= v
    end || size
  end

  # ソート済の配列に対し*u*以下の要素数を返す
  def count_less_or_equal(u)
    bsearch_index do |v|
      u < v
    end || size
  end

  # ソート済の配列に対し*u*を越える要素数を返す
  def count_greater(u)
    cnt = bsearch_index do |v|
      u < v
    end || size
    size - cnt
  end

  # ソート済の配列に対し*u*以上の要素数を返す
  def count_greater_or_equal(u)
    cnt = bsearch_index do |v|
      u <= v
    end || size
    size - cnt
  end
end
