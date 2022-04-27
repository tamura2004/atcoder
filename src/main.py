from collections import deque

class Dinic:
    def __init__(self, n):
        self.n = n
        self.links = [[] for _ in range(n)]
        self.depth = None
        self.progress = None
 
    def add_link(self, _from, to, cap):
        self.links[_from].append([cap, to, len(self.links[to])])
        self.links[to].append([0, _from, len(self.links[_from]) - 1])
 
    def bfs(self, s):
        depth = [-1] * self.n
        depth[s] = 0
        q = deque([s])
        while q:
            v = q.popleft()
            for cap, to, rev in self.links[v]:
                if cap > 0 and depth[to] < 0:
                    depth[to] = depth[v] + 1
                    q.append(to)
        self.depth = depth
 
    def dfs(self, v, t, flow):
        if v == t:
            return flow
        links_v = self.links[v]
        for i in range(self.progress[v], len(links_v)):
            self.progress[v] = i
            cap, to, rev = link = links_v[i]
            if cap == 0 or self.depth[v] >= self.depth[to]:
                continue
            d = self.dfs(to, t, min(flow, cap))
            if d == 0:
                continue
            link[0] -= d
            self.links[to][rev][0] += d
            return d
        return 0
 
    def max_flow(self, s, t):
        flow = 0
        while True:
            self.bfs(s)
            if self.depth[t] < 0:
                return flow
            self.progress = [0] * self.n
            current_flow = self.dfs(s, t, float('inf'))
            while current_flow > 0:
                flow += current_flow
                current_flow = self.dfs(s, t, float('inf'))
        
n = int(input())
s = 16000
g = 16001
se = set()
v = set()
for i in range(n):
    X, Y, Z = map(int, input().split())
    for x in range(1, X):
        x2 = X - x
        t1 = x * Y * Z
        t2 = x2 * Y * Z + 8000
        se.add(f"{t1}-{t2}")
        se.add(f"{s}-{t1}")
        se.add(f"{t2}-{g}")
        v.add(t1)
        
    for y in range(1, Y):
        y2 = Y - y
        t1 = X * y * Z
        t2 = X * y2 * Z + 8000
        se.add(f"{t1}-{t2}")
        se.add(f"{s}-{t1}")
        se.add(f"{t2}-{g}")
        v.add(t1)
        
    for z in range(1, Z):
        z2 = Z - z
        t1 = X * Y * z
        t2 = X * Y * z2 + 8000
        se.add(f"{t1}-{t2}")
        se.add(f"{s}-{t1}")
        se.add(f"{t2}-{g}")
        v.add(t1)
        
G = Dinic(16002)
for x in se:
    t1, t2 = map(int, x.split("-"))
    G.add_link(t1, t2, 1)
    
print(len(v) * 2 - G.max_flow(s, g))
