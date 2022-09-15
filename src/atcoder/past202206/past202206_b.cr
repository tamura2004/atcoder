s = gets.to_s
cnt = [] of String

n = s.size
(0...n-1).each do |i|
  cnt << s[i,2]
end

cnt.sort!
cs = cnt.tally
max = cs.values.max

cnt.each do |s|
  if cs[s] == max
    quit s
  end
end
