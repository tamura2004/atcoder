import java.util.*;

public class Main {
  public static void main(String[] args) {
    Scanner sc = new Scanner(System.in);
    try {
      String s = sc.next();
      String[] a = s.split("\\+");
      int ans = 0;
      for (int i = 0; i < a.length; i++) {
        if (!a[i].matches(".*0.*")) {
          ans++;
        }
      }
      System.out.println(ans);
    } finally {
      sc.close();
    }
  }
}
