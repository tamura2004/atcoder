class BIT
  property :a, :n
  def initialize(@n : Int32); @a = Array(Int32).new(n + 1, 0); end
  def add(i, x); return if n < i; a[i] += x; add(i + lsb(i), x); end
  def sum(i); return 0 if i <= 0; a[i] + sum(i - lsb(i)); end
  def lsb(i); i & -i; end
end
# BIT.new(n) := 長さnで初期化
# sum(i) := 閉区間[0,i]の合計
# add(i,x) := 要素iにxを加える
