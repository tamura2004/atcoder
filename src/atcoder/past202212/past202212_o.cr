require "crystal/lst"

# 10進数d桁を左ローテートy
# # x = 12345
# # left_rotate(x, 5, 2) # => 34512
PW10 = Array.new(10) do |i|
  10_i64 ** i
end

def left_rotate(x, d, y)
  y %= d
  x // PW10[d - y] + x % PW10[d - y] * PW10[y]
end

n, d = gets.to_s.split.map(&.to_i64)
single_values = gets.to_s.split.map(&.to_i64)

all_values = single_values.map do |x|
  (0...d).map do |i|
    left_rotate(x, d, i)
  end
end

alias X = Array(Int64)
alias A = Int64

st = LST(X, A).new(
  values: all_values,
  fxx: ->(x : X, y : X) { x.zip(y).map { |z, w| z ^ w } },
  fxa: ->(x : X, a : A) { x.rotate(a) },
  faa: ->(a : A, b : A) { a + b },
)

q = gets.to_s.to_i64
offset = 0_i64
q.times do |i|
    cmd, lo, hi, y = gets.to_s.split.map(&.to_i64) + [0_i64, 0_i64]
    case cmd
    when 1
      offset += lo
      offset %= n
    when 2
      lo = (lo.pred + offset) % n
      hi = (hi.pred + offset) % n
      if lo <= hi
        st[lo..hi] = y
      else
        st[..hi] = y
        st[lo..] = y
      end
    when 3
      lo = (lo.pred + offset) % n
      hi = (hi.pred + offset) % n
      if lo <= hi
        pp st[lo..hi][0]
      else
        pp st[..hi][0] ^ st[lo..][0]
      end
    end
end
