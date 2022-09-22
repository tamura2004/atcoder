require "crystal/mod_int"

enum Mech
  Comp
  Power
end

n = gets.to_s.to_i
comps = Array.new(n) { {gets.to_s.to_i64,Mech::Comp} }
powers = Array.new(n) { {gets.to_s.to_i64,Mech::Power} }
mechs = (comps + powers).sort

ans = 1.to_m
lefts = [] of Mech

mechs.each do |i, mech|
  if lefts.empty? || lefts[-1] == mech
    lefts << mech
  else
    ans *= lefts.size
    lefts.pop
  end
end

pp ans