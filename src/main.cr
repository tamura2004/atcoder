require "big"
n,t,m=gets.to_s.split.map &.to_i
a=w=1.to_big_i
c=[w]
(1..t).map{|i|
w*=t+1-i
w//=i
c<<w%m
}
n.times{
i,j=gets.to_s.split.map &.to_i
x=(i+j).abs
y=(i-j).abs
[x,y].map{|x|
(t-x).odd?||t<x&&p(0)+exit
a*=c[(t-x)//2]
a%=m
}}
pp a
