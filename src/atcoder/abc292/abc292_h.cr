require "crystal/segment_tree"
alias X = Tuple(Int64, Int64)

n, b, q = gets.to_s.split.map(&.to_i64)
values = gets.to_s.split.map(&.to_i64.-(b)).map { |v| {v, v} }
st = SegmentTree(X).new(
  values,
  unit: X.new(0_i64, Int64::MIN//4),
  fx: -> (x : X, y : X) {
    X.new(x[0] + y[0], Math.max(x[1], x[0] + y[1]))
  }
)

q.times do |k|
  i, x = gets.to_s.split.map(&.to_i64)
  i -= 1
  st[i] = ({x - b, x - b})
 
  j = (0...n).bsearch do |i|
    st[..i][1] >= 0
  end

  if j.nil?
    tot = st[0..][0]
    puts (tot + b * n) / n
  else
    tot = st[..j][0]
    puts (tot + b * (j + 1)) / (j + 1)
  end
end
