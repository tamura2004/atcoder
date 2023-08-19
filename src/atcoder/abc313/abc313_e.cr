require "crystal/modint9"

n = gets.to_s.to_i64
s = gets.to_s.chars.map(&.to_i)

quit -1 if (n - 1).times.any? { |i| s[i] >= 2 && s[i + 1] >= 2 }

# RunLength圧縮
rl = s.chunks(&.itself).map { |i, arr| {i, arr.size} }

ans = 0.to_m
last = 1

while rl.size > 0
  code, num = rl.pop

  if code == 1
    ans += ans * (last - 1) + num
  else
    ans += 1
  end

  last = code
end

pp ans - 1
