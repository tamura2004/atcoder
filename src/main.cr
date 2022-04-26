require "crystal/avl_tree"

q = Deque(Int64).new
tr = OrderedSet(Int64).new

n = gets.to_s.to_i64
n.times do
  line = gets.to_s
  case line
  when /^1/
    _, x = line.split.map(&.to_i64)
    q << x
  when /^2/
    if tr.size.zero?
      pp q.shift
    else
      pp tr.min
      tr.delete(tr.min.not_nil!)
    end
  when /^3/
    while q.size > 0
      tr << q.shift
    end
  end
end
