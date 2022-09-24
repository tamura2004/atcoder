require "crystal/mod_int"
require "crystal/fact_table"

n = gets.to_s.to_i
s = gets.to_s.chars

quit 0 if s[0] == 'W'
quit 0 if s[-1] == 'W'

t = [0]
(1...n*2).each do |i|
  if s[i] == s[i-1]
    t << 1 - t[-1]
  else
    t << t[-1]
  end
end

quit 0 if t[-1] == 0
quit 0 if t.count(0) != n

ans = 1.to_m
cnt = [t[0]]
(1...n*2).each do |i|
  if cnt.empty?
    if t[i] == 1
      quit 0
    else
      cnt << t[i]
    end
  elsif t[i] == 0
    cnt << t[i]
  else
    ans *= cnt.size
    cnt.pop
  end
end

pp ans * n.f

