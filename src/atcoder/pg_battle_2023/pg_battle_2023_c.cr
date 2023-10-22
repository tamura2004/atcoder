require "big"

a = gets.to_s.to_big_i
b = gets.to_s.to_big_i(2)

ans = case
when a > b then ">"
when a == b then "="
when a < b then "<"
end

puts ans
