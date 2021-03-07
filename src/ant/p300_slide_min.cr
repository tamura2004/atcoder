n = 5
k = 3
a = [5,1,3,4,2]

min = slide(a, k) do |x,y|
  x >= y
end

max = slide(a, k) do |x,y|
  x <= y
end

pp min
pp max

def slide(a,m)
  ans = [] of typeof(a.first)
  q = Deque(Int32).new
  a.each_with_index do |v,i|
    while q.size > 0 && yield a[q.last], v
      q.pop 
    end
    q << i

    if i + 1 >= 3
      ans << a[q.first]
    end
    q.shift if q.first == i - m + 1
  end
  ans
end