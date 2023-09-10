import java.util.Scanner;

// 成長薬
class Potion {
  public int id; // 番号
  public int hp; // 成長量

  Potion(int id, int hp) {
    this.id = id;
    this.hp = hp;
  }
}

class Main {
  public static void main(final String[] args) throws Exception {
    Scanner sc = new Scanner(System.in);
    int n = sc.nextInt(); // 成長薬の本数
    int h = sc.nextInt(); // モンスターの体力
    int x = sc.nextInt(); // 目標値

    // 成長薬を読み込んで初期化
    Potion[] potions = new Potion[n];
    for (int i = 0; i < n; i++) {
      int hp = sc.nextInt();
      potions[i] = new Potion(i+1, hp);
    }

    // 条件を満たす最初の傷薬を探す
    int ans = -1;
    for (Potion potion: potions) {
      if (ans == -1 && x <= h + potion.hp) {
        ans = potion.id;
      }
    }
    System.out.println(ans);
  }
}
