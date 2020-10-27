macro chmin(target, other)
  {{target}} = ({{other}}) if ({{target}}) > ({{other}})
end

n = gets.to_s.to_i
a = gets.to_s.split.map { |v| v.to_i64 }
b = gets.to_s.split.map { |v| v.to_i64 }

cnt = 0_i64
ans = Int64::MAX
n.times do |i|
  cnt += a[i]
  if b[i] <= cnt
    chmin ans, b[i]
  end
end
puts ans == Int64::MAX ? -1 : ans