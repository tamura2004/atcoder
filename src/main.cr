h, w = gets.to_s.split.map(&.to_i)
a = Array.new(h) do
  gets.to_s.chars
end

puts solve(h,w,a) ? "Yes" : "No"

def solve(h,w,a)
  cnt = a.flatten.tally.values

  if h.even? && w.even?
    return false unless cnt.all?(&.even?)
    cnt.sum(&.// 4) >= h * w // 4
  elsif h.odd? && w.odd?
    return false if cnt.count(&.odd?) != 1

    j = cnt.index(&.odd?).not_nil!
    cnt[j] -= 1

    cnt.sum(&.// 4) >= (h - 1) // 2 * (w - 1) // 2
  elsif h.odd? && w.even?
    return false unless cnt.all?(&.even?)
    cnt.sum(&.// 4) >= (h - 1) // 2 * w // 2
  else
    return false unless cnt.all?(&.even?)
    cnt.sum(&.// 4) >= h // 2 * (w - 1) // 2
  end
end
