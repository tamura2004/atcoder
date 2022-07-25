use std::io::*;
use std::str::FromStr;

fn read<T: FromStr>() -> T {
    let stdin = stdin();
    let stdin = stdin.lock();
    let token: String = stdin
        .bytes()
        .map(|c| c.expect("filed to read char") as char)
        .skip_while(|c| c.is_whitespace())
        .take_while(|c| !c.is_whitespace())
        .collect();
    token.parse().ok().expect("failed to parse token")
}

struct UnionFind {
    par: Vec<usize>,
    rank: Vec<usize>,
}

impl UnionFind {
    fn new(n: usize) -> Self {
        UnionFind {
            par: (0..n).collect(),
            rank: vec![1; n],
        }
    }

    fn root(&mut self, v: usize) -> usize {
        if self.par[v] == v {
            return v;
        }
        self.par[v] = self.root(self.par[v]);
        self.par[v]
    }

    fn same(&mut self, v: usize, y: usize) -> bool {
        self.root(v) == self.root(y)
    }

    fn unite(&mut self, mut v: usize, mut nv: usize) -> bool {
        v = self.root(v);
        nv = self.root(nv);

        if v == nv {
            return false;
        }

        if self.rank[v] < self.rank[nv] {
            std::mem::swap(&mut v, &mut nv);
        }

        self.par[nv] = v;
        self.rank[v] += self.rank[nv];
        true
    }
}

fn main() {
    let n: usize = read();
    let m: usize = read();
    let mut uf = UnionFind::new(n);
    let yesno: Vec<&str> = vec!["No", "Yes"];

    for _ in 0..m {
        let t: usize = read();
        let v: usize = read();
        let nv: usize = read();

        if t == 0 {
            uf.unite(v, nv);
        } else {
            println!("{}", yesno[uf.same(v, nv) as usize]);
        }
    }
}
