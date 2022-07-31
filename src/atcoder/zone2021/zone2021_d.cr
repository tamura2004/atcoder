s = gets.to_s.chars
rev = false
q = Deque(Char).new

s.each do |c|
  case c
  when 'R'
    rev = !rev
  else
    if q.empty?
      q << c
    elsif rev
      if q[0] == c
        q.shift
      else
        q.unshift c
      end
    else
      if q[-1] == c
        q.pop
      else
        q << c
      end
    end
  end
end

ans = q.to_a.join
ans = ans.reverse if rev
puts ans