# キューに入れて全カウント
k = gets.to_s.to_i64

q = Deque.new((1..9).map { |i| [i] })
while k > 1
  k -= 1
  arr = q.shift
  (0...arr[-1]).each do |i|
    q << arr + [i]
  end
end

puts q.first.join
