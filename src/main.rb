def n(s)
x,y=s.min
s.map{|i,j|[i-x,j-y]}.to_set
end
a,b,c=(0...3).map{h,w=gets.to_s.split.map &.to_i
n((0...h).map{|y|s=gets.to_s
(0...w).map{|x|s[x]=='#'?[y,x]: nil
}}.flatten.compact.to_set)}r=(-20..20)
r.each{|x|r.each{|y|puts(:Yes)+exit if n(a.map{|i,j|[i+x,j+y]}.to_set+b)==c}}
puts :No