require "crystal/st"

def merge(a, b)
  c0 = c1 = c2 = c3 = 0_i64

  if a[0] == b[0]
    c0 = a[0]
    c1 = a[1] + b[1]
    if a[2] == b[2]
      c2 = a[2]
      c3 = a[3] + b[3]
    elsif a[2] > b[2]
      c2 = a[2]
      c3 = a[3]
    else
      c2 = b[2]
      c3 = b[3]
    end
  elsif a[0] > b[0]
    c0 = a[0]
    c1 = a[1]
    if a[2] == b[0]
      c2 = a[2]
      c3 = a[3] + b[1]
    elsif a[2] > b[0]
      c2 = a[2]
      c3 = a[3]
    else
      c2 = b[0]
      c3 = b[1]
    end
  else
    c0 = b[0]
    c1 = b[1]
    if a[0] == b[2]
      c2 = a[0]
      c3 = a[1] + b[3]
    elsif a[0] > b[2]
      c2 = a[0]
      c3 = a[1]
    else
      c2 = b[2]
      c3 = b[3]
    end
  end

  {c0, c1, c2, c3}
end


n, q = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64).map do |v|
  { v, 1_i64, Int64::MIN, 1_i64 }
end

st = ST.new(a) do |x, y|
  merge(x, y)
end

q.times do
  cmd, lo, hi = gets.to_s.split.map(&.to_i64)
  case cmd
  when 1
    i = lo.pred
    st[i] = { hi, 1_i64, Int64::MIN, 1_i64 }
  when 2
    lo -= 1
    hi -= 1
    cnt = st[lo..hi]
    # pp! cnt
    if cnt[2] == Int64::MIN
      pp 0
    else
      pp cnt[3]
    end
  end
end


