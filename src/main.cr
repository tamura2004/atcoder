# 置換群
class PermutationGroup
  getter a : Array(Int32)
  getter inv : Array(Int32)

  def initialize(@a)
    n = a.size
    @inv = Array.new(n, -1)
    n.times do |i|
      inv[a[i]] = i
    end
  end

  def swap(i,j)
    inv.swap a[i],a[j]
    a.swap i,j
  end

  # 不動点
  def fixed?(i)
    a[i] == i
  end

  def value
    ({a,inv})
  end
end

alias PG = PermutationGroup

n = gets.to_s.to_i
a = gets.to_s.split.map { |v| v.to_i }
b = gets.to_s.split.map { |v| v.to_i }
p = gets.to_s.split.map { |v| v.to_i - 1 }

pg = PG.new(p)

flag = n.times.any? do |i|
  !pg.fixed?(i) && a[i] <= b[pg.a[i]]
end

if flag
  puts -1
  exit
end

ans = [] of Tuple(Int32,Int32)
a.zip(0..).sort.each do |w,i|
  next if pg.fixed?(i)
  j = pg.inv[i]
  pg.swap(i,j)
  ans << {i,j}
end

puts ans.size
ans.each do |i,j|
  puts "#{i+1} #{j+1}"
end