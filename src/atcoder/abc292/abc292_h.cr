require "crystal/lazy_segment_tree"

alias X = Tuple(Int32, Float64)
alias A = Float64

n, b, q = gets.to_s.split.map(&.to_i)

fxx = Proc(X, X, X).new do |(i, x), (j, y)|
  pp! [i,x,j,y]
  x,y = y,x unless i < j
  i,j = j,i unless i < j
  z = b <= x ? x : Math.max(x,y)
  X.new(Math.min(i, j), z)
end

fxa = Proc(X, A, X).new { |(i, x), a| X.new(i, x + a / i) }
faa = Proc(A, A, A).new { |a, b| a + b }

values = Array.new(n) do |i|
  X.new(i+1, 0.0_f64)
end

# 区間平均加算、区間最大
st = LazySegmentTree(X, A).new(
  values,
  fxx,
  fxa,
  faa,
  X.new(Int32::MAX, 0.0_f64),
  A.zero
)

a = gets.to_s.split.map(&.to_i64)
sum = a.sum

n.times do |i|
  st[i..] = a[i].to_f64
end

q.times do
  i, x = gets.to_s.split.map(&.to_i64)
  i -= 1

  st[i...] = (x - a[i]).to_f64

  sum -= a[i]
  sum += x
  a[i] = x

  if b <= st[0..][1]
    puts st[0..][1]
  else
    puts sum / n
  end

  5.times do |i|
    pp st[i]
  end
  pp st[0..]
  pp st.fold(0,n)
end

