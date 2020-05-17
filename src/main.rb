class Work
  attr_accessor :id,:forward
  def initialize(id,from,to,forward=true)
    @id = id
    @from = from
    @to = to
    @forward = forward
  end
  
  def from; forward ? @from : @to; end
  def to; forward ? @to : @from; end
end

n,k,c = gets.split.map(&:to_i)
s = gets.chomp.chars
works = []
s.chars.each_with_index do |ox,i|
  next if ox == "x"
  works << Work.new(i+1, i, i+c )



a = []
s.each_with_index do |s,i|
  if s == "o"
    a << [i,i+c]
  end
end

a.sort_by!{|a|a[1]}

F = []
pre = -10**12
a.each_with_index do |(x,y),i|
  if pre < x
    F << i
    pre = y
  end
end

B = []
pre = 10**12
a.sort!
(a.size-1).downto(0) do |i|
  x,y = a[i]
  if pre > y
    B << i
    pre = x
  end
end
F.sort!
B.sort!
F.zip(B).each do |x,y|
  if x == y
    puts a[x][0] + 1
  end
end

    
