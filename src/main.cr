a, b = gets.to_s.split.map(&.to_i64)

(b - a).downto(1) do |i|
  if (b // i) - ((a - 1) // i) >= 2
    p(i) + exit
  end
end
