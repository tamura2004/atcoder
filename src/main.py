st = list(input())
x = 0
y = 0

for ch in st:
    if ch == 'L':
        x -= 1
    elif ch == 'R':
        x += 1
    elif ch == 'U':
        y += 1
    elif ch == 'D':
        y -= 1
    else:
        print("bad char: {}".format(ch))

print("{} {}".format(x, y))
