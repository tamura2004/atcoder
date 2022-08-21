n, m = gets.to_s.split.map(&.to_i64)
xyz = Array.new(n) do
  x,y,z = gets.to_s.split.map(&.to_i64)
  {x,y,z}
end

def dot(a,b)
  3.times.sum do |i|
    a[i] * b[i]
  end
end

d = [1,-1]
ans = Array.product(d,d,d).max_of do |a|
  xyz.map{|b| dot(b,a)}.sort.last(m).sum
end

pp ans