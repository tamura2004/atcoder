n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64).sort.reverse
g = Array.new(n){ gets.to_s.chars }.transpose.map{|a|cont(a)}.sort.reverse

def cont(a)
  ans = 0
  cnt = 0
  a.each do |c|
    if c == 'X'
      cnt += 1
      ans = Math.max ans, cnt
    else
      cnt = 0
    end
  end
  ans
end

ans = g.zip(a).all?{|i,j| i <= j}
puts ans ? :YES : :NO