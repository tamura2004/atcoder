n,t = gets.to_s.split.map(&.to_i64)
c = gets.to_s.split.map(&.to_i64)
r = gets.to_s.split.map(&.to_i64)

if t.in?(c)
  ans = (0...n).max_by do |i|
    c[i] == t ? r[i] : Int64::MIN
  end
  puts ans.succ
else
  ans = (0...n).max_by do |i|
    c[i] == c[0] ? r[i] : Int64::MIN
  end
  puts ans.succ
end
