import java.util.*;

public class Main {
  public static void main(String[] g) {
    Scanner sc = new Scanner(System.in);
    int n = sc.nextInt();
    int a[] = new int[n];
    for (int i = 0; i < n; i++) {
      a[i] = sc.nextInt();
    }
    int ans = 0;
    for (int i = 0; i < n; i++) {
      int b = sc.nextInt();
      ans += b * a[i];
    }
    System.out.println(ans == 0 ? "Yes" : "No");
  }
}