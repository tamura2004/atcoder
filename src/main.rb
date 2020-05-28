h,w,d = gets.split.map(&:to_i)
a = Array.new(h*w+1)
h.times do |y|
  gets.split.map(&:to_i).each_with_index do |v,x|
    a[v] = [y,x]
  end
end

q = gets.to_i
q.times do
  start, goal = gets.split.map(&:to_i)
  ans = 0
  while start != goal
    to = start + d
    y,x = a[start]
    ny,nx = a[to]
    dist = (ny-y).abs + (nx-x).abs
    ans += dist
    start = to
  end
  puts ans
end
