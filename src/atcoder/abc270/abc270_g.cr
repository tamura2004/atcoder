require "crystal/dynamic_mod_int"
require "crystal/number_theory/baby_step_giant_step"

include NumberTheory

t = gets.to_s.to_i
t.times do
  p, a, b, s, g = gets.to_s.split.map(&.to_i64)
  p.to_mod

  case
  when g == s
    pp! "a"
    pp 0
  when a == 0 # s b b b b b
    pp! "b"
    pp g == b ? 1 : -1
  when a == 1 && b == 0 # s s s s s
    pp! "c"
    pp -1
  when a == 1 # s s+b s+2b
    pp! "d"
    pp (g.to_m - s) // b
  else
    pp! "e"
    # xi+1 = a xi + b
    # yi = xi - b/(1-a)
    # yi+1 = xi+1 - b/(1-a) = axi+b - b/(1-a)
    # a xi + b(1-a)/(1-a) - b/(1-a)
    # a xi + -ba/(1-a)
    # a (xi - b/(1-a)) = a yi
    # yi = s a^i
    # xi = s a^i + b/(1-a) == g
    # a^i == (g - b/(1-a))//s
    y = (g.to_m - b.to_m // (1.to_m - a)) // s
    pp BabyStepGiantStep.solve(a, y, p)
  end
end
