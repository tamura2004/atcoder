import java.util.Scanner;

public class Main {
  public static void main(String[] args) {
    Scanner sc = new Scanner(System.in);
    int n = sc.nextInt();
    int pre = sc.nextInt();
    for (int i = 0; i < n - 1; i++) {
      int now = sc.nextInt();
      if (now < pre) {
        System.out.printf("down %d\n", pre - now);

      } else if (now == pre) {
        System.out.println("stay");
        
      } else {
        System.out.printf("up %d\n", now - pre);
      }
      pre = now;
    }
  } 
}
