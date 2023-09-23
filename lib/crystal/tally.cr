# tallyの競プロパッチ
# Arrayのみパッチ
# 個数の型をInt32 -> Int64に
# デフォルトの省略値を0_i64に
class Array(T)
  def tally
    Hash(T | Int64 | Int32, Int64).new(0_i64).tap do |hash|
      each do |value|
        hash[value] += 1
      end
    end
  end
end
