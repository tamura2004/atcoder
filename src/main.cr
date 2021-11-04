n = gets.to_s.to_i
s = gets.to_s.chars.map(&.ord.- 'A'.ord)
t = gets.to_s.chars.map(&.ord.- 'A'.ord)
puts conv(s) == conv(t) ? "Yes" : "No"

def conv(a)
  q = Deque.new([] of Int32)

  a.each do |v|
    q << v
    next if q.size < 3

    case {q[-3], q[-2], q[-1]}
    when {0, 1, 2}, {1, 2, 0}, {2, 0, 1}
      q.pop(3)
    end
  end

  q
end
