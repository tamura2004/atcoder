module Indexable(T)
  def match(other : self, offset : Int32 | Int64)
    other.each_with_index.all? do |element, i|
      self[i + offset] == element
    end
  end
end

n, m = gets.to_s.split.map(&.to_i64)
s = gets.to_s.chars
t = gets.to_s.chars

patterns = [] of Array(Char)
m.times do |left|
  (left...m).each do |right|
    wrk = ['#'] * m
    wrk[left..right] = t[left..right]
    patterns << wrk
  end
end

seen = Array.new(n, false)
i = 0

while i + m <= n
  case
  when seen[i]
    i += 1
  when patterns.any?{|pat| s.match(pat, i)}
    seen[i] = true
    s.fill('#', i, m)
    i -= m - 1
    chmax i, 0
  else
    i += 1
  end
end

puts s.all?(&.== '#') ? :Yes : :No
