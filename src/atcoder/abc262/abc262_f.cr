# 辞書順は貪欲？
n, k = gets.to_s.split.map(&.to_i)
a = gets.to_s.split.map(&.to_i.pred)
idx = a.zip(0..).sort.map(&.last)

ans = [n] * n

n.times do |i|
  next if k < idx[i] && k < n - idx[i]
  if idx[i] <= k
    chmin ans, del(a, idx[i], k)
  end

  if n - idx[i] <= k
    chmin ans, rot(a, idx[i], k)
  end

  quit ans.map(&.succ).join(" ")
end

def del(a, i, k)
  n = a.size
  k -= i
  ans = [] of Int32
  (i...n).each do |j|
    if ans.empty?
      ans << a[j]
    else
      while ans.size > 0 && ans[-1] > a[j] && k > 0
        ans.pop
        k -= 1
      end
      ans << a[j]
    end
  end
  while ans.size > 1 && k > 0
    ans.pop
    k -= 1
  end
  ans
end

def rot(a, i, k)
  n = a.size
  ans = [] of Int32
  (i...n).each do |j|
    if ans.empty?
      ans << a[j]
    else
      while ans.size > 0 && ans[-1] > a[j]
        ans.pop
      end
      ans << a[j]
    end
  end

  k -= n - i

  ans1 = [] of Int32
  (0...i).each do |j|
    if ans1.empty?
      ans1 << a[j]
    else
      while ans1.size > 0 && ans1[-1] > a[j] && k > 0
        ans1.pop
        k -= 1
      end
      ans1 << a[j]
    end
  end

  # pp! ans[-1]
  while ans.size > 1 && (ans1.empty? || ans[-1] > ans1[0])
    ans.pop
  end

  ans + ans1
end
