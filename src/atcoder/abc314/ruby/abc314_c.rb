n, m = gets.split.map(&:to_i)
s = gets.chomp
c = gets.split.map(&:to_i).map { _1.pred }

ix = Array.new(m) { [] }
n.times do |i|
  ix[c[i]] << i
end

ans = Array.new(n, -1)
m.times do |i|
  row = ix[i]
  k = row.size
  k.times do |j|
    jj = (j + 1) % k
    ans[row[jj]] = row[j]
  end
end

puts ans.map { s[_1] }.join
