require "crystal/mod_int"
require "crystal/square_matrix"
require "crystal/coodinate_compress_segment_tree"

A = SquareMatrix(ModInt).new("1 1;1 0")
B = SquareMatrix(ModInt).new("0 0;1 0")

n, q = gets.to_s.split.map(&.to_i)
keys = [] of Int64
qs = [] of Tuple(Int64, Int64, Int64)
q.times do
  cmd, x, y = gets.to_s.split.map(&.to_i64) + [0_i64]
  x -= 1
  y -= 1
  qs << {cmd, x, y}
  case cmd
  when 1
    keys << x
    keys << x.pred
  when 2
    keys << x
    keys << y
  end
end

keys.sort!.uniq!
cnt = keys.to_set

st = CCST(Int64, SquareMatrix(ModInt)?).new(
  keys: keys,
  unit: nil.as(SquareMatrix(ModInt)?)
) do |x, y|
  x && y ? y * x : x ? x : y ? y : nil
end

keys.each_cons_pair do |lo, hi|
  st[lo] = A ** (hi - lo)
end


qs.each do |cmd,x,y|
  case cmd
  when 1
    if x.in?(cnt)
      cnt.delete(x)
      st[x.pred] = B
    else
      cnt << x
      st[x.pred] = A
    end
  when 2
    if x.in?(cnt) && y.in?(cnt)
      pp st[x...y] #.not_nil![0,0]
      puts keys.map{|i|st[i]}
      pp [x,y]
      pp! st[0...2]
      pp! st[0...3]
      pp! st[x...y]
      pp! st.a[2]
      pp! st.a[6]
      pp! st.a[12]
      pp! st.a[13]
      pp! st[3...6]
    else
      pp 0
    end
  end
end

puts (A**3)*A*B*A