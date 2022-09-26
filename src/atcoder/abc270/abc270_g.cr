# x = a ^ k
# x = b/((a-1)*s+b)
# a ^ k = b/((a-1)*s+b) (mod p)

require "crystal/baby_step_giant_step"

t = gets.to_s.to_i
t.times do
  p,a,b,s,g = gets.to_s.split.map(&.to_i64)
  BabyStepGiantStep.solve(a,)