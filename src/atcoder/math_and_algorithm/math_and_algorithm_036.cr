require "crystal/complex"

a, b, h, m = gets.to_s.split.map(&.to_i64)

# 短針の角度、12時間=720分で２π＝τ
minute = (h * 60 + m) % 720
deg_short = Math::TAU * minute / 720

# 短針の位置（複素平面上）
z_short = Complex(Float64).from_poler(deg_short, a)

# 長針の角度、60分でτ
deg_long = Math::TAU * m / 60
z_long = Complex(Float64).from_poler(deg_long, b)

ans = (z_long - z_short).abs
pp ans
