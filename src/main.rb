n,t,m=gets.split.map &:to_i
a=x=1
c=[x]
(1..t).each{|i|
j=t+1-i
x*=j
x/=i
c<<x%m
}
n.times{
i,j=gets.split.map &:to_i
[(i+j).abs,(i-j).abs].each{|x|
(t-x).odd?||t<x&&p(0)+exit
a*=c[(t-x)/2]
a%=m
}
}
p a