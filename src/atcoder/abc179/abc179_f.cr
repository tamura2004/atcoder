require "crystal/dual_segment_tree"

n, q = gets.to_s.split.map(&.to_i64)

yoko = DualSegmentTree(Int64).range_assign([n - 1]*n)
tate = DualSegmentTree(Int64).range_assign([n - 1]*n)
x_stop = n - 1
y_stop = n - 1
ans = (n - 2) ** 2

q.times do
  cmd, v = gets.to_s.split.map(&.to_i64)
  v -= 1

  case cmd
  when 1
    y = yoko[v]
    ans -= y - 1

    if v < x_stop
      x_stop = v
      tate[1...y] = v
    end
  when 2
    x = tate[v]
    ans -= x - 1

    if v < y_stop
      y_stop = v
      yoko[1...x] = v
    end
  end
end

pp ans
