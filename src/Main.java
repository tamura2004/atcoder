import java.util.*;

class Reader {
  Scanner sc = new Scanner(System.in);

  public int ini() {
    return sc.nextInt();
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
    // main.debug();
  }

  int n;
  int l;
  String a[];
  String b;
  int ans[];

  public Main() {
    n = ini();
    l = ini();
    skip();
    a = vsl(l);
    b = insl();
    ans = new int[n];
    for (int i = 0; i < n; i++) ans[i] = i + 1;
  }
  
  int solve() {
    for (int i = 0; i < l; i++) {
      for (int j = 0; j < n - 1; j++) {
        if (a[i].charAt(j*2+1) == '-') swap(j, j+1);
      }
    }
    return ans[goal()];
  }
  
  void swap(int i, int j) {
    ans[i] ^= ans[j];
    ans[j] ^= ans[i];
    ans[i] ^= ans[j];
  }

  int goal() {
    for (int i = 0; i < n; i++) {
      if (b.charAt(i*2) == 'o') return i;
    }
    return -1;
  }

  void show(int ans) {
    System.out.println(ans);
  }

  void debug() {
    System.out.printf("n=%d,l=%d\n", n, l);
    for (int i = 0; i < l; i++) {
      System.out.println(a[i]);
    }
    System.out.println(b);
    System.out.println(goal());
  }
}
