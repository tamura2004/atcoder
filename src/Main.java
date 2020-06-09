import java.util.*;

public class Main {
  public static void main(final String[] args) throws Exception {
    final Scanner scanner = new Scanner(System.in);
    try {
      int n = scanner.nextInt();
      int m = scanner.nextInt();

      Station[] g = new Station[n];
      for (int i = 0; i < n; i++) g[i] = new Station();
      
      for (int i = 0; i < m; i++) {
        int a = scanner.nextInt();
        int b = scanner.nextInt();
        int c = scanner.nextInt();
        a--;
        b--;
        g[a].add(c);
        g[b].add(c);
      }

      long ans = 0;
      for (int i = 0; i < n; i++) {
        ans += g[i].getCount();
      }
      System.out.println(ans);
    } finally {
      scanner.close();
    }
  }
}

class Station {
  long count;
  Map<Integer,Integer> g;

  public Station() {
    count = 0;
    g = new HashMap<Integer,Integer>();
  }

  public void add(int a) {
    if (g.containsKey(2540 - a)) count += g.get(2540 - a);
    int v = 1;
    if (g.containsKey(a)) v += g.get(a);
    g.put(a, v);
  }

  public long getCount() {
    return count;
  }

  public void show() {
    System.out.println("--");
    System.out.println(count);
    for (int key : g.keySet()) {
      System.out.println(key + " => " + g.get(key));
    }
  }
}
