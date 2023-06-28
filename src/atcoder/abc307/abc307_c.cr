def n(s)
x,y=s.min
s.map{|i,j|{i-x,j-y}}.to_set
end
a,b,c=(1..3).map{h,w=gets.to_s.split.map &.to_i
n((1..h).flat_map{|y|s=gets.to_s
(0...w).compact_map{|x|s[x]<'.'?{y,x}: nil
}})}r=-20..20
puts r.any?{|x|r.any?{|y|n(a.map{|i,j|{i+x,j+y}}.to_set+b)==c}}?:Yes: :No