def is_prime?(x)
  2.upto(Math.sqrt(x).to_i).none? do |i|
    x.divisible_by?(i)
  end
end

pp is_prime?(1000000003)
pp is_prime?(1000000007)
pp is_prime?(1000000009)