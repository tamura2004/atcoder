from collections import deque

UP = 1
DOWN = 2
LEFT = 3
RIGHT = 4
STOP = 5

h, w = [int(s) for s in input().split()]
g = [input() for _ in range(h)]
q = deque()
q.append((1,1,STOP))
seen = [[set() for _ in range(w)] for _ in range(h)]
seen[1][1].add(STOP)

while len(q) > 0:
  y, x, dir = q.popleft()

  for dy, dx, ndir in [(-1,0,UP),(1,0,DOWN),(0,-1,LEFT),(0,1,RIGHT)]:
    if dir != STOP and dir != ndir:
      continue
    
    ny = y + dy
    nx = x + dx

    if g[ny][nx] == "#":
      if dir != STOP:
        q.append((y,x,STOP))
      continue
    
    if g[ny][nx] == "#":
      continue
    
    if ndir in seen[ny][nx]:
      continue
    
    seen[ny][nx].add(ndir)
    q.append((ny, nx, ndir))

print(sum([int(len(x) > 0) for row in seen for x in row]))