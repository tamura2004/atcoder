class BIT
  def initialize(n);@n=n;@a=Array.new(n+1,0);end
  def add(i,x);(@a[i]+=x;i+=i&-i) while i<=@n;end
  def sum(i);c=0;(c+=@a[i];i-=i&-i) while i>0;c;end
  def greater(i);sum(@n)-sum(i);end
  def inv(a);c=0;a.each{|x|add(x,1);c+=greater(x)};c;end
end

# BIT.new(n) := 長さnで初期化
# sum(i) := 閉区間[0,i]の合計
# add(i,x) := 要素iにxを加える
# greater(i) := 半開区間(i,n]の合計
# inv(a) := aの転倒数

# [4,1,3,2]の転倒数:=4を求める
# BIT.new(10).instance_eval do
#   c = inv([4,1,3,2])
#   p c
# end
