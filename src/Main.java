import java.util.*;

public class Main {
  public static void main(String[] args) {
    Scanner sc = new Scanner(System.in);
    int n = sc.nextInt();
    int a[] = new int[n];

    for (int i = 0; i < n; i++) {
      int j = sc.nextInt();
      a[j-1] += 1;
    }

    int dup = -1;
    int none = -1;
    for (int i = 0; i < n; i++) {
      if (a[i] == 2) {
        dup = i + 1;
      } else if (a[i] == 0) {
        none = i + 1;
      }
    }

    if (dup != -1) {
      System.out.printf("%d %d\n", dup, none);
    } else {
      System.out.println("Correct");
    }
  } 
}
