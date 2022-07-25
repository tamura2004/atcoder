class UnionFind:
    def __init__(self, n):
        self.par = [i for i in range(n)]

    def root(self, v):
        if self.par[v] == v:
            return v
        else:
            ret = self.root(self.par[v])
            self.par[v] = ret
            return ret

    def same(self, v, nv):
        return self.root(v) == self.root(nv)

    def unite(self, v, nv):
        v = self.root(v)
        nv = self.root(nv)
        if v != nv:
            self.par[v] = nv

n, q = map(int, input().split())
uf = UnionFind(n)

for _ in range(q):
    t, v, nv = map(int, input().split())
    if t == 0:
        uf.unite(v, nv)
    else:
        if uf.same(v, nv):
            print("Yes")
        else:
            print("No")