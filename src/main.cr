require "crystal/bit_set"

macro chmin(target, other)
  {{target}} = ({{other}}) if ({{target}}) > ({{other}})
end

n,a,b,c = gets.to_s.split.map(&.to_i64)
l = Array.new(n){ gets.to_s.to_i64 }

f = Proc(Int64,Int64,Int64).new do |s,a|
  (s.bits.map(&.of l).sum - a).abs + (s.popcount - 1) * 10
end

ans = Int64::MAX
0.inv(n).subsets.each do |s|
  s.inv(n).proper_subsets.each do |t|
    (s|t).inv(n).subsets.each do |u|
      # pp! [s,t,u]
      chmin ans, f.call(s,a) + f.call(t,b) + f.call(u,c)
    end
  end
end

pp ans
