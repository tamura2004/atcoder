n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)

cnt = [] of Int64
num = [] of Int64
ans = 0_i64

n.times do |i|
  if num.empty? || num[-1] != a[i]
    num << a[i]
    cnt << 1_i64
    ans += 1
  else
    cnt[-1] += 1
    ans += 1
    if cnt[-1] == num[-1]
      ans -= cnt[-1]
      cnt.pop
      num.pop
    end
  end

  pp ans
end
