require "crystal/avl_tree"

alias LO = Int64
alias HI = Int64
alias SEG = Tuple(HI, LO)

scores = OrderedSet(Int64).new
segs = OrderedSet(SEG).new

h, w = gets.to_s.split.map(&.to_i64)
ab = Array.new(h) do
  a, b = gets.to_s.split.map(&.to_i64.pred)
  {a, b}
end

# 最上段の初期状態
w.times do |i|
  segs << {i, i}
  scores << 0
end

h.times do |i|
  a, b = ab[i]

  segs.lower({b + 1, LO::MAX}).try do |head|
    head_hi, head_lo = head
    next if head_hi < a

    while inner = segs.lower(head, eq: false)
      inner_hi, inner_lo = inner
      break if inner_hi < a
      segs.delete(inner)
      scores.delete(inner_hi - inner_lo)
    end

    segs.delete(head)
    scores.delete(head_hi - head_lo)

    if b + 1 != w
      segs << {b + 1, head_lo}
      scores << b + 1 - head_lo
    end
  end

  pp scores.min.try &.+(i + 1) || -1
end
