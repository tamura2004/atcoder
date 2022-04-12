require "crystal/matrix"

n = gets.to_s.to_i64
vs = Array.new(n) do
  x, y = gets.to_s.split.map(&.to_i64)
  [x, y, 1_i64]
end

mt = Matrix(Int64).eye(3)

def r90
  Matrix(Int64).new([
    [0, 1, 0],
    [-1, 0, 0],
    [0, 0, 1],
  ])
end

def l90
  Matrix(Int64).new([
    [0, 1, 0],
    [-1, 0, 0],
    [0, 0, 1],
  ])
end

def flip_v(p)
  Matrix(Int64).new([
    [-1, 0, p*2],
    [0, 1, 0],
    [0, 0, 1],
  ])
end

def flip_h(p)
  Matrix(Int64).new([
    [1, 0, 0],
    [0, -1, p*2],
    [0, 0, 1],
  ])
end

m = gets.to_s.to_i64
op = Array.new(m) { gets.to_s }

q = gets.to_s.to_i64
qu = Array.new(q) { Tuple(Int32, Int32).from gets.to_s.split.map(&.to_i.pred) }.zip(0..).sort.reverse
ans = Array.new(q, "")

while qu.size > 0 && qu[-1][0][0] == -1
  v, i = qu.pop
  a, b = v
  ans[i] = vs[b][0..1].join(" ")
end

m.times do |i|
  case op[i]
  when /^1/
    mt *= r90
  when /^2/
    mt *= l90
  when /^3/
    _, p = op[i].split.map(&.to_i64)
    mt *= flip_v(p)
  when /^4/
    _, p = op[i].split.map(&.to_i64)
    mt *= flip_h(p)
  end

  while qu.size > 0 && qu[-1][0][0] == i
    v, j = qu.pop
    a, b = v
    ans[j] = (mt * vs[b])[0..1].join(" ")
  end
end

puts ans.join("\n")
