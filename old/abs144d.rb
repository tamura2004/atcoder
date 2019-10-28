A,B,X = gets.split.map(&:to_f)

BASE = (A * B) / 2
S = X / A

x, y = nil, nil

if S < BASE
    x = S * 2 / B
    y = B
else
    x = A
    y = (A * B - S) * 2 / A
end

puts Math.atan2(y,x) * 180 / Math::PI