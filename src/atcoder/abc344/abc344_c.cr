n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)

m = gets.to_s.to_i64
b = gets.to_s.split.map(&.to_i64)

l = gets.to_s.to_i64
c = gets.to_s.split.map(&.to_i64)

cnt = Set(Int64).new

n.times do |i|
  m.times do |j|
    l.times do |k|
      cnt << a[i] + b[j] + c[k]
    end
  end
end

q = gets.to_s.to_i64
x = gets.to_s.split.map(&.to_i64)

ans = x.map do |v|
  if cnt.includes?(v)
    :Yes
  else
    :No
  end
end

puts ans.join("\n")

