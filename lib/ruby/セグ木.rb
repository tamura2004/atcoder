class SegTree
  def initialize(n,v,f);@n=1;@n*=2 while @n<n;@s=Array.new(@n*2-1,v);@f=f;end
  def update(i,x);i+=@n-1;@s[i]=x;(i=(i-1)/2;@s[i]=@f[@s[i*2+1],@s[i*2+2]])while i>0;end
end

SegTree.new(4,0,->x,y{x+y}).instance_eval do
  update(0,8)
  update(1,1)
  update(2,2)
  update(3,4)
  p @s
end
