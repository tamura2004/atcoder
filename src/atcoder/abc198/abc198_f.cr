# /* maximaで前計算 */
# display2d:false$
# linel:200$
# f0: 1/(1-x)^6$
# f1: 6/(1-x)^2/(1-x^4)$
# f2: 3/(1-x)^2/(1-x^2)^2$
# f3: 8/(1-x^3)^2$
# f4: 6/(1-x^2)^3$
# f: rat((f0 + f1 + f2 + f3 + f4)/24)$
# disp(f)$

require "crystal/boston_mori"

n = gets.to_s.to_i64
bunshi = "3*x^6+x^5+x^4+1"
bunbo = "x^15-x^14-2*x^13+2*x^11+4*x^10-x^9-3*x^8-3*x^7-x^6+4*x^5+2*x^4-2*x^2-x+1"
ans = BostonMori.new(bunshi,bunbo).solve(n - 6)
pp ans