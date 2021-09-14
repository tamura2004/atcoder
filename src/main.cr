def get_cnt
  Array.new(10) do |i|
    cnt = 0
    while i > 5
      i = (i * 2) % 10
      cnt += 1
    end
    cnt
  end
end

cnt = get_cnt

def solve(a, cnt)
  a.map{|v|cnt[v]}.max
end

h, w = gets.to_s.split.map(&.to_i)
n = Math.max(h, w)
a = Array.new(h){ gets.to_s.split.map(&.to_i) }.flatten

if a.all?(&.zero?)
  puts "Yes 0"
elsif a.includes?(5)
  if h == 1 || w == 1
    ans = Int32::MAX
    n.times do |i|
      next if a[i] != 5
      chmin ans, solve(a[..i],cnt) + solve(a[i..],cnt) + 1
    end
    puts "Yes #{ans}"
  else
    ans = solve(a, cnt) + 1
    puts "Yes #{ans}"
  end
else
  puts "No"
end
