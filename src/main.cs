using System;

public class UnionFind {
  public int[] par;

  public UnionFind(int n) {
    par = new int[n];
    for (int i = 0; i < n; i++) {
      par[i] = i;
    }
  }

  public int root(int v) {
    if (v == par[v]) return v;
    par[v] = root(par[v]);
    return par[v];
  }

  public bool same(int v, int nv) {
    return root(v) == root(nv);
  }

  public void unite(int v, int nv) {
    v = root(v);
    nv = root(nv);
    if (v != nv) par[v] = nv;
  } 
}

class Program {
  static void Main (string[] args) {
    var input = Console.ReadLine().Split(' ');
    var n = int.Parse(input[0]);
    var q = int.Parse(input[1]);
    var uf = new UnionFind(n);

    for (var i = 0; i < q; i++) {
      input = Console.ReadLine().Split(' ');
      var ty = int.Parse(input[0]);
      var v = int.Parse(input[1]);
      var nv = int.Parse(input[2]);

      if (ty == 0) {
        uf.unite(v, nv);
      } else {
        if (uf.same(v, nv)) {
          Console.WriteLine("Yes");
        } else {
          Console.WriteLine("No");
        }
      }
    }
  }
}