require "crystal/mod_int"
ModInt.mod = 200

n = gets.to_s.to_i
chmin n, 8
a = gets.to_s.split.map(&.to_i64.to_m)

ans = Array.new(200, -1)

(1 << n).times do |s|
  next if s.zero?
  cnt = 0.to_m
  n.times do |i|
    next if s.bit(i) == 0
    cnt += a[i]
  end

  if ans[cnt.to_i64] != -1
    puts "Yes"
    puts show(ans[cnt.to_i64], n)
    puts show(s, n)
    exit
  end

  ans[cnt.to_i64] = s
end

puts "No"

def show(s, n)
  ans = [] of Int32
  ans << s.popcount
  n.times do |i|
    next if s.bit(i) == 0
    ans << i + 1
  end
  ans.join(" ")
end
