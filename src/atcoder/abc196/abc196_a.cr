def f(n)
  (n.to_s * 2).to_i64
end

n = gets.to_s.to_i64
lo = 0_i64
hi = 1e7.to_i64

ans = (lo..hi).bsearch do |x|
  n < f(x)
end

pp ans.not_nil! - 1