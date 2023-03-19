require "crystal/indexable"
require "crystal/string/suffix_array"

# 文字列アルゴリズム
class String

  # 文字コードの配列から文字列に変換
  def self.from(a)
    a.map(&.chr).join
  end

  # 文字コードの配列に変換
  def to_a
    chars.map(&.ord)
  end

  # 接尾辞配列*sa*と順位*rank*を返す
  def suffix_array
    to_a.suffix_array
  end

  # 接尾辞配列を用いた文字列検索
  def sa_contain
    f = to_a.sa_contain
    ->(t : String) do
      f.call(t.to_a)
    end
  end

  # 高さ配列*lcp*と接尾辞配列*sa*,*sa*内順位*rank*を求める
  def lcp
    to_a.lcp
  end
end
