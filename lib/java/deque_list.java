import java.util.*;

public class Main {
  public static void main(String[] args) {
    Main main = new Main();
    main.solve();
    main.show();
  }

  List<Deque<Integer>> a;
  int ans;
  int turn = 0;
  boolean win = false;
  static final int A = 0;
  static final int B = 1;
  static final int C = 2;
  static final int N = 3;

  public Main() {
    Scanner sc = new Scanner(System.in);
    try {
      a = new ArrayList<Deque<Integer>>();
      a.add(read(sc));
      a.add(read(sc));
      a.add(read(sc));
    } finally {
      sc.close();
    }
  }

  private static Deque<Integer> read(Scanner sc) {
    Deque<Integer> ans = new ArrayDeque<Integer>();
    String s = sc.next();
    int n = s.length();
    for (int i = 0; i < n; i++) {
      if (s.charAt(i) == 'a' ) ans.addLast(A);
      if (s.charAt(i) == 'b' ) ans.addLast(B);
      if (s.charAt(i) == 'c' ) ans.addLast(C);
    }
    return ans;
  }
  
  void solve() {
    while (!win) play();
  }

  void play() {
    if (a.get(turn).size() == 0) {
      win = true;
      ans = turn;
      return;
    }
    turn = a.get(turn).pollFirst();
  }

  void show() {
    if (ans == A) System.out.println("A");
    if (ans == B) System.out.println("B");
    if (ans == C) System.out.println("C");
  }
}
