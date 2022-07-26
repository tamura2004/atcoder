import "dart:io";

class UnionFind {
  List<int> par;

  UnionFind(int n) {
    par = new List.generate(n, (i) => i);
  }
  
  int root(int v) {
    return par[v] = par[v] == v ? v : this.root(par[v]);
  }

  bool same(int v, int nv) {
    return this.root(v) == this.root(nv);
  }

  void unite(int v, int nv) {
    par[this.root(v)] = this.root(nv);
  }

}

void main() {
  var args = stdin.readLineSync().split(" ").map(int.parse).toList();
  var n = args[0];
  var q = args[1];
  var uf = new UnionFind(n);

  for(int i = 0; i < q; i++) {
    var args = stdin.readLineSync().split(" ").map(int.parse).toList();
    var t = args[0];
    var v = args[1];
    var nv = args[2];

    if (t == 0) {
      uf.unite(v, nv);
    } else {
      print(uf.same(v, nv) ? "Yes" : "No");
    }
  }
}
