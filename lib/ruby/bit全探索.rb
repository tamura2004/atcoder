# 全探索パターン
N = 4
(1<<N).times do |bit|
  ans = []
  N.times do |i|
    next if bit >> i & 1 == 0
    ans << i
  end
  p ans
end

# 補助
# [offset, offset + n)の連番の配列を生成
def iota(n,offset=0); n.times.map{|i|i+offset}; end

# bitマスクに対応した位置で配列の要素を取り出す
# numo/narrayでは標準で対応
class Array
  def mask(bit)
    select.with_index do |_, i|
      bit >> i & 1 == 1
    end
  end
end
