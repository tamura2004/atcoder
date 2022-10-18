def f(x)
  if x.zero?
    1_i64
  else
    x * f(x - 1)
  end
end

n = gets.to_s.to_i64
pp f(n)