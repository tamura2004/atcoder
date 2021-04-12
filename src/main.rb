def g(n, k)
  (n / k).to_i * (1 + n / k).to_i * k / 2
end

def f(n)
  1.upto(n).sum do |k|
    g(n, k)
  end
end

n = gets.to_s.to_i
pp f(n)
