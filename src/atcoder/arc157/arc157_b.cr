# Yを1文字も含まない場合
# k - 1が答え
# xの連続数、両端にYを持つか、で集計、小さい順にソート

n, k = gets.to_s.split.map(&.to_i)
s = gets.to_s

quit k - 1 if s.count('Y').zero?

q = Deque.new s.split(/Y+/).map(&.size)

both = [] of Int32
side = [] of Int32

if q[0] != 0
  q.unshift -1
end

if q[-1] != 0
  q << -1
end

q.each_cons(3) do |ser|
  if ser[0] == -1 || ser[2] == -1
    side << ser[1]
  else
    both << ser[1]
  end
end

side.sort!.reverse!
both.sort!.reverse!
ans = 0_i64

while k > 0 && (side.size > 0 || both.size > 0)
  if both.size > 0
    if both[-1] <= k
      k -= both[-1]
      ans += both[-1] + 1
      both.pop
    else
      ans += k
      k = 0
    end
  else
    if side[-1] <= k
      k -= side[-1]
      ans += side[-1]
      side.pop
    else
      ans += k
      k = 0
    end
  end
end

pp ans

