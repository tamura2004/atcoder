import java.util.*;

class Reader {
  Scanner sc = new Scanner(System.in);

  public int ini() {
    return sc.nextInt();
  }

  public String ins() {
    return sc.next();
  }

  public String insl() {
    return sc.nextLine();
  }

  public void skip() {
    sc.nextLine();
  }

  public int[] vi(int n) {
    int[] a = new int[n];
    for (int i = 0; i < n; i++) a[i] = sc.nextInt();
    return a;
  }

  public long[] vl(int n) {
    long[] a = new long[n];
    for (int i = 0; i < n; i++) a[i] = sc.nextLong();
    return a;
  }

  public String[] vsl(int n) {
    String[] a = new String[n];
    for (int i = 0; i < n; i++) a[i] = sc.nextLine();
    return a;
  }
}

public class Main extends Reader {
  public static void main(String[] args) {
    Main main = new Main();
    main.show(main.solve());
  }

  int n;
  int a[];

  public Main() {
    n = ini();
    a = vi(n);
  }
  
  int solve() {
    int ans = 0;
    for (int i = 0; i < n; i++) {
      ans += a[i];
    }
    return ans;
  }

  void show(int ans) {
    System.out.println(ans);
  }
}