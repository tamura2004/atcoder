# a = Set{1,2,3}
# b = Set{2,3}

# pp b.subset?(a)
# pp b.proper_subset?(a)

n, m = gets.to_s.split.map(&.to_i)
ps = [] of Int32
cs = [] of Int32
fs = [] of Set(Int32)

n.times do |i|
  line = gets.to_s.split.map(&.to_i)
  ps << line.shift
  cs << line.shift
  fs << line.to_set
end

n.times do |i|
  n.times do |j|
    if ps[i] > ps[j] && fs[i].subset?(fs[j])
      quit :Yes
    end

    if ps[i] >= ps[j] && fs[i].proper_subset?(fs[j])
      quit :Yes
    end
  end
end
puts :No
