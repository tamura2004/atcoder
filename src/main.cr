require "crystal/treap_merge_split"

alias Pair = Tuple(Int64,Int64)

h, w = gets.to_s.split.map(&.to_i64)
ab = Array.new(h) { gets.to_s.split.map(&.to_i64.- 1) }

pairs = Treap(Pair).new
moves = Treap(Int64).new

w.times do |x|
  pairs << { x, x }
  moves << 0_i64
end

(1..h).each do |y|
  lo, hi = ab[y-1]
  hi += 1
  left = { lo, 0_i64 }
  right = { hi, Int64::MAX }

  part, pairs = pairs.split(left..right)
  part.each do |(a,b)|
    moves.delete(a - b)
  end

  if part.size > 0
    a, b = part.max.not_nil!
    if hi < w
      pairs << { hi, b }
      moves << hi - b
    end
  end

  if moves.size == 0
    puts -1
  else
    puts moves.min.not_nil! + y
  end
end
