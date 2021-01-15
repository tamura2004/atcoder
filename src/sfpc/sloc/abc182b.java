import java.util.Scanner;

public class Main {
	public static void main(String[] args) throws Exception {
        Scanner sc = new Scanner(System.in);
        Main m = new Main(sc);
        m.show(m.solve());
        sc.close();
    }

	//フィールド
    Scanner sc;
    int N;
    int[] A;

    //入力
    Main(Scanner sc) {
        this.sc = sc;
        this.N = sc.nextInt();
        this.A = new int[N];
        for (int i = 0; i < N; i++) {
        	this.A[i] = sc.nextInt();
        }
    }

    //解答処理
    private int solve() {
        int answer = 0;
        int count = 0;
        int gdc = 0;
        for (int j = 2; j <= 1000; j++) {
        	count = 0;
        	for (int i = 0; i < N; i++) {
        		if (A[i] % j == 0) {
        			count++;
        		}
        	}
        	if (count > gdc) {
        		gdc = count;
        		answer = j;
        	}
        }
      	return answer;
    }

    //出力
    public void show(int answer) {
        System.out.println(answer);
    }

}