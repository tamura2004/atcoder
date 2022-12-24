import java.util.List;
import java.util.ArrayList;
import java.util.function.Consumer;

/**
 * 無向グラフ
 */
class Graph {
  int n;
  List<List<Integer>> g;
  int[] colors;

  Graph(int n) {
    this.n = n;
    this.g = new ArrayList<>();
    for (int i = 0; i < n; i++) {
      g.add(new ArrayList<>());
    }
    this.colors = new int[n];
    for (int i = 0; i < n; i++) {
      colors[i] = -1;
    }
  }

  public void add(int v, int nv) {
    v--;
    nv--;
    g.get(v).add(nv);
    g.get(nv).add(v);
  }

  // usage:
  // color = 0;
  // g.each(v -> {
  //   if (colors[v] != -1)
  //     return;
  //   dfs(v, color);
  //   color += 2;
  // });
  public void each(Consumer<Integer> func) {
    for (int v = 0; v < n; v ++) {
      func.accept(v);
    }
  }

  // usage:
  // g.each(v, nv -> {
  //   if (colors[nv] == color) {
  //     System.out.println(0);
  //     System.exit(0);
  //   }
  //   if (colors[nv] == (color ^ 1))
  //     return;
  //   dfs(nv, color ^ 1);
  // });
  public void each(int v, Consumer<Integer> func) {
    for (int nv : g.get(v)) {
      func.accept(nv);
    }
  }
}
