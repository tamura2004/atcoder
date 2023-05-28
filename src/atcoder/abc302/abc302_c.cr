n,m = gets.to_s.split.map(&.to_i64)
s = Array.new(n){gets.to_s}

(0...n).to_a.each_permutation do |a|
  ans = n.pred.times.all? do |i|
    query(s[a[i]],s[a[i+1]])
  end
  quit :Yes if ans
end
puts :No

def query(s,t)
  ans = s.size.times.count do |i|
    s[i] != t[i]
  end
  ans <= 1
end
