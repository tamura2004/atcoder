<<<<<<< HEAD
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
=======
n, m = gets.split.map(&:to_i)

# mod[i][j] := jがi個並んだ数字をmで割った余り
mod = Array.new(n + 1) { Array.new(11, 0) }
11.times do |j|
  (1..n).each do |i|
    mod[i][j] = (mod[i - 1][j] * 10 + j) % m
  end
end

(1..n).reverse_each do |i|
  (1..9).reverse_each do |j|
    if mod[i][j] == 0
      puts j.to_s * i
      exit
    end
  end
end
puts -1
>>>>>>> a60674153b1209a7ebb072393d7a99c64df8b0a8
