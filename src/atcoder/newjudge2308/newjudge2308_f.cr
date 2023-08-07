require "crystal/graph"

s, t, m = gets.to_s.split.map(&.to_i)
g = (s + t).to_g

m.times do
  v, nv = gets.to_s.split.map(&.to_i)
  g.add v, nv, both: false
end

dp = make_array(-1, t, t)

s.times do |v|
  g.each(v) do |x|
    g.each(v) do |y|
      next if x == y
      z = dp[y - s][x - s]
      if z == -1
        dp[y - s][x - s] = v
      else
        quit "#{v.succ} #{x.succ} #{y.succ} #{z.succ}"
      end
    end
  end
end
puts -1
