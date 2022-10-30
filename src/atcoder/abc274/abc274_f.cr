# 三分探索してみる
n, a = gets.to_s.split.map(&.to_i64)
wxv = Array.new(n) do
  w,x,v = gets.to_s.split.map(&.to_i64)
  {w,x,v}
end

