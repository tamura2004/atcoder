require "crystal/mod_int"
require "crystal/tr"

# |a b|
# |c d|
record Matrix, a : ModInt, b : ModInt, c : ModInt, d : ModInt do
  def *(x : self)
    Matrix.new(a * x.a + b * x.c, a * x.b + b * x.d, c * x.a + d * x.c, c * x.b + d * x.d)
  end

  def **(k : Int)
    ans = Matrix.new(1.to_m, 0.to_m, 0.to_m, 1.to_m)
    tot = self
    while k > 0
      if k.odd?
        ans *= tot
      end
      tot *= tot
      k >>= 1
    end
    ans
  end
end

n, q = gets.to_s.split.map(&.to_i64)
qs = Array.new(q) do
  cmd, x, y = gets.to_s.split.map(&.to_i64) + [0_i64]
  {cmd, x, y}
end

xs = [] of Int64
qs.each do |cmd, x, y|
  case cmd
  when 1
    xs << x
    xs << x + 1
  when 2
    xs << x
    xs << y
  end
end

A = Matrix.new(1.to_m, 1.to_m, 1.to_m, 0.to_m)
B = Matrix.new(0.to_m, 0.to_m, 1.to_m, 0.to_m)

alias T = Matrix
values = [] of T
ref = xs.sort.uniq
ref.each_cons_pair do |lo, hi|
  values << A ** (hi - lo)
end

k = values.size
st = TR(T).new(
  values: values,
  fxx: ->(x : T, y : T) { x * y }
)

cnt = Array.new(ref.size, 1)

qs.each do |cmd, x, y|
  case cmd
  when 1
    i = ref.bsearch_index { |v| v >= x } || k
    cnt[i] ^= 1
    if cnt[i] == 1
      st[i] = A
    else
      st[i] = B
    end
  when 2
    i = ref.bsearch_index { |v| v >= x } || k
    j = ref.bsearch_index { |v| v >= y } || k

    if cnt[i].zero? || cnt[j].zero?
      puts 0
    else
      puts st[i...j].a
    end
  end
end
