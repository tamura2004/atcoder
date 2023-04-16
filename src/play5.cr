require "crystal/st"
require "crystal/cc"
require "crystal/mod_int"
require "crystal/square_matrix"

class CCST(K, V)
  getter st : ST(V)
  getter cc : CC(K)

  def initialize(keys : Array(K), fxx : V, V -> V)
    @cc = CC(K).new(keys)
    values = Array.new(cc.size, nil.as(V?))
    @st = ST(V).new(values, fxx)
  end

  def []=(i, v)
    st[cc[i].not_nil!] = v
  end

  def [](r)
    lo = r.begin
    hi = r.end
    st[cc[lo].not_nil!...cc[hi].not_nil!]
  end
end

A = SquareMatrix(ModInt).new("1 1;1 0")
B = SquareMatrix(ModInt).new("0 0;1 0")

n, q = gets.to_s.split.map(&.to_i)
keys = [] of Int64

qs = Array.new(q) do
  cmd, x, y = gets.to_s.split.map(&.to_i64) + [0_i64]
  case cmd
  when 1
    keys << x
    keys << x + 1
  when 2
    keys << x + 1
    keys << x
    keys << y + 1
    keys << y
  else
    raise "bad"
  end
  {cmd, x, y}
end

keys.sort!.uniq!

alias K = Int64
alias V = SquareMatrix(ModInt)

ccst = CCST(K, V).new(keys, ->(x : V, y : V) { y * x })
keys.each_cons_pair do |lo, hi|
  ccst[lo] = A ** (hi - lo)
end

cnt = keys.to_set

qs.each do |cmd,x,y|
  case cmd
  when 1
    if x.in?(cnt)
      cnt.delete(x)
      ccst[x] = B
    else
      cnt << x
      ccst[x] = A
    end
  when 2
    # pp! cnt
    # pp! [x,y]
    if x.in?(cnt) && y.in?(cnt)
      pp ccst[x+1...y+1][0,0]
    else
      pp 0
    end
  end
end