x = 2 ** 122
y = x - 1000

pp x
pp y

ans = 1.0
1000.times do
    ans *= x
    ans /= y
    x -= 1
    y -= 1
end

pp ans
