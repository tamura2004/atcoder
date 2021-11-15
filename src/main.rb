n = gets.to_i

cnt = 0
ans = 0
(1..n).map do |a|
  break if n < a * a * a
  (a..n).map do |b|
    break if n < a * b * b
    c = n / (a * b) - (b - 1)
    cnt += 1
    ans += c
  end
end

pp cnt
pp ans
