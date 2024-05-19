# bit全探索

n, m = gets.to_s.split.map(&.to_i64)
ab = Array.new(m) do
  k = gets.to_s.to_i64
  Array.new(k) do
    a, b = gets.to_s.split.map(&.to_i64)
    a -= 1
    { a, b }
  end
end

ans = (1<<n).times.any? do |x|
  m.times.all? do |i|
    ab[i].any? do |a, b|
      x.bit(a) == b
    end
  end
end

yesno ans
