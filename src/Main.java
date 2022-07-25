import java.util.*;

class UnionFind {
  int[] par;

  UnionFind(int n) {
    par = new int[n];
    for (var i = 0; i < n; i++) {
      par[i] = i;
    }
  }

  public int root(int v) {
    return par[v] = par[v] == v ? v : root(par[v]);
  }

  public boolean same(int v, int nv) {
    return root(v) == root(nv);
  }

  public void unite(int v, int nv) {
    v = root(v);
    nv = root(nv);
    if (v != nv) par[v] = nv;
  }
}

public class Main {
  public static void main(String[] g) {
    var sc = new Scanner(System.in);
    var n = sc.nextInt();
    var q = sc.nextInt();
    
    var uf = new UnionFind(n);

    for (var i = 0; i < q; i++) {
      var t = sc.nextInt();
      var v = sc.nextInt();
      var nv = sc.nextInt();

      if (t == 0) {
        uf.unite(v, nv);
      } else {
        var ans = uf.same(v, nv) ? "Yes" : "No";
        System.out.println(ans);
      }
    }

    sc.close();
  }
}