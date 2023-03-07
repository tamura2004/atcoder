require "crystal/fps"

def read
  gets.to_s.split.map(&.to_i64).to_fps * FPS.new([0,1])
end

a = read
b = read
c = read
ans = a * b * c

(1..18).each do |i|
  puts ans[i].to_i64 / 1000000
end

