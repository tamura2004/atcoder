require "crystal/modint9"
s = gets.to_s
n = s.size
m = divceil(n, 2)

ans = 1.to_m
m.times do |i|
  j = n - 1 - i
  if s[i] == '?' && s[j] == '?'
    ans *= 26
  elsif s[i] == '?' || s[j] == '?'
    ans *= 1
  elsif s[i] == s[j]
    ans *= 1
  else
    quit 0
  end
end

pp ans