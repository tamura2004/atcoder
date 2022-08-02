import java.util.*;

public class Main {
  public static void main(String[] g) {
    var sc = new Scanner(System.in);
    String st = sc.next();
    int x = 0;
    int y = 0;

    for (String ch : st.split("")) {
      switch(ch) {
        case "L":
          x--;
          break;
        case "R":
          x++;
          break;
        case "U":
          y++;
          break;
        case "D":
          y--;
          break;
        default:
          System.out.printf("bad char: %s\n", ch);
      }
    }
    System.out.printf("%d %d\n", x, y);
    sc.close();
  }
}