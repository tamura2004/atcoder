INF = Int64::MAX

n = gets.to_s.to_i
c = Array.new(n){ gets.to_s.split.map(&.to_i64) }

if n == 1
  puts "Yes"
  puts c[0][0]
  puts c[0][0]
  exit
end

a = c[0]
b = [0_i64]
1.upto(n-1) do |i|
  cnt = INF
  n.times do |j|
    if cnt != INF && cnt != c[i][j] - a[j]
      puts "No"
      exit
    else
      cnt = c[i][j] - a[j]
    end
  end
  b << cnt
end

if a.min + b.min < 0
  puts "No"
  exit
else
  if a.min < 0
    puts "Yes"
    cnt = a.min
    puts b.map(&.+ cnt).join(" ")
    puts a.map(&.- cnt).join(" ")
  else
    puts "Yes"
    cnt = b.min
    puts b.map(&.- cnt).join(" ")
    puts a.map(&.+ cnt).join(" ")
  end
end
