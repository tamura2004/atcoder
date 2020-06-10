import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;

public class Main {
  public static void main(final String[] args) throws Exception {
    final Scanner scanner = new Scanner(System.in);
    try {
      String s = scanner.next();
      DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy/MM/dd");
      LocalDate date = LocalDate.parse(s, formatter);

      while (true) {
        int y = date.getYear();
        int m = date.getMonthValue();
        int d = date.getDayOfMonth();
        if (y % m == 0 && (y / m) % d == 0) {
          System.out.println(date.format(formatter));
          return;
        }
        date = date.plusDays(1);
      }
    } finally {
      scanner.close();
    }
  }
}
