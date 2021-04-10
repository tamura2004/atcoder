require "crystal/lazy_segment_tree"

# o o o x
# o o o x
# o o o x
# x x x x
#
# o x o x
# o x o x
# o x o x
# x x x x
#
# o x o x
# x x o x
# o x o x
# x x x x

# range update range min

n,q = gets.to_s.split.map(&.to_i)
alias X = Int32
a = Array.new(n-1,n-2)
tate = LazySegmentTree(X,X).range_update_range_min(a)
yoko = LazySegmentTree(X,X).range_update_range_min(a)
ans = (n - 2).to_i64 ** 2

q.times do |m|
  cmd,x = gets.to_s.split.map(&.to_i)
  x -= 2
  case cmd
  when 1
    j = tate[x..x, Int32::MAX]
    ans -= j
    yoko[..j] = x
    tate[x] = 0
  when 2
    j = yoko[x..x, Int32::MAX]
    ans -= j
    tate[..j] = x
    yoko[x] = 0
  end
end

pp ans