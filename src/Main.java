import java.util.*;

public class Main {
  public static void main(String[] g) {
    Scanner sc = new Scanner(System.in);
    int n = sc.nextInt();
    int k = sc.nextInt();
    System.out.println(k == 1 ? 0 : n - k);
  }
}