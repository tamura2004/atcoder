require "crystal/multi_set"

M = 300_000_i64

def to_ix(a, b)
  M * a + b
end

def to_pair(ix)
  {ix // M, ix % M}
end

h, w = gets.to_s.split.map(&.to_i)
ab = Array.new(h) { gets.to_s.split.map(&.to_i64.- 1) }

pairs = MultiSet.new
moves = MultiSet.new

w.times do |x|
  pairs << to_ix(x, x)
  moves << 0_i64
end

(1..h).each do |y|
  lo, hi = ab[y-1]
  hi += 1
  left = to_ix(lo, 0)
  right = to_ix(hi, M.to_i)
  part, pairs = pairs.split(left..right)
  part.each do |ix|
    a, b = to_pair(ix)
    moves.delete(a - b)
  end

  if part.size > 0
    a, b = to_pair(part.max)
    if hi < w
      pairs << to_ix(hi, b)
      moves << hi - b
    end
  end

  if moves.size == 0
    puts -1
  else
    puts moves.min + y
  end
end
