require "crystal/segment_tree"
require "crystal/cc"

n = gets.to_s.to_i64
box = Array.new(n) do
  x, y, z = gets.to_s.split.map(&.to_i64).sort
  {x,y,z}
end.sort
ys = box.map(&.[1])

box = box.group_by(&.first)

cc = CC(Int64).new(keys: ys)

# pp! box

st = 200_001.to_st_min

box.each do |k, v|
  v.each do |x,y,z|
    if st[...cc[y]] < z
      quit :Yes
    end
  end
  v.each do |x,y,z|
    chmin st[cc[y]], z 
  end
end

puts :No
