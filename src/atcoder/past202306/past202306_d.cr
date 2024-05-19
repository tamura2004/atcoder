require "crystal/neko_set"

a,b,c,d,r = gets.to_s.split.map(&.to_i64)
ns = NekoSet.new

# 時刻0の処理
ns.st << { a, a + r }

d.step(by: d, to: c + r) do |t|
  if b <= t
    (Math.max(c, t)..c+r).each do |j|
      ns << j
    end
  end
end

ans = (c..c + r).all? do |i|
  ns.includes?(i)
end

yesno ans