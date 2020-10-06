require "prime"

12.times do |i|
  x = "1#{'0'*i}1".to_i
  pp x
  pp Prime.prime_division(x)
end
