// import java.util.*;

// // 背の順
// // https://atcoder.jp/contests/abc041/tasks/abc041_c
 
// class Reader {
//   Scanner sc = new Scanner(System.in);
 
//   public int ini() {
//     return sc.nextInt();
//   }
 
//   public int[] vi(int n) {
//     int[] a = new int[n];
//     for (int i = 0; i < n; i++) a[i] = sc.nextInt();
//     return a;
//   }
 
//   public long[] vl(int n) {
//     long[] a = new long[n];
//     for (int i = 0; i < n; i++) a[i] = sc.nextLong();
//     return a;
//   }
// }
 
// public class Main extends Reader {
//   public static void main(String[] args) {
//     Main main = new Main();
//     main.show(main.solve());
//   }
 
//   int n;
//   int[] a;
//   TreeMap<Integer, Integer> ans;
 
//   public Main() {
//     n = ini();
//     a = vi(n);
//   }
  
//   TreeMap<Integer, Integer> solve() {
//     ans = new TreeMap<Integer, Integer>();
//     for (int i = 0; i < n; i++) {
//       ans.put(-a[i], i + 1);
//     }
//     return ans;
//   }
 
//   void show(TreeMap<Integer, Integer> ans) {
//     for (int key: ans.keySet()) {
//       System.out.println(ans.get(key));
//     }
//   }
// }
