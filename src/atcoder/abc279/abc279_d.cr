# 三分探索

a, b = gets.to_s.split.map(&.to_i64)
lo = 0_i64
hi = a
left = 0_i64
right = 0_i64

calc = ->(g : Int64) {
  a / Math.sqrt(g + 1) + g.to_f64 * b
}

# 4.times do |g|
#   pp calc.call(g.to_i64)
# end

300.times do
  left = (lo * 2 + hi) // 3
  right = (lo + hi * 2) // 3
  
  if calc.call(left) < calc.call(right)
    hi = right
  else
    lo = left
  end
end

ans = [
  calc.call(lo),
  calc.call(left),
  calc.call(right),
  calc.call(hi)
]

puts ans.min
